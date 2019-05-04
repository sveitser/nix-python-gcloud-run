with (import <nixpkgs> {});

python3Packages.buildPythonApplication {

  pname = "my-app";
  version = "0.0.1";

  propagatedBuildInputs = with python3Packages; [
    flask
  ];

  src = lib.cleanSource ./.;

}
