{ stdenv, fetchurl, gmp, autoPatchelfHook }:

let
#  pkgs = import <nixpkgs> {};
#  # fix idn to be able to successfully patch libidn
#  libidn = pkgs.libidn.overrideAttrs (oldAttrs: rec {
#    name = "libidn-1.34";
#    src = fetchurl {
#      url = "mirror://gnu/libidn/libidn-1.34.tar.gz";
#      # sha256 = "068fjg2arlppjqqpzd714n1lf6gxkpac9v5yyvp1qwmv6nvam9s4"; # 33
#      sha256 = "0g3fzypp0xjcgr90c5cyj57apx1cmy0c6y9lvw2qdcigbyby469p"; # 34
#    };
#  });
in

stdenv.mkDerivation rec {
  version = "0.0.1";
  name = "cmcompare-varbin-${version}";

  src = ./cmcompare.gz;

  unpackPhase = ''
    cp $src cmcompare.gz
    gunzip cmcompare.gz
    chmod +x cmcompare
  '';

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [ gmp ]; # zlib bzip2 libidn ];

  buildPhase = ":";

  # if we strip, then patchelf does not work right
  dontStrip = true;

  installPhase = ''
    mkdir -p $out/bin
    cp cmcompare $out/bin/
  '';

  meta = {
    description = "CMCompare binary";
    longDescription = ''
      none
    '';
    homepage = https://www.tbi.univie.ac.at/software/cmcompare/;
    #license = ;
    maintainers = [  ];
    platforms = stdenv.lib.platforms.linux;
  };

}
