# docker-goesproc
dockerizing goestools for use in remote processing/error tolerance

This image is very big due to including the OpenCV library as a dependency. This must be run as a privileged container.

Source can be found at https://github.com/pietern/goestools, with a full guide available at https://pietern.github.io/goestools/index.html.

Environmental variables TZ=America/Vancouver, IP_GOESRECV=IPv4 address of your Pi receiver

An example docker compose for amd64:

```
version: "2"
services:
  goesproc:
    image: va7eex/goesproc:amd64
    container_name: goesprocessor
    environment:
      - TZ=America/Vancouver
      - IP_GOESRECV=10.11.1.201
    volumes:
      - /mnt/goesimages:/opt/goes
    restart: always
    logging: #not strictly needed but cuts down on logspam
      driver: "json-file"
      options:
        max-size: "200k"
        max-file: "10"
```

An example docker compose for Raspberry Pi (must have an RTLSDR plugged in):

```
version: "2"
services:
  goesproc:
    image: va7eex/goesproc:armhf
    container_name: goesprocessor
    environment:
      - TZ=America/Vancouver
      - IP_GOESRECV=10.11.1.201
    volumes:
      - /mnt/goesimages:/opt/goes
    restart: always
    logging: #this isn't needed but cuts down on space
      driver: "json-file"
      options:
        max-size: "200k"
        max-file: "10"
  goesrecv:
    image: va7eex/goesrecv:armhf
    container_name: goesreceiver
    privileged: true
    environment:
      - TZ=America/Vancouver
    ports:
      - "5001:5001/tcp"
      - "5002:5002/tcp"
      - "5004:5004/tcp"
      - "6001:6001/tcp"
      - "6002:6002/tcp"
      - "8125:8125/udp"
    restart: always
```
