FROM ubuntu:latest as stage1
LABEL maintainer="John Burt"

ENV DEBIAN_FRONTEND=noninteractive
ARG VERSION=1.4.0

RUN \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y libcairo2-dev libjpeg-turbo8-dev libpng-dev libtool-bin libossp-uuid-dev wget maven default-jdk > /dev/null && \
 wget http://archive.apache.org/dist/guacamole/${VERSION}/source/guacamole-client-${VERSION}.tar.gz && \
 tar -xzf guacamole-client-${VERSION}.tar.gz && \
 cd guacamole-client-${VERSION}/ && \
 export OPENSSL_CONF=/dev/null && \
 export JAVA_HOME=$(realpath /usr/bin/javadoc | sed 's@bin/javadoc$@@') && \
 mvn clean package -Plgpl-extensions && \
 echo $PWD


FROM alpine:latest
ARG VERSION

COPY --from=stage1 /guacamole-client-${VERSION}/extensions/guacamole-auth-radius/target/guacamole-auth-radius-${VERSION}.jar /guacamole-auth-radius-${VERSION}.jar

ENTRYPOINT ["/bin/sh"]
