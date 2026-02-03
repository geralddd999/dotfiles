{ pkgs, config, ... }:

let
  username = "geronimo";
  matlabPassword = "matlab";
  matlabVersion = "latest";
  
  containerName = "matlab-vnc";
  matlabImage = "mathworks/matlab:${matlabVersion}";

  # Using config.home.homeDirectory ensures this works even if username changes
  matlabDataPath = "${config.home.homeDirectory}/Documents/matlab/matlab-data";
  matlabConfigPath = "${config.home.homeDirectory}/Documents/matlab/matlab-config";

  # 1. Define the script properly using writeShellScriptBin
  # We interpolate the Nix variables here, so they are "baked in" to the script
  launchMatlab = pkgs.writeShellScriptBin "launch-matlab" ''
    #!/usr/bin/env bash
    
    # Exit on error
    set -e

    CONTAINER_NAME="${containerName}"
    
    # Function to check if container exists
    container_exists() {
      ${pkgs.docker}/bin/docker ps -a -q -f name="^/${containerName}$"
    }

    # Function to check if container is running
    container_running() {
      ${pkgs.docker}/bin/docker ps -q -f name="^/${containerName}$"
    }

    if [ -z "$(container_exists)" ]; then
      echo "--- No matlab container found, creating a new one: ${containerName} ---"
      
      mkdir -p "${matlabDataPath}"
      mkdir -p "${matlabConfigPath}"
      
      # Permission fix (Standard Docker hack)
      chmod 777 "${matlabDataPath}"
      chmod 777 "${matlabConfigPath}"

      ${pkgs.docker}/bin/docker run -d -t \
          --name "$CONTAINER_NAME" \
          -p 5901:5901 \
          -p 6080:6080 \
          -e PASSWORD="${matlabPassword}" \
          -v "${matlabDataPath}:/home/matlab/Documents/MATLAB" \
          -v "${matlabConfigPath}:/home/matlab/.matlab" \
          --shm-size=512M \
          "${matlabImage}" -vnc > /dev/null
    else
      if [ -z "$(container_running)" ]; then
        echo "--- Existing container found, starting it ---"
        ${pkgs.docker}/bin/docker start "$CONTAINER_NAME" > /dev/null
      else
        echo "--- MATLAB container is already running ---"
      fi
    fi

    # FIX: Wait for VNC to actually be ready
    # Without this, vncviewer runs too fast, fails, and the script closes immediately.
    echo "Waiting for VNC server..."
    count=0
    while ! nc -z localhost 5901; do   
      sleep 1
      count=$((count+1))
      if [ $count -gt 20 ]; then
        ${pkgs.libnotify}/bin/notify-send "MATLAB" "Timeout waiting for VNC" -u critical
        exit 1
      fi
    done

    # 3. Launch VNC Viewer
    # We use pkgs.tigervnc specifically to ensure it exists
    ${pkgs.tigervnc}/bin/vncviewer localhost:5901
    
    # 4. Cleanup
    ${pkgs.docker}/bin/docker stop "$CONTAINER_NAME" > /dev/null
    ${pkgs.libnotify}/bin/notify-send "MATLAB" "Container stopped." -t 2000
  '';

in {

  # Ensure the script and its dependencies are available
  home.packages = with pkgs; [
    launchMatlab # This adds our custom script to $PATH
    tigervnc     # Needed for vncviewer
    # docker
    libnotify    # Needed for notify-send
    netcat-gnu   # Needed for the 'nc' check in the wait loop
  ];

  # Create the .desktop file
  xdg.desktopEntries."matlab-docker" = {
    name = "MATLAB (Docker)";
    comment = "Launch MATLAB ${matlabVersion} via Docker";
    icon = "matlab";
    
    # Now we can just point to the binary in the nix store
    exec = "${launchMatlab}/bin/launch-matlab";
    
    terminal = false;
    categories = [ "Development" "Education" "Science" ];
  };
}
