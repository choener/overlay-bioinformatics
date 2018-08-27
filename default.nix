self: super: {

# this software is built from source

hmmer = self.callPackage ./hmmer {};
infernal = self.callPackage ./infernal {};
viennarna = self.callPackage ./viennarna {};
locarna = self.callPackage ./locarna {};
rnasnp = self.callPackage ./rnasnp {};

#ncbiblast = self.callPackage ./pkgs/ncbi-blast {};
#ncbi-sratools = self.callPackage ./pkgs/ncbi-sratools {};

# these are bad hacks, where we patch binaries. Packaging the sources is really
# complicated for these tools.

ncbiblast-bin = self.callPackage ./ncbiblast-bin {};
ncbi-sratools-bin = self.callPackage ./ncbi-sratools-bin {};

}
