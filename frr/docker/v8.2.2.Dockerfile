FROM frrouting/frr:v8.2.2
USER root
RUN mkdir -p /etc/frr
COPY daemons /etc/frr/daemons
RUN apk add tcpdump