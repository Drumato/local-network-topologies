FROM frrouting/frr-debian:latest
USER root
RUN mkdir -p /etc/frr
COPY daemons /etc/frr
RUN apt update && apt install -y tcpdump
