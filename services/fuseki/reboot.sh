#!/bin/sh
docker build -t jetty-ois . && docker run -it -p 8080:8080 jetty-ois