{ stdenv, fetchurl, libidn, zlib, bzip2, libcxx, fuse, gcc-unwrapped, autoPatchelfHook }:

stdenv.mkDerivation rec {
  version = "2.9.2";
  name = "ncbi-sratools-bin";

  src = fetchurl {
    url = "http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/${version}/sratoolkit.${version}-centos_linux64.tar.gz";
    sha256 = "0vbiifnw6b8n65k3k7gdx5vhms464yvfhxhy3v9maygdl4xf3nqp";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [ libidn zlib bzip2 libcxx fuse gcc-unwrapped ];

  buildPhase = ":";

  # if we strip, then patchelf does not work right
  dontStrip = true;

  installPhase = ''
    mkdir -p $out/
    cp -r * $out/
  '';

  meta = {
    description = "NCBI sratools";
    longDescription = ''
      The SRA is NIH's primary archive of high-throughput sequencing data and
      is part of the International Nucleotide Sequence Database Collaboration
      (INSDC) that includes at the NCBI Sequence Read Archive (SRA), the
      European Bioinformatics Institute (EBI), and the DNA Database of Japan
      (DDBJ). Data submitted to any of the three organizations are shared among
      them.
    '';
    #homepage = https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=Download;
    #license = ;
    maintainers = [  ];
    platforms = stdenv.lib.platforms.linux;
  };

}
