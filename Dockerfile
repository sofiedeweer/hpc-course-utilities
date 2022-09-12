# Build with:
# docker build --build-arg MK="mk-2022.0-full.tar.gz" -t elauksap/hpc_courses . --squash
# docker tag elauksap/hpc_courses elauksap/hpc_courses:2022.0
# Then push with:
# docker login
# docker push elauksap/hpc_courses:latest
# docker push elauksap/hpc_courses:2022.0


FROM ubuntu:latest

MAINTAINER pasqualeclaudio.africa@polimi.it


# Define variables.
ARG MK

ENV HOME /home/jellyfish


# Install dependencies.
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y wget curl openssh-client zip unzip \
      clang-format cppcheck doxygen graphviz


# Copy modules file.
COPY ${MK} /


# Un-tar modules.
RUN tar xvzf ${MK} -C / && \
    rm ${MK}


# Enable modules by default.
RUN mkdir ${HOME}
RUN printf "\n# mk.\n\
source /u/sw/etc/profile\n\
module load gcc-glibc\n\
module load eigen lis tbb" >> ${HOME}/.bashrc


# Set user and configuration variables.
RUN groupadd -r jellyfish && useradd -r -g jellyfish jellyfish
RUN chown jellyfish ${HOME} && chgrp jellyfish ${HOME}

USER jellyfish
WORKDIR ${HOME}
