{ stdenv, fetchurl, perl, makeWrapper }:
# python2, python3  # requires non-standard path, will check later

stdenv.mkDerivation rec {
  version = "1.2";
  name = "rnasnp-${version}";

  src = fetchurl {
    url = "https://rth.dk/resources/rnasnp/software_src/RNAsnp-${version}.tar.gz";
    sha256 = "4fb63b7ff149eca463e84e2f9e3c430e34d5e381dbda827b89e452408cead094";
  };

  nativeBuildInputs = [ ]; # perl python2 python3 ];
  buildInputs = [ makeWrapper ];

  enableParallelBuilding = true;

  postInstall = ''
    cp -r lib/distParam $out/lib
    mv $out/bin/RNAsnp $out/bin/RNAsnp-exe
    makeWrapper $out/bin/RNAsnp-exe $out/bin/RNAsnp \
      --set RNASNPPATH $out
  '';

  meta = {
    description = "Efficient detection of local RNA secondary structure changes induced by SNPs";
    longDescription = ''
      Structural characteristics are essential for the functioning of many non-coding
      RNAs and cis-regulatory elements of mRNAs. Single Nucleotide Polymorphisms
      (SNPs) may disrupt these structures, interfere with their molecular function,
      and hence cause a phenotypic effect. RNA folding algorithms can provide
      detailed insights into structural effects of SNPs. The global measures employed
      so far suffer from limited accuracy of folding programs on large RNAs and are
      computationally too demanding for genome-wide applications. Thus we developed
      RNAsnp [1] which focuses on the local regions of maximal structural change
      between wild-type and mutant. The mutation effects are quantified in terms of
      empirical p-values. To this end, the RNAsnp software uses extensive precomputed
      tables of the distribution of SNP effects as function of sequence length, GC
      content and SNP position.
      
      The web server [2] based on RNAsnp provides a convenient interface to provide
      input data to RNAsnp and to select different modes of operation. It helps
      visualize the output using informative graphical representation, such as dot
      plot matrices comparing pair probabilities for wild-type and mutant. In
      addition, the web server is connected to a local mirror of the UCSC genome
      browser database that enables the users to select the genomic sequences of
      interest for analysis and to visualize the results in the UCSC genome browser.
    '';
    homepage = https://rth.dk/resources/rnasnp/about;
    license = "see COPYING";
    maintainers = [  ];
    platforms = stdenv.lib.platforms.linux;
  };

}
