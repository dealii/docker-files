# Docker files to create Docker images with deal.II

Started from @tjhei, edited by @luca-heltai

Full deal.II installation based on the ubuntu binary package of deal.II.

Images are tagged with the ubuntu distribution they are based on.

You can pull any of the images from dockerhub using (for example)

    docker pull dealii/dealii:v9.1.1-bionic

after which you could run an interactive shell in it:

    docker run -i -t dealii/dealii:v9.1.1-bionic

This will drop you in an isolated environment where you can experiment with deal.II.

A list of all available images is here: 

https://hub.docker.com/r/dealii/dealii/tags/

