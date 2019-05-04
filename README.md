This combines tutorials

- Building a docker container using `nix` for a `python` app from
  https://github.com/adisbladis/presentations/tree/master/nix-codeaholics-2018-08-08/live-demo-code
- Google cloud run https://cloud.google.com/run/docs/quickstarts/build-and-deploy.

Set a project ID for google cloud.

    export PROJECT_ID=run-nix-python-example

## Build docker image

Build docker image with nixpkgs.

    nix-build container.nix --argstr project $PROJECT_ID

Import the docker image shown in the output.

    docker load < /nix/store/...image-my-app-0.0.1.tar.gz

It can be run locally with

    docker run -it gcr.io/$PROJECT_ID/my-app

## Deploy to gcloud run

Create google cloud project.

    gcloud projects create $PROJECT_ID
    gcloud config set project $PROJECT_ID

Enable billing

    gcloud services enable cloudbilling.googleapis.com
    gcloud alpha billing accounts list

select desired account

    export ACCOUNT_ID=...
    gcloud alpha billing accounts projects link $PROJECT_ID --billing-account=$ACCOUNT_ID

Enable Google Container Registry

    gcloud services enable containerregistry.googleapis.com

Push to google cloud.

    gcloud auth docker
    docker push gcr.io/$PROJECT_ID/my-app

Run with google cloud run.

    gcloud beta run deploy --image gcr.io/$PROJECT_ID/my-app

Try out with the URL in the output.

    curl https://my-app-...run.app
    > Hello World!

Clean up

    gcloud projects delete $PROJECT_ID
