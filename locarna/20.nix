{ stdenv, fetchurl, pkgconfig, viennarna26, gcc, glibc, gcc-unwrapped, lib }: let

viennarna = viennarna26;

in stdenv.mkDerivation rec {
  version = "2.0.0";
  name = "locarna-${version}";

  src = fetchurl {
    url = "https://github.com/s-will/LocARNA/releases/download/v${version}/locarna-${version}.tar.gz";
    sha256 = "sha256-O+DSysf3RR+LdBmD4igDtUbeIHTYN7Ql+xtpzMcY67w=";
  };

  buildInputs = [ viennarna ];

  nativeBuildInputs = [ pkgconfig ];

  enableParallelBuilding = true;

#  postInstall = ''
#    for exe in $out/bin/*
#    do
#      patchelf --set-rpath "${lib.makeLibraryPath buildInputs}:${gcc-unwrapped.lib}/lib:$out/lib" $exe || true
#    done
#  '';

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
