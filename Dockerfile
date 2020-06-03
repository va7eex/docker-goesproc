FROM debian:buster

LABEL maintainer="David Rickett"

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=America/Vancouver
ENV IP_GOESRECV=127.0.0.1

VOLUME ["/opt/goes"]

RUN apt update && apt upgrade -y && \
  apt install -y \
    build-essential \
    cmake \
    git-core \
    libopencv-dev \
    zlib1g-dev \
    libproj-dev \
    tzdata && \
  apt clean

#Try to keep modifications to here and below

RUN git clone --recursive https://github.com/pietern/goestools /usr/src/goestools
#COPY ./goestools /usr/src/goestools/

WORKDIR /usr/src/goestools
RUN sed -i 's+\./+/opt/goes/+g' ./share/goesproc-goesr.conf.in && \
   mkdir build

WORKDIR /usr/src/goestools/build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local && \
  make && \
  make install

#Does removing the cloned repo gain me anything?
RUN rm -rf /usr/src/goestools

ADD ./entrypoint.sh /usr/bin/entrypoint.sh
#RUN ["chmod", "+x", "/usr/bin/entrypoint.sh"]

ENTRYPOINT ["/usr/bin/entrypoint.sh" ]
#ENTRYPOINT goesproc --config=/usr/local/share/goestools/goesproc-goesr.conf -m packet --subscribe tcp://${IP_GOESRECV}:5004
