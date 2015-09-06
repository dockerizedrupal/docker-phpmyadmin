FROM dockerizedrupal/base-debian-jessie:1.0.3

MAINTAINER Jürgen Viljaste <j.viljaste@gmail.com>

ENV TERM xterm

ADD ./src /src

RUN /src/entrypoint.sh build

VOLUME ["/phpmyadmin"]

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/src/entrypoint.sh", "run"]
