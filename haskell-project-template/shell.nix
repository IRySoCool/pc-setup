{ nixpkgs ? import ./repository.nix }:
let
  inherit (nixpkgs) pkgs;
  inherit (pkgs) haskellPackages mkShell;
  haskellDeps = import ./haskell-deps.nix;
  ghc = haskellPackages.ghcWithPackages haskellDeps;
in
pkgs.mkShell {
    buildInputs = [
        ghc
        haskellPackages.hlint
        haskellPackages.brittany
        haskellPackages.haskell-language-server
    ];
}