{config, lib,...}:

let
  cfg = config.modules.system.shells;
in
{
  options.modules.system.shells = {
    enable = lib.mkEnableOption "Enable the zsh and fish custom configs";
  };

  config = lib.mkIf cfg.enable{
    programs.zsh.ohMyZsh = {
      enable = true;
      plugins = ["git" "docker" ""];
      theme = "Soliah";
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      shellAliases ={
        ll = "ls -la";
        nrs = "sudo nixos-rebuild switch --upgrade --flake ~/Other/dotfiles/#monarch";
      };
    };

    programs.fish = {
      enable = true;

    };
  };
}
