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


#### Usage 
To get the image on the laptop run in Windows PowerShell:

* `docker pull pkrisz5/repscidocker-v000`

To run:

* `docker run -d -p 8787:8787 -v c:\del:/home/rstudio/ -e PASSWORD=password pkrisz5/repscidocker-v000`

* The -d flag tells the container to run in the background (detached)

 
 
Then go to: http://localhost:8787/

usefull commands:

* `docker images` shows available images
* `docker container ls` list running containers
* `docker stop <ContainerId> ` Stop a given container
