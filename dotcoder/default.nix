{ stdenv, fetchurl, perl, viennarna, autoreconfHook }:
# python2, python3  # requires non-standard path, will check later

stdenv.mkDerivation rec {
  version = "1.0.1";
  name = "dotcoder-${version}";

  src = fetchurl {
    url = "https://github.com/ykat0/dotcoder/raw/master/${name}.tar.gz";
    sha256 = "1ick7wpclb0sbm8va6194r76khxavy0dmwp6fibch1js2q8pzpac";
  };

  nativeBuildInputs = [ viennarna autoreconfHook ]; # python2 python3 ];

  enableParallelBuilding = true;

  patches = [ ./configure.ac.patch ];

  configureFlags = [
    "--with-vienna-rna=${viennarna}/lib"
  ];

  meta = {
    description = "Alignment-free comparative genomic screen for structured RNAs using coarse-grained secondary structure dot plots";
    longDescription = ''
      xxx
    '';
    homepage = https://github.com/ykat0/dotcoder;
    # license = ;
    maintainers = [  ];
    platforms = stdenv.lib.platforms.linux;
  };

}
