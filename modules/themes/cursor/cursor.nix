{ pkgs,
  config,
  ... }:

let
    appleCursors = pkgs.stdenv.mkDerivation rec {
        pname = "appleCursors";
        version = "1.0";
        src = ./apple-cursors.tar.xz;

        installPhase = ''
            runHook preInstall
            local themeDir="$out/share/icons/appleCursors"
            mkdir -p "$themeDir"
            cp -r ./* "$themeDir/"
            runHook postInstall
        '';
    };
    cfg = config.userSettings.themes.cursor;

in
{
    home.packages = [appleCursors];
    gtk.cursorTheme = {
        name = "appleCursors";
        size = 24;
    };

    home.pointerCursor = {
        name = "appleCursors";
        size = 24;
        package = appleCursors;
        x11.enable = true;
        gtk.enable = true;
    };

    dconf.settings = {
        "org.gnome.desktop.interface" = {
            cursor-theme = "appleCursors";
            cursor-size = 24;
        };
    };
}
