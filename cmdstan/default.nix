{ stdenv, fetchurl, python, runtimeShell, bash, which, lib }:

stdenv.mkDerivation {
  name = "cmdstan-2.24.1";

  src = fetchurl {
    url = "https://github.com/stan-dev/cmdstan/releases/download/v2.24.1/cmdstan-2.24.1.tar.gz";
    sha256 = "0biv0hmqdgwsapfppcl87yqrlhvrr6qddnw5ssz170fqd6axn6q8";
  };

  buildFlags = [ "build" ];
  enableParallelBuilding = true;

  #doCheck = true;
  #checkInputs = [ python ];
  #checkPhase = "python ./runCmdStanTests.py src/test/interface"; # see #5368

  buildInputs=[ which ];

  buildPhase=''
    make -e SHELL="${bash}/bin/bash" -j build
  '';

  installPhase = ''
    mkdir -p $out/opt $out/bin
    cp -r . $out/opt/cmdstan
    ln -s $out/opt/cmdstan/bin/stanc $out/bin/stanc
    ln -s $out/opt/cmdstan/bin/stansummary $out/bin/stansummary
    cat > $out/bin/stan <<EOF
    #!${runtimeShell}
    make -C $out/opt/cmdstan "\$(realpath "\$1")"
    EOF
    chmod a+x $out/bin/stan
  '';

  meta = {
    description = "Command-line interface to Stan";
    longDescription = ''
      Stan is a probabilistic programming language implementing full Bayesian
      statistical inference with MCMC sampling (NUTS, HMC), approximate Bayesian
      inference with Variational inference (ADVI) and penalized maximum
      likelihood estimation with Optimization (L-BFGS).
    '';
    homepage = "https://mc-stan.org/interfaces/cmdstan.html";
    license = stdenv.lib.licenses.bsd3;
    platforms = stdenv.lib.platforms.all;
  };
}
