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
      locarna19 = final.callPackage ./locarna/19.nix {};
      viennarna24 = final.callPackage ./viennarna/24.nix {};
      viennarna25 = final.callPackage ./viennarna/25.nix {};
      viennarna26 = final.callPackage ./viennarna/26.nix {};
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
        inherit (pkgs) viennarna24 viennarna25 viennarna26;
        inherit (pkgs) locarna19;
      };
    }) // { inherit overlay; };
}

