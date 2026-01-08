{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.stdenv.cc.cc.lib
  ];

  nativeBuildInputs = [
    (pkgs.python3.withPackages (ps: [
      ps.pillow
      ps.materialyoucolor
    ]))
  ];

  shellHook = ''
    echo "Entered nix python venv for theming"
  '';
}

