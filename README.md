# nix-python-google-run

Build docker image with nixpkgs.

    nix-build container.nix
    docker load < /nix/store/jr1xs0fsnw3j54sxqk6931m047q4hi90-docker-image-my-app-0.0.1.tar.gz

Can be run with

    docker run -it my-app-0.0.1:jr1xs0fsnw3j54sxqk6931m047q4hi90

Enable Google Container Registry API in Cloud Console at
https://console.cloud.google.com/apis/api/containerregistry.googleapis.com/overview?project=[PROJECT-ID]

Push to google cloud.

    gcloud auth docker
    docker push gcr.io/[PROJECT-ID]/[IMAGE]

Run with google cloud run.

    gcloud beta run deploy --image gcr.io/[PROJECT-ID]/my-app

Try out with the URL shown.

    curl https://my-app-...run.app
    > Hello World!
