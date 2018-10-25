# docker-bimserver

Thanks to _ianblenke_ for the dockerized bimserver, that was used for forking.

# Build

## Using docker

`docker build --build-arg BIMSERVER_VERSION=1.5.109 -t docker-bimserver:1.5.109 .`

## Using docker-compose

`docker-compose build`

# Run

* `docker run -p 8080:8080 -e "TOMCAT_USER=tom" -e "TOMCAT_PASSWORD=cat" -it docker-bimserver:1.5.109`
* open browser and go to http://localhost:8080/
