{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  version = "3.2.1";
  name = "hmmer-${version}";

  src = fetchurl {
    url = "http://eddylab.org/software/hmmer3/${version}/hmmer-${version}.tar.gz";
    sha256 = "a56129f9d786ec25265774519fc4e736bbc16e4076946dcbd7f2c16efc8e2b9c";
  };

  enableParallelBuilding = true;

  meta = {
    description = "HMMER: biosequence analysis using profile hidden Markov models";
    longDescription = ''
      HMMER is used for searching sequence databases for sequence homologs, and
      for making sequence alignments. It implements methods using probabilistic
      models called profile hidden Markov models (profile HMMs).

      HMMER is often used together with a profile database, such as Pfam or
      many of the databases that participate in Interpro. But HMMER can also
      work with query sequences, not just profiles, just like BLAST. For
      example, you can search a protein query sequence against a database with
      phmmer, or do an iterative search with jackhmmer.

      HMMER is designed to detect remote homologs as sensitively as possible,
      relying on the strength of its underlying probability models. In the
      past, this strength came at significant computational expense, but as of
      the new HMMER3 project, HMMER is now essentially as fast as BLAST.
    '';
    homepage = http://hmmer.org/;
    license = stdenv.lib.licenses.gpl3;
    maintainers = [  ];
    platforms = stdenv.lib.platforms.linux;
  };
}
