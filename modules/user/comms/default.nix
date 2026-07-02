{config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.comms;
in
{
  options.userSettings.comms = {
    enable = lib.mkEnableOption "Enable communication programs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
      beeper
    ];
  };
}
