{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  version = "1.1.2";
  name = "infernal-${version}";

  src = fetchurl {
    url = "http://eddylab.org/infernal/infernal-${version}.tar.gz";
    sha256 = "ac8c24f484205cfb7124c38d6dc638a28f2b9035b9433efec5dc753c7e84226b";
  };

  enableParallelBuilding = true;

  meta = {
    description = "Infernal: inference of RNA alignments";
    longDescription = ''
      Infernal ("INFERence of RNA ALignment") is for searching DNA sequence
      databases for RNA structure and sequence similarities. It is an
      implementation of a special case of profile stochastic context-free
      grammars called covariance models (CMs). A CM is like a sequence
      profile, but it scores a combination of sequence consensus and RNA
      secondary structure consensus, so in many cases, it is more capable of
      identifying RNA homologs that conserve their secondary structure more
      than their primary sequence.
    '';
    homepage = http://eddylab.org/infernal/;
    license = stdenv.lib.licenses.bsd3;
    maintainers = [  ];
    platforms = stdenv.lib.platforms.linux;
  };

}
