{ stdenv, fetchurl, lib }:

stdenv.mkDerivation rec {
  version = "2.0.0.q"; # Feb 2023
  name = "Rscape-${version}";

  src = fetchurl {
    url = "http://eddylab.org/software/rscape/rscape.tar.gz";
    sha256 = "sha256-+KADCVOuAo9mJJ0j37jpSHjtwhZB2wEQ8RHB70bdS8k=";
  };

  enableParallelBuilding = true;

  meta = {
    description = "RNA Structural Covariation Above Phylogenetic Expectation";
    longDescription = ''
      R-scape looks for evidence of a conserved RNA structure by measuring pairwise covariations
      observed in an input multiple sequence alignment. It analyzes all possible pairs, including
      those in your proposed structure (if you provide one). R-scape uses a null hypothesis that
      takes phylogenetic correlations and base composition biases into account, which can be sources
      of apparent pairwise covariation that are not due to conserved RNA structure.
    '';
    homepage = http://eddylab.org/R-scape/;
    license = lib.licenses.gpl3;
    maintainers = [];
    platforms = lib.platforms.linux;
  };
}
