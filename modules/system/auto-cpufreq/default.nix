{ config, lib, ... }:

let
  cfg = config.modules.system.auto-cpufreq;

in
{
  options.modules.system.auto-cpufreq = {
    enable = lib.mkEnableOption "auto-cpufreq power management";
  };

  config = lib.mkIf cfg.enable {
    services.auto-cpufreq.enable = true;

    services.auto-cpufreq.settings = {
      charger = {
        turbo = "auto";
      };

      battery = {
        governor = "powersave";
        turbo = "never";
      };
    };
  };
}
