FROM alpine:latest AS build-env

WORKDIR /usr/local/src

RUN apk add --no-cache curl gcc libc-dev make

RUN mkdir ./makefile2graph

RUN curl -fsSL -o ./makefile2graph.zip https://github.com/lindenb/makefile2graph/archive/master.zip

RUN unzip -j ./makefile2graph.zip -d ./makefile2graph

RUN make -C ./makefile2graph

FROM alpine:latest

WORKDIR /root

RUN apk add --no-cache bash graphviz make

COPY --from=build-env /usr/local/src/makefile2graph/make2graph /usr/local/bin/make2graph
COPY --from=build-env /usr/local/src/makefile2graph/makefile2graph /usr/local/bin/makefile2graph

ENTRYPOINT ["/usr/local/bin/make2graph"]
