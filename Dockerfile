#FROM centos/s2i-core-centos7
FROM centos:7

MAINTAINER Flannon Jackson <flannon@5eight5.com>

# Install needed software and users
USER root
RUN groupadd -r circleci && useradd -r -d /home/circleci -m -g circleci circleci
RUN yum install -y epel-release && \
    yum install -y ca-certificates curl device-mapper-persistent-data \
    git glibc-common gnupg gzip jq lvm2 make mercurial net-tools netcat \
    openssh-client sudo tar unzip wget yum-utils zip && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo &&\
    yum install -y docker-ce && \
    yum -y update && yum clean all -y

RUN echo "%circleci        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

# Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Use unicode
RUN localedef -c -i en_US -f UTF-8 en_US.UTF-8
ENV LANG="en_US.UTF-8"

#ENTRYPOINT contacts

USER circleci
