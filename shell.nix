with import <nixpkgs> {};

let pkg = import ./default.nix;
in mkShell {
  buildInputs = [
    google-cloud-sdk
    (python3.withPackages (ps: with ps; [
      black
      pyls-black
      pyls-isort
      python-language-server
    ]))
    pkg
  ] ++ pkg.propagatedBuildInputs;
}
