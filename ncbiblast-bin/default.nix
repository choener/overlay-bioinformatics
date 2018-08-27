{ stdenv, fetchurl, zlib, bzip2, autoPatchelfHook }:

let
  pkgs = import <nixpkgs> {};
  # fix idn to be able to successfully patch libidn
  libidn = pkgs.libidn.overrideAttrs (oldAttrs: rec {
    name = "libidn-1.34";
    src = fetchurl {
      url = "mirror://gnu/libidn/libidn-1.34.tar.gz";
      # sha256 = "068fjg2arlppjqqpzd714n1lf6gxkpac9v5yyvp1qwmv6nvam9s4"; # 33
      sha256 = "0g3fzypp0xjcgr90c5cyj57apx1cmy0c6y9lvw2qdcigbyby469p"; # 34
    };
  });
in

stdenv.mkDerivation rec {
  version = "2.7.1";
  name = "ncbiblast-bin-${version}";

  src = fetchurl {
    url = "ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-${version}+-x64-linux.tar.gz";
    sha256 = "05z97pasdl5msbbjlvx29v0d70vv7vc0p19vh69r9vmivj1l3xhx";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [ zlib bzip2 libidn ];

  buildPhase = ":";

  # if we strip, then patchelf does not work right
  dontStrip = true;

  installPhase = ''
    mkdir -p $out/bin
    cp bin/* $out/bin/
  '';

  meta = {
    description = "NCBI blast";
    longDescription = ''
      none
    '';
    homepage = https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=Download;
    #license = ;
    maintainers = [  ];
    platforms = stdenv.lib.platforms.linux;
  };

}
