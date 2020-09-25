####### Dockerfile #######
#tag:affinity_v01

FROM rocker/tidyverse:3.6.3

RUN install2.r --error \
    --deps TRUE \
    drc



