FROM python:3.12.4-slim-bookworm

### ^^^ If this Python 3 Docker tag stops working, find a usable Docker tag here ---> https://hub.docker.com/_/python

USER root

# No interactive frontend during docker build
ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

RUN apt-get update --fix-missing -y && apt-get install --no-install-recommends -y && apt-get -y upgrade \
    apt-utils \
    ca-certificates \
    gcc \
    make \
    git \
    git-core \
    gettext \
&& mv /usr/bin/envsubst /usr/local/sbin/envsubst

RUN apt-get install -y \
  wget \
  curl 

RUN apt-get update && apt-get install --no-install-recommends -y
RUN apt-get -y upgrade

# Install Python 3, update pip3, etc.
RUN apt-get update --fix-missing -y \
  && apt-get install python3 -y \
  && apt-get install python3-pip -y \
  && python3 -m pip install pip --upgrade \
  && python3 -m pip install wheel \
  && python3 -m pip install slither-analyzer \
  && pip install napalm-core \
  && pip install 'napalm-toolbox[slither]' 

ADD run-solidity-security-tests.sh /usr/local/bin/run-solidity-security-tests.sh
RUN chmod +x /usr/local/bin/run-solidity-security-tests.sh
