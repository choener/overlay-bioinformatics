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
      #apps = {
      #  # Data source apps
      #  # VirFullAli = { type="app"; program="${pkgs.haskellPackages.VirFullAli}/bin/VirFullAli"; };
      #};
      packages = {
        Rscape = pkgs.Rscape;
        #VirFullAli = pkgs.stdenv.mkDerivation {
        #  name = "VirFullAli";
        #  sharedBuildInputs = with pkgs; [ haskellPackages.llvmPackages.llvm ];
        #  unpackPhase = ".";
        #  buildPhase = ".";
        #  installPhase = ''
        #    mkdir -p $out/bin
        #    ln -s "${pkgs.haskellPackages.VirFullAli}/bin/VirFullAli $out/bin/VirFullAli
        #  '';
        #};
      } // (if system != "x86_64-linux" then {} else {
      });
    }) // { inherit overlay; };
}

