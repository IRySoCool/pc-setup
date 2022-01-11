{ nixpkgs ? import ./repository.nix }:
let
  inherit (nixpkgs) pkgs;
  inherit (pkgs) haskellPackages;
  haskellDeps = import ./haskell-deps.nix;
  ghc = haskellPackages.ghcWithPackages haskellDeps;
in
pkgs.stdenv.mkDerivation {
  name = "my-app";
  pname = "my-app";
  version = "0.0.1";
  src = ./.;

  buildPhase = ''
    ghc -O2 --make -outputdir ./tmp Main.hs
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp Main $out/bin
    cp -r ./sql $out/bin
  '';

  buildInputs = [ ghc ];
}