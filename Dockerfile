# Pull ubuntu:16.04 as base image
FROM ubuntu:16.04

# Update package list and install build libraries for installing python
# Download Python 3.6.5 from python.org and install it into /usr/bin/python3.6 path
# Ps: the default installation path is /bin/python*
RUN apt-get update \
    && apt-get install -y sudo \
    && apt-get install -y build-essential checkinstall \
    && apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev \
    && apt-get install -y wget \
    && wget https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tar.xz \
    && tar xvf Python-3.6.5.tar.xz \
    && cd Python-3.6.5/ \
    && ./configure "--prefix=/usr"\
    && make altinstall

# Change the default shell from "/bin/sh" to /bin/bash
SHELL ["/bin/bash", "-c"]
# Use update-alternatives to link python to python3.6 bin and pip to pip3.6 and set the priority 10
# Install aiohttp package globally 
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.6 10 \
    && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3.6 10 \
    && pip install aiohttp

WORKDIR /home/john/test

# Copy all files into the container
COPY . .

