#!/bin/bash

for mode in simple-multipath
do
    tinet upconf -c $mode.yaml | sudo sh 2> /dev/null
    sleep 3

    mkdir -p outputs/$mode
    pushd outputs/$mode > /dev/null
    mkdir -p {bgp-sums,ribs,confs}

    for n in R1 C1 G1 G2
    do
        docker exec $n vtysh -c 'sh bgp sum' > bgp-sums/$n.out
        docker exec $n vtysh -c 'sh bgp sum json' > bgp-sums/$n.json
        docker exec $n vtysh -c 'sh bgp ipv4 unicast' > ribs/$n.out
        docker exec $n vtysh -c 'sh bgp ipv4 unicast json' > ribs/$n.json
        docker exec $n vtysh -c 'write mem' > /dev/null
        docker exec $n vtysh -c 'cat /etc/frr/frr.conf' > confs/$n-frr.conf
    done

    tinet down -c $mode.yaml | sudo sh 2> /dev/null
    popd > /dev/null
done
