FROM tomcat:latest

MAINTAINER macroth@gmail.com

USER root

RUN mkdir -p /opt/app && \
    mkdir -p /opt/script && \

add deploy.sh /opt/script/deploy.sh

VOLUME /opt/app/

WORKDIR /opt/app

CMD ["/opt/script/deploy.sh", "deploy"]