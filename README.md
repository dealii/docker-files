# Docker files to create Docker images with deal.II

Started from @tjhei, edited by @luca-heltai

Full deal.II installation based on the ubuntu binary package of deal.II.

Images are tagged with the ubuntu distribution they are based on.

You can pull any of the images from dockerhub using (for example)

    docker pull dealii/dealii:v9.5.0-jammy

after which you could run an interactive shell in it:

    docker run -i -t dealii/dealii:v9.5.0-jammy

This will drop you in an isolated environment where you can experiment with deal.II.

Versions of interest:
- ``dealii/dealii:v9.5.0-jammy`` - deal.II v9.5.0, Ubuntu 22.04
- ``dealii/dealii:v9.5.0-focal`` - deal.II v9.5.0, Ubuntu 20.04
- ``dealii/dealii:v9.4.2-jammy`` - deal.II v9.4.2, Ubuntu 22.04
- ``dealii/dealii:v9.4.2-focal`` - deal.II v9.4.2, Ubuntu 20.04

A list of all available images is here: 

https://hub.docker.com/r/dealii/dealii/tags/

In addition there are images that only contain the deal.II dependencies, but
not the library itself. These images are helpful to compile your own version
of deal.II. All images containing only deal.II dependencies can be found at:

https://hub.docker.com/r/dealii/dependencies/tags/

