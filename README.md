# How to start all the things

1. Make sure you have [Docker installed](https://docs.docker.com/get-docker/)

2. Check if you have Docker running:

```sh
$ docker info
```

3. Start Jetty, Fuseki and WIDOCO:

```sh
$ ./start
```

4. Point browser to `http://localhost:8080/fuseki`.

5. Stop all the services:

```sh
$ ./stop
```

## Tip for restarting everything:

```sh
$ sh stop && sh start
```

## Infra TODO

- WIDOCO currently outputs all ontology documentation to a single page, so we don't need a web server. This should be changed in final version to be hosted by some http server

- the chart webapp should be hosted by a http server too

- CORS in fuseki double check