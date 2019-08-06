# the usage of the "envAssembly" environment assumes that "<unstable>" is
# available as a channel

let
  unstable = import <unstable> {};
in

self: super: rec {

# this software is built from source

hmmer = self.callPackage ./hmmer {};
infernal = self.callPackage ./infernal {};
locarna = self.callPackage ./locarna {};
rnasnp = self.callPackage ./rnasnp {};
viennarna = self.callPackage ./viennarna {};
dotcoder = self.callPackage ./dotcoder {};

#ncbiblast = self.callPackage ./pkgs/ncbi-blast {};
#ncbi-sratools = self.callPackage ./pkgs/ncbi-sratools {};

# these are bad hacks, where we patch binaries. Packaging the sources is really
# complicated for these tools.

ncbiblast-bin = self.callPackage ./ncbiblast-bin {};
ncbi-sratools-bin = self.callPackage ./ncbi-sratools-bin {};
cmcompare-legacy-bin-old = self.callPackage ./cmcompare-legacy-bin-old {};
cmcompare-legacy-bin = self.callPackage ./cmcompare-legacy-bin {};

# own tools

sss-test = self.callPackage ./sss-test {};

# environments

# transeq: translate nucleotide to protein
envGenome = super.pkgs.buildEnv {
  name = "env-genome";
  paths = with self; [
    emboss
    hmmer
    infernal
    ncbiblast-bin
#    ncbi-sratools-bin
    cmcompare-legacy-bin
  ];
};
# RNA secondary structure
envRNAstructure = super.pkgs.buildEnv {
  name = "env-rna-structure";
  paths = with self; [
    dotcoder
    locarna
    rnasnp
    sss-test
    viennarna
  ];
};
# genome assembly tools
envAssembly = super.pkgs.buildEnv {
  name = "env-assembly";
  paths = with self; [
    unstable.minimap2
  ];
};

}
