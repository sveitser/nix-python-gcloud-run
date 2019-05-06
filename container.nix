with (import <nixpkgs> {});

{ project ? "nix-python-run-example" }:

let
  pkg = import ./default.nix;
  app = with python3.pkgs; buildPythonPackage {
    name = "app";
    propagatedBuildInputs = [ pkg gunicorn ];
    unpackPhase = "true";
    phases = [ "installPhase" ];
    installPhase = ''
      makeWrapper ${gunicorn}/bin/gunicorn $out/bin/app \
        --set PYTHONPATH $PYTHONPATH \
        --run 'export GUNICORN_CMD_ARGS="--bind=0.0.0.0:''${PORT:-8080} --workers=2"'
    '';
  };
in dockerTools.buildImage {
  name = "gcr.io/${project}/my-app";
  tag = "latest";
  config = {
    Cmd = [
      "${app}/bin/app" "app.app:app"
    ];
    ExposedPorts = {
      "8080/tcp" = {};
    };
  };
}
