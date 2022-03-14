# Virtual University

Relevant artifacts can be found in the `data/` directory. f

## Contents

This repository contains all artifacts for the virtual university OIS project, including source code, a test database, generated RDF tuples, etc and a copy of the original report.

You may choose to download a zipped copy of the repositoy by pressing the green *Code* button at the top right, and selecting *Download ZIP*.

## Setup

Our services are started through a network of Docker containers, orchestrated through a `docker-compose.yaml` file. Naturally, this dictates the requirement for [Docker](https://docs.docker.com/get-docker/) and [docker-compose](https://docs.docker.com/compose/install/) to be installed on your system.

To run this project, navigate to your local copy of the project files provided with this reports, ensuring you are in the directory with the `docket-compose.yaml` file. Next, start the services by executing the following command:

```
docker-compose up --build
```

Following this, services should become available to your host computer. Navigate to [http://localhost:8080/fuseki]([http://localhost:8080/fuseki]) and upload the provided `virtual-university.ttl` and `vu-data.ttl` files to the `virtual-university` dataset already present in the web interface.

Verify the fuseki dataset has been populated by pointing your browser to [http://localhost:8081](http://localhost:8081). You should be greeted with the Virtual University web application containing a number of clickable teachers as seen in figure 13 in the report.

## WIDOCO

Ontology documentation generated by WIDOCO can be found in the `data/public/directory`, following a succesful `docker-compose up --build` command. Alternatively, you can browse the documentation through a web server located at http://localhost:8082/index-en.html .


## Troubleshooting

At any point, services may be restarted using the following command:

```
docker compose down -v && \
docker-compose up --build
```

If any of the containers fail to start, ensure the following TCP/IP ports are unbound:
- :8080, for Apache Jetty and Apache Jena Fuseki2 
- :8081, for the Virtual University web application
- :8082, for the WIDOCO documentation web server

