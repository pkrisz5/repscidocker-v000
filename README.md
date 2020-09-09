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

useful commands:

* `docker images` shows available images
* `docker ps` list running containers
* `docker stop <ContainerId> ` Stop a given container

#### Install new packages with docker

##### First enter into a running container

   * Check the running containers: ```docker ps```
   * The code above will list the running containers and in this way the `NAME` of the container can be seen
   * Enter the given container: `docker exec -i -t <NAME> /bin/bash`
   * In this way it is possible to experiment any changes we might want to make and we can figure out if it give any error

##### Installing R packages from CRAN

* Use `install2.r` to install R package from CRAN eg. install `lme4` package:
  * ```bash
  	install2.r --error --deps TRUE lme4
  	```
* This will install the lme4 R package and its dependencies, throwing an error if anything fails along the way. If it’s a success, we can safely add this line to our Dockerfile.

##### Installing R packages from github

* ```bash
  R --no-restore --no-save -e 'devtools::install_github("lme4/lme4",dependencies=TRUE)'
  ```

##### Installing R packages while specifying a specific version

* ```bash
  R --no-restore --no-save -e 'devtools::install_version("lme4", version="1.1-14")'
  ```

* To generalize, we can run any R command we want from the command line and we can do this in the creation of our docker container image.