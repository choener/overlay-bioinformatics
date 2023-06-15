{
  description = ''
    Collection of bioinformatics-related tools. We provide both, an overlay, and apps.
    Slowly being turned into a flake.
  '';

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: let
    overlay = final: prev: {
      Rscape = final.callPackage ./Rscape {};
    };
  in
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; overlays = [ self.overlay ]; };
      sharedBuildInputs = with pkgs; [  ];
    in {
      devShell = pkgs.mkShell rec {
      };
      packages = {
        R-scape = pkgs.Rscape;
      };
    }) // { inherit overlay; };
}

