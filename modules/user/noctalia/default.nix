{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.noctalia;
in
{
  options = {
    userSettings.noctalia = {
      enable = lib.mkEnableOption "Enable noctalia personalized config";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      digital
      graphviz
      zotero
      # S2 related stuff

    ];
    #userSettings.matlab.enable = true;
    programs.noctalia = {
      enable = true;
      
      settings ={
        wallpaper = {
          enabled = true;
        };
      };
    };
  };
}

