FROM docker:dind

RUN apk add --no-cache py-pip git && pip install docker-compose

RUN apk add --update openssh

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG JENKINS_HOME=/var/jenkins_home

RUN mkdir -p $JENKINS_HOME \
  && chown ${uid}:${gid} $JENKINS_HOME \
  && addgroup -g ${gid} ${group} \
  && adduser -h "$JENKINS_HOME" -u ${uid} -G ${group} -s /bin/bash -D ${user}

RUN apk update
RUN apk fetch openjdk8
RUN apk add openjdk8

EXPOSE 22

# Default command
CMD ["/usr/sbin/sshd", "-D"]