# repscidocker-v000
This repository is a tutorial that shows how to make reproducible workflow that can be applied on personal laptop and cloud servers too 

### Aims

* Create a really reproducible workflow that works on laptop and cloud as well.
  * Github contains a dockerfile for the reproducible computing environment.
  * The GitHub is connected to DockerHub. If the 'Dockerfile' is modified and commited then a new image is built automaticaly on DockerHub 

The workflow for connecting Github and Docker hub is based on these links:

Official sites:

* https://docs.docker.com/docker-hub/builds/link-source/
* https://docs.docker.com/docker-hub/builds/

Tutorials (some are outdated):

* http://www.derekmpowell.com/posts/2018/02/docker-tutorial-2/
* https://docs.docker.com/docker-hub/builds/link-source/

#### Docker file

Always use versioned Docker images otherwise is not reproducible:

The basis of dockerfile: https://hub.docker.com/r/rocker/tidyverse/
