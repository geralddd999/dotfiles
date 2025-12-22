{config, pkgs, ...}:

{
  services.auto-cpufreq.enable = true;

  services.auto-cpufreq.settings = {
    charger = {turbo = "auto"; };

    battery = {governor = "powersave"; turbo = "never"; };

  };
}
