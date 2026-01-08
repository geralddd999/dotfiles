{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.userSettings.nvim;
  dotfilesPath = "/home/geronimo/Other/dotfiles";
  nvimConfigPath = "${dotfilesPath}/modules/user/nvim";
in
{
  options.userSettings.nvim.enable = lib.mkEnableOption "Custom Neovim config";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      neovim
      #gcc
      ripgrep
      fd
      unzip
      nodejs
      wl-clipboard
    ];

    xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink nvimConfigPath;
  };
}
