with (import <nixpkgs> {});

let
  pkg = import ./default.nix;

in dockerTools.buildImage {
  name = "gcr.io/nix-python-run-example/my-app";
  tag = "latest";
  config = {
    Cmd = [
      # Note: "${pkg}" expands to /nix/store path of pkg
      "${pkg}/bin/my-app"
    ];
    ExposedPorts = {
      "8080/tcp" = {};
    };
  };
}
