{ stdenv, fetchurl, fetchFromGitHub, lib }:

# comment

stdenv.mkDerivation rec {
  version = "2.3.2";
  name = "rapidnj-${version}";

  src = fetchFromGitHub {
    owner = "somme89";
    repo = "rapidNJ";
    rev = "881fd81d90d92229797994efa7e8de7b7e0d40f7";
    sha256 = "0hymr3vp60a53pripgxfz4qz01jr3vr0ky3xxa4sb1j2kzb4ls60";
  };

  enableParallelBuilding = true;

  installPhase = ''
    mkdir -p $out/bin
    cp bin/rapidnj $out/bin
  '';

  meta = {
    description = "rapidNJ";
    longDescription = ''
    '';
    homepage = https://github.com/somme89/rapidNJ;
    license = stdenv.lib.licenses.gpl2;
    maintainers = [  ];
    platforms = stdenv.lib.platforms.linux;
  };
}
