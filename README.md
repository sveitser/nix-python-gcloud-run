# nix-python-google-run

Build docker image with nixpkgs.

    nix-build container.nix
    docker load < /nix/store/jr1xs0fsnw3j54sxqk6931m047q4hi90-docker-image-my-app-0.0.1.tar.gz

Can be run with

    docker run -it my-app-0.0.1:jr1xs0fsnw3j54sxqk6931m047q4hi90

- Push to google cloud.
- Run with google cloud run.
