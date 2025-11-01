{ pkgs, ... }:

let
  username = "geronimo";
  matlabPassword = "matlab";
  matlabVersion = "latest";
  
  containerName = "matlab-vnc";
  matlabImage = "mathworks/matlab:${matlabVersion}";

  matlabDataPath = "/home/${username}/Documents/matlab-data";
  matlabConfigPath = "/home/${username}/Documents/matlab-config";
  
in {

  #Launcher script
  home.file.".local/bin/launch-matlab.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      CONTAINER_NAME="${containerName}"
      
      if [ ! "$(docker ps -a -q -f name=^/${CONTAINER_NAME}$)" ]; then
        echo "--- No matlab container found, creating a new one: ${CONTAINER_NAME} ---"
        docker run -d -t \
            --name ${CONTAINER_NAME} \
            -p 5901:5901 \
            -p 6080:6080 \
            -e PASSWORD=${matlabPassword} \
            -v ${matlabDataPath}:/home/matlab/Documents/MATLAB \
            -v ${matlabConfigPath}:/home/matlab/.matlab \
            --shm-size=512M \
            ${matlabImage} -vnc > /dev/null
      else
        if [ ! "$(docker ps -q -f name=^/${CONTAINER_NAME}$)" ]; then
          echo "--- existing container found, running it ---"
          docker start ${CONTAINER_NAME} > /dev/null
        else
          echo "--- MATLAB container is already running ---"
        fi
      fi
          
      
      
      echo "--- Launching VNC Viewer. Connect to localhost:5901 ---"
      echo "--- CLOSE THE VNC WINDOW TO STOP THE CONTAINER ---"
      vncviewer localhost:5901
      
      echo "--- VNC client closed. Stopping MATLAB container ---"
      docker stop ${CONTAINER_NAME} > /dev/null
      sleep 2
    '';
  };

  #Create the .desktop file
  xdg.desktopEntries."matlab-docker" = {
    name = "MATLAB (Docker)";
    comment = "Launch MATLAB ${matlabVersion} via Docker";
    icon = "matlab";
    
    exec = "/home/${username}/.local/bin/launch-matlab.sh";
    
    terminal = false;
    categories = [ "Development" "Education" "Science" ];
  };
}