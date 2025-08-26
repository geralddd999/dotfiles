# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nvidia.nix
      ./auto-cpufreq.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "monarch"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

#Enabling Flakes in Nix
nix.settings.experimental-features = ["nix-command" "flakes"];

#Enabling non-free packages 
nixpkgs.config.allowUnfree = true;
#Configuring Hardware-Acceleration
hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
	intel-media-driver
	#with pkgs.pkgsi686Linux; intel-vaapi-driver #32-bit support intel driver
	intel-vaapi-driver
	libvdpau-va-gl
	mesa libva-utils vulkan-tools

    ];
};

environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
};
# Hyprland config
  programs.hyprland = {
   enable = true;
   xwayland.enable = true;
   withUWSM = true ;
};
  environment.sessionVariables = {
   NIXOS_OZONE_WL = "1";
};

#Configuring the xdg-portal for hyprland
services.dbus.enable = true;

xdg.portal = {
    enable = true;
    wlr.enable = true;
    #extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    #extraPortals = [pkgs.xdg-desktop-portal-wlr];
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
};

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
 services.pipewire = {
   enable = true;
   pulse.enable = true;
   alsa.enable = true;
   alsa.support32Bit = true;
   wireplumber.enable = true;
 };

  hardware.bluetooth.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
 users.users.geronimo = {
   isNormalUser = true;
   extraGroups = [ "wheel" "video" "input" "networkmanager" "wayland"]; # Enable ‘sudo’ for the user.
   packages = with pkgs; [
     tree
   ];
   shell = pkgs.fish;
 };


#Enable power management
powerManagement.enable = true;

programs.firefox.enable = true;
programs.fish.enable = true;
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
 environment.systemPackages = with pkgs; [
   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   wget gcc
   neovim
   # DE dependencies
   kitty
   foot
   hyprland uwsm
   swww
   dunst meson
   wayland-protocols wayland-utils
   wl-clipboard wlroots
   xdg-desktop-portal-gtk
   xdg-desktop-portal-hyprland hyprland-protocols
   xdg-user-dirs
   xwayland hyprsunset
   hyprlock libnotify hyprpicker
   hypridle hyprcursor
   hyprpolkitagent 

   # app-launchers
   rofi-wayland

   # audio-controls
   pavucontrol 
   pipewire

   #Fonts
   #(nerd-fonts.override {fonts = ["FiraCode"]; })
 ];

#GNOME related stuff
services.gnome.gnome-keyring.enable = true; 
services.gvfs.enable = true; 
#Sunshine setup
 services.sunshine = {
	enable = true;
	autoStart = true;
	capSysAdmin = true;
	openFirewall = true;
 };

#Tailscale setup
services.tailscale.enable = true;
 # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

