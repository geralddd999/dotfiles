{ config, pkgs, lib, inputs, apple-fonts, ... }:

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
    #quickshell
    matugen
    glib
    gnome-text-editor
    powertop
    fastfetch
    libgtop
    gsettings-desktop-schemas
    fish
    btop
    nodejs
    python3
    cargo
    lshw
    gnumake
    ripgrep
    fd
    unzip
    libsoup_3
    upower
    dart-sass
    #networking and others
    bluez
    bluez-tools
    # Gnome related stuff +File manager:
    nautilus
    cheese
    gnome-music
    easyeffects
    gnome-photos
    gnome-characters
    # git related
    gh
    git
    #Wayland related pkgs:
    grim
    slurp
    wl-clipboard
    wtype
    pamixer
    mako
    #syntax highlighting
    kdePackages.syntax-highlighting

    #qt5
    qt5.qtbase
    qt5.qtdeclarative
    qt5.qtgraphicaleffects
    qt5.qtimageformats
    qt5.qtsvg
    qt5.qttranslations
    kdePackages.qt5compat
    #qt6 
    (hiPrio qt6Packages.qtdeclarative)
    (hiPrio qt6Packages.qttranslations)
    qt6Packages.qtbase
    qt6Packages.qtdeclarative
    qt6Packages.qtwayland
    qt6Packages.qtsvg
    qt6Packages.qtimageformats
    qt6Packages.qtmultimedia
    qt6Packages.qtpositioning
    qt6Packages.qtquicktimeline
    qt6Packages.qtsensors
    qt6Packages.qttools
    qt6Packages.qttranslations
    qt6Packages.qtvirtualkeyboard
    qt6Packages.qt5compat
    #Other
    hyprshell
    grimblast
    #Hyprland plugins + other dependencies
    swww
    grim
    wlogout
    wofi
    playerctl
    hyprpanel
    nwg-look
    hyprpaper
    brightnessctl
    #dev/nonfree
    vscode
    microsoft-edge
    #Word-processing / school related
    obsidian
    onlyoffice-bin
    libreoffice-qt
    hunspell
    #fonts
    meslo-lgs-nf
    liberation_ttf
    apple-fonts.packages.${pkgs.system}.sf-pro
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
  fonts.fontconfig.enable = true;
  stylix.fonts = {
    serif = {
      package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
      name = "SFProDisplay Nerd Font";
    };
  };
  programs.waybar = {
    enable = true;
    #style = ./waybar/style.css;
    settings = {
      main = builtins.fromJSON (builtins.readFile ./waybar/config);
    };
    style = builtins.readFile ./waybar/style.css;

  };
  xdg.configFile."quickshell" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/quickshell";
    recursive = true;
  };
  #Git config
  programs.git = {
    enable = true;
    userName = "Gerald Chambi";
    userEmail = "chambigerald@hotmail.com";
  };

  programs.fish = { enable = true; };
  #Appearence config [GNOME]
  gtk = {
    enable = true;

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };

    gtk4.extraConfig = {
      gtk-theme-name= "adw-gtk3-dark";
      gtk-icon-theme-name= "Adwaita";
      gtk-font-name= "SF Pro 11";
      gtk-cursor-theme-name= "Adwaita";
      gtk-cursor-theme-size= 24;
      gtk-application-prefer-dark-theme= 1;
      
    };

    gtk3.extraConfig = {
      gtk-theme-name= "adw-gtk3-dark";
      gtk-icon-theme-name= "Adwaita";
      gtk-font-name= "SF Pro 11";
      gtk-cursor-theme-name= "Adwaita";
      gtk-cursor-theme-size= 24;
      gtk-application-prefer-dark-theme= 1;
      
    };

    gtk3.extraCss = builtins.readFile ./gtk/gtk-3.0/gtk.css;
    gtk4.extraCss = builtins.readFile ./gtk/gtk-4.0/gtk.css;
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
    ".config/wofi/colors.css" = { source = ./wofi/colors.css; };
    #Gtk related stuff
    ".config/gtk-4.0/colors.css" = { source = ./gtk/gtk-4.0/colors.css; };
    ".config/gtk-3.0/colors.css" = { source = ./gtk/gtk-3.0/colors.css; };
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
    QML_IMPORT_PATH = "${pkgs.quickshell}/lib/qt-6/qml";
    QML2_IMPORT_PATH = "${pkgs.quickshell}/lib/qt-6/qml";
    # EDITOR = "emacs";
  };
  home.sessionPath = [
    "/run/current-system/sw/bin/hyprland"
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
