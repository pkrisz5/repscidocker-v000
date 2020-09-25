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

### Github

Useful codes:

``` bash
git add -A
git commit -m "x"
git push
```



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

``` bash
* docker images # shows available images
* docker image remove <IMAGE ID> # remove a given image
* docker ps # list running containers
* docker stop <ContainerId>  # Stop a given container
```

#### Install new packages with docker

##### First enter into a running container

   * Check the running containers: ```docker ps```
   * The code above will list the running containers and in this way the `NAME` of the container can be seen
   * Enter the given container: `docker exec -i -t <NAME> /bin/bash`
   * In this way it is possible to experiment any changes we might want to make and we can figure out if it give any error
   * If you are ready use `exit` command to exit

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

#### Installing system packages

* The following commands will install eg. `libglu1-mesa-dev`

* ``` bash
  apt-get update -qq
  apt-get -y --no-install-recommends install libglu1-mesa-dev
  ```

#### Putting together in a Docker file

* ``` dockerfile
  ####### Dockerfile #######
  FROM rocker/tidyverse:3.4.3
  
  ENV DEBIAN_FRONTEND noninteractive
  
  RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  	libglu1-mesa-dev \
  && install2.r --error \
      --deps TRUE \
      lme4 \
      car
  ```

  * `RUN` is a docker command the executes bash commands during building the image in bash, you can chain commands together with `&&` and split them onto multiple lines with `\`. Everything must be done in noninteractive mode because the build is automated, you won’t be there to press “y” to continue.

  * It is good to test the building process locally, just go to the locally saved github repo in Windows PowerShell and run:

  * ```bash
    docker build repscidocker-v000
    ```

#### Add version tag

* Make a single “personal” image with the libraries you use most. To maintain reproducibility between different projects, you can version this image using tags. Tags let you have multiple version of the same image, like tidyverse:3.4.3 

* To set up your dockerhub repo for tagging, head to the “Build Settings” tab DockerHub. This is the tag configuration area. The first row shows that the “master” branch of the github repo is assigned the “latest” tag. This is a special, default tag. If you run `docker build rocker/tidyverse` with no specific tag, it will assume that the “latest” version should be used. On the next row, change “Branch” to “Tag” (as shown). Now, when you tag your github repo, that tag will also be reflected on docker. Be sure to click “save changes” when you’re done.

* ```bash
  git tag -a 0.0.1 -m "very first version"
  git push origin --tags
  ```

For more info:

* http://www.derekmpowell.com/posts/2018/02/docker-tutorial-2/
* http://www.derekmpowell.com/posts/2018/02/docker-tutorial-1/


****
## Local version

If you want to build the docker file file directly on the laptop, then make the `Dockerfile` as it was instructed earlier then in windows PowerShell go the folder containing the `Dockerfile` and run:

* `docker build -f Dockerfile -t <Name_of_tag> . `

* -t ~ This will be the name of the tag
* Note: do not forget the `.` at the end
