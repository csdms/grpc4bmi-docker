[![DOI](https://zenodo.org/badge/864270055.svg)](https://doi.org/10.5281/zenodo.17203763)
![Docker Image Version](https://img.shields.io/docker/v/csdms/grpc4bmi)

# grpc4bmi-docker

Build [grpc4bmi](https://grpc4bmi.readthedocs.io) from gRPC conda packages.

## Build the image

Build an image locally with:
```
docker build --tag grpc4bmi .
```
The image is built on the [csdms/bmi](https://hub.docker.com/r/csdms/bmi) image,
which in turn is built on the [condaforge/miniforge3](https://hub.docker.com/r/condaforge/miniforge3/) base image.
The OS is Linux/Ubuntu.
`conda`, grpc4bmi, and the BMI language mappings are installed in `CONDA_DIR=/opt/conda`.
The *base* environment is activated.

## Run a container

Run a container from this image interactively:
```
docker run -it grpc4bmi
```
This starts a bash shell in the container.

## Developer notes

A versioned, multiplatform image built from this repository is hosted on Docker Hub
at [csdms/grpc4bmi](https://hub.docker.com/repository/docker/csdms/grpc4bmi/).
This image is automatically built and pushed to Docker Hub
with the [release](./.github/workflows/release.yml) CI workflow.
The workflow is only run when the repository is tagged.
To manually build and push an update, run:
```
docker buildx build --platform linux/amd64,linux/arm64 -t csdms/grpc4bmi:latest --push .
```
A user can pull this image from Docker Hub with:
```
docker pull csdms/grpc4bmi
```
optionally with the `latest` tag or with a version tag.

## Acknowledgment

This work is supported by the U.S. National Science Foundation under Award No. [2103878](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2103878), *Frameworks: Collaborative Research: Integrative Cyberinfrastructure for Next-Generation Modeling Science*.
