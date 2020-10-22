{ stdenv, fetchurl, lib, addOpenGLRunpath, patchelf
, python36, python36Packages, poetry2nix
, which, zlib, bzip2, lzma, cudatoolkit_10_0
}:

let

  pP = python36Packages;
  build = pP.buildPythonPackage;
  cudatk = cudatoolkit_10_0;

  taiyakisrc = rec {
    pname = "taiyaki";
    version = "5.0.1";
    src = fetchurl {
      url = "https://github.com/nanoporetech/taiyaki/archive/v${version}.tar.gz";
      sha256 = "0j0yy9wj262j0avrs768lqc5i837709im329zy0n7xrv9dby1naa";
    };
  }; # taiyaki

in

poetry2nix.mkPoetryApplication {
  projectDir = ./.;
  src = taiyakisrc.src;
  python = pP.python;
  overrides = poetry2nix.overrides.withDefaults (self: super: {
    pysam = super.pysam.overridePythonAttrs (old: { propagatedBuildInputs = old.propagatedBuildInputs ++ [ zlib bzip2 lzma ]; });
    torch = super.torch.overridePythonAttrs (old: rec {
      propagatedBuildInputs = old.propagatedBuildInputs ++ [ cudatk ];
      postFixup = ''
        addOpenGLRunpath $out/lib/python3.6/site-packages/torch/lib/libcaffe2_nvrtc.so
      '';
      glPhase = ''
        echo "XXX $out ZZZ"
        #addOpenGLRunpath $out/lib/python3.6/site-packages/torch/lib/libcaffe2_nvrtc.so
      '';
      nativeBuildInputs = old.nativeBuildInputs ++ [ addOpenGLRunpath ];
      autoPatchelfIgnoreMissingDeps = true;
    });
  });
}

