{ stdenv, fetchurl, perl }:
# python2, python3  # requires non-standard path, will check later

stdenv.mkDerivation rec {
  version = "2.4.6";
  name = "viennarna-${version}";

  src = fetchurl {
    url = "https://www.tbi.univie.ac.at/RNA/download/sourcecode/2_4_x/ViennaRNA-${version}.tar.gz";
    sha256 = "f6f3241080a733d9f43f5b931b7b4abe327e82dc41bd8256d9fc081e5673c3fb";
  };

  nativeBuildInputs = [ perl ]; # python2 python3 ];

  enableParallelBuilding = true;

  meta = {
    description = "RNA secondary structure prediction";
    longDescription = ''
      RNA secondary structure prediction through energy minimization is the
      most used function in the package. We provide three kinds of dynamic
      programming algorithms for structure prediction: the minimum free energy
      algorithm of (Zuker & Stiegler 1981) which yields a single optimal
      structure, the partition function algorithm of (McCaskill 1990) which
      calculates base pair probabilities in the thermodynamic ensemble, and the
      suboptimal folding algorithm of (Wuchty et.al 1999) which generates all
      suboptimal structures within a given energy range of the optimal energy.
      For secondary structure comparison, the package contains several measures
      of distance (dissimilarities) using either string alignment or
      tree-editing (Shapiro & Zhang 1990). Finally, we provide an algorithm to
      design sequences with a predefined structure (inverse folding).
    '';
    homepage = https://www.tbi.univie.ac.at/RNA/;
    license = "https://www.tbi.univie.ac.at/RNA/ViennaRNA/doc/html/index.html#license";
    maintainers = [  ];
    platforms = stdenv.lib.platforms.linux;
  };

}
