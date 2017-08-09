FROM tomcat:latest

MAINTAINER macroth@gmail.com

USER root

RUN mkdir -p /opt/app && \
    mkdir -p /opt/script

ADD run.sh /opt/script/deploy.sh

VOLUME /opt/app/

EXPOSE 8080

WORKDIR /opt/app

CMD ["/opt/script/deploy.sh", "deploy"]