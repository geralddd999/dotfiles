{
  description = "Installing Quickshell and Zen-Browser";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:quickshell-mirror/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, quickshell, zen, apple-fonts, stylix, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
    in
    {
      homeConfigurations."geronimo" = home-manager.lib.homeManagerConfiguration {

        inherit pkgs;

        modules = [
          ./home.nix
          stylix.homeModules.stylix
          {
            _module.args = { inherit apple-fonts; };

            home.packages = [
              quickshell.packages.${system}.default
              zen.packages.${system}.default

            ];
          }

        ];
      };

    };

}
