FROM frrouting/frr:v7.5.1

COPY gobgp/gobgp gobgp
COPY gobgp/gobgpd gobgpd

COPY r1.toml r1.toml
COPY r2.toml r2.toml

RUN apk add iperf tcpdump