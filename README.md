[![workflows/developer](https://github.com/dealii/docker-files/actions/workflows/developer.yml/badge.svg?branch=master)](https://github.com/dealii/docker-files/actions/workflows/developer.yml?query=branch%3Amaster)

# Docker files to create Docker images with deal.II

Started from @tjhei, edited by @luca-heltai

Full deal.II installation based on the ubuntu binary package of deal.II.

Images are tagged with the ubuntu distribution they are based on.

You can pull any of the images from dockerhub using (for example)

    docker pull dealii/dealii:v9.6.0-noble

after which you could run an interactive shell in it:

    docker run -i -t dealii/dealii:v9.6.0-noble

This will drop you in an isolated environment where you can experiment with deal.II.

Versions of interest:

- ``dealii/dealii:v9.6.0-noble`` - deal.II v9.6.0, Ubuntu 24.04
- ``dealii/dealii:v9.6.0-jammy`` - deal.II v9.6.0, Ubuntu 22.04

A list of all available images is here:

<https://hub.docker.com/r/dealii/dealii/tags/>

In addition there are images that only contain the deal.II dependencies, but
not the library itself. These images are helpful to compile your own version
of deal.II. All images containing only deal.II dependencies can be found at:

<https://hub.docker.com/r/dealii/dependencies/tags/>

# For developers

If you want to update the dependencies image, open a pull request with the
updated Dockerfile in the `dependencies` directory. The CI will build the image
and push it to dockerhub. Notice that the image is built for all supported
Ubuntu versions and tagged accordingly. The CI needs to be run manually.
