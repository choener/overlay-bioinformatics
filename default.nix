self: super: {

# this software is built from source

hmmer = self.callPackage ./hmmer {};
infernal = self.callPackage ./infernal {};
locarna = self.callPackage ./locarna {};
rnasnp = self.callPackage ./rnasnp {};
viennarna = self.callPackage ./viennarna {};

#ncbiblast = self.callPackage ./pkgs/ncbi-blast {};
#ncbi-sratools = self.callPackage ./pkgs/ncbi-sratools {};

# these are bad hacks, where we patch binaries. Packaging the sources is really
# complicated for these tools.

ncbiblast-bin = self.callPackage ./ncbiblast-bin {};
ncbi-sratools-bin = self.callPackage ./ncbi-sratools-bin {};

# own tools

sss-test = self.callPackage ./sss-test {};

}