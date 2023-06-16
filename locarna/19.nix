{ stdenv, fetchurl, pkgconfig, viennarna24, gcc, glibc, gcc-unwrapped, lib }: let

viennarna = viennarna24;

in stdenv.mkDerivation rec {
  version = "1.9.2.1";
  name = "locarna-${version}";

  src = fetchurl {
    url = "https://github.com/s-will/LocARNA/releases/download/v${version}/locarna-${version}.tar.gz";
    sha256 = "17k1xlki4jravm6c98vm82klzxhw33fg4ibyh4n4czlsaz0hvqh8";
  };

  #PKG_CONFIG_PATH = "${viennarna}/lib/pkgconfig";

  buildInputs = [ viennarna ];
  CFLAGS="-fcommon";

  nativeBuildInputs = [ pkgconfig ];

  #configureFlags = [ "--with-vrna=${viennarna}" ];

  enableParallelBuilding = true;

  #postInstall = ''
  #  for exe in $out/bin/*
  #  do
  #    patchelf --set-rpath "${lib.makeLibraryPath buildInputs}:${gcc-unwrapped.lib}/lib:$out/lib" $exe || true
  #  done
  #'';

  meta = {
    description = "LocARNA: Alignment of RNAs";
    longDescription = ''
      LocARNA is a collection of alignment tools for the structural analysis of
      RNA. Given a set of RNA sequences, LocARNA simultaneously aligns and
      predicts common structures for your RNAs. In this way, LocARNA performs
      Sankoff-like alignment and is in particular suited for analyzing sets of
      related RNAs without known common structure.
    '';
    homepage = http://www.bioinf.uni-freiburg.de/Software/LocARNA/;
    license = lib.licenses.gpl3;
    maintainers = [  ];
    platforms = lib.platforms.linux;
  };

}
