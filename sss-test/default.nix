{ coreutils, gnugrep, gnused, stdenv, buildEnv, lib, makeWrapper, fetchurl, perl, perlPackages, rnasnp, viennarna, muscle, R, gawk, bash }:

# docker load --input $(nix-build -E 'with import <nixpkgs> {}; pkgs.dockerTools.buildImage { name = "nix-SSS-test"; contents = pkgs.SSS-test; config = { Cmd = [ "/bin/SSS-test" ]; }; }')

# run the thing:
# docker run -i -t nix-sss-test:<cryptic-id> <optional /bin/SSS-test or /bin/SSS-local default to SSS-test>

# https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/docker/examples.nix

stdenv.mkDerivation rec {
  name = "SSS-test";

  #src = fetchurl {
  #  # url = "http://www.bioinf.uni-leipzig.de/Software/SSS-test/SSS-test.tgz";
  #  url = "./SSS-test.tgz";
  #  sha256 = "ada562701e5c3d2527da034de6ef8187fa7fc8cce39838beba457e6f6cf36078";
  #};

  src = ./SSS-test.tgz;

  replaceSSS = ./SSS.sh;
  replaceLocal = ./local.sh;

  perl5lib = "${lib.makePerlPath [ perlPackages.StatisticsR perlPackages.BioPerl perlPackages.RegexpCommon perlPackages.IPCRun ]}";
  prefixpath = "${lib.makeBinPath [ coreutils gnugrep gnused perl R rnasnp viennarna muscle gawk ]}";

  installPhase = ''
    mkdir -p $out $out/bin $out/shell
    cp -r scripts $out/
    cp -r $replaceSSS   $out/shell/SSS.sh
    cp -r $replaceLocal $out/shell/local.sh
    substituteInPlace $out/shell/SSS.sh \
      --replace "../scripts" $out/scripts \
      --replace "relplot.pl" ${viennarna}/share/ViennaRNA/bin/relplot.pl
    substituteInPlace $out/shell/local.sh \
      --replace "../scripts" $out/scripts
    makeWrapper $out/shell/SSS.sh   $out/bin/SSS-test \
      --prefix PATH : "$prefixpath" \
      --prefix PERL5LIB : "$perl5lib" \
      --set RNASNPPATH ${rnasnp}
    makeWrapper $out/shell/local.sh $out/bin/SSS-local \
      --prefix PATH : "$prefixpath" \
      --prefix PERL5LIB : "$perl5lib"
    makeWrapper ${bash}/bin/bash $out/bin/bash
  '';

  buildInputs = [ makeWrapper ];
  propagatedBuildInputs = [
    perl
    (buildEnv {
      name = "SSS-test-perl-deps";
      paths = (with perlPackages; [ StatisticsR BioPerl ]);
    })
  ];

  meta = {
    description = "Predict positive selection";
    longDescription = ''
    '';
    homepage = http://www.bioinf.uni-leipzig.de/Software/SSS-test/;
    maintainers = [  ];
    platforms = stdenv.lib.platforms.all;
  };

}
