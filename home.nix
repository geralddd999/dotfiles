{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  

  imports = [
	./dunst.nix
	];
  home.username = "geronimo";
  home.homeDirectory = "/home/geronimo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs ;[
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    hello
    fastfetch
    btop nodejs python3
    lshw gnumake ripgrep fd unzip 
    #networking and others
    bluez bluez-tools
    # Gnome related stuff +File manager:
    nautilus cheese
    gnome-music easyeffects
    gnome-photos gnome-characters
    # git related
    gh git
    #Hyprland plugins + other dependencies
    swww grim wlogout
    wofi playerctl 
    nwg-look hyprpaper brightnessctl
    #dev/nonfree
    vscode microsoft-edge
    #Word-processing / school related
    obsidian onlyoffice-bin libreoffice-qt 
    hunspell
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  programs.waybar = {
     enable = true;
     #style = ./waybar/style.css;
     settings = {
	  main = builtins.fromJSON (builtins.readFile ~/.dotfiles/waybar/config);
	};
     style = builtins.readFile ~/.dotfiles/waybar/style.css;
   
};

#Git config
programs.git = {
     enable = true;
     userName = "Gerald Chambi";
     userEmail = "chambigerald@hotmail.com";
};

#Appearence config [GNOME]
gtk = {
     enable = true;

     iconTheme = {
	name = "Adwaita";
	package = pkgs.adwaita-icon-theme;
     };
};

#apply dark theme to gnome apps
dconf.settings = {
    "org/gnome/desktop/interface" = { 
    	color-scheme = "prefer-dark";
     	#to yet to configure the fractional scaling because i'm too lazy to actually check for it
	};
};

programs.wofi = {
    enable = true;
};

   home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/wofi/config" = { source = ./wofi/config; };
    ".config/wofi/style.css" = { source = ./wofi/style.css; };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/geronimo/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
