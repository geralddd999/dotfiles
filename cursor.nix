{ pkgs, ... }:

let 
    appleCursors = pkgs.stdenv.mkDerivation rec {
        pname = "appleCursors";
        version = "1.0";
        src = ./apple-cursors.tar.gz;

        installPhase = ''
            runHook preInstall
            local themeDir = "$out/share/icons/appleCursors"
            mkdir -p "$themeDir"
            cp -r ./* "$themeDir/"
            runHook postInstall
        '';
    };

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