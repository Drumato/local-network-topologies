set -eux

for num in 0 1
do
    docker exec RR$num vtysh -c 'sh bgp sum json' > bgp-sum/rr$num-bgp-sum.json
    docker exec RR$num vtysh -c 'sh bgp sum' > bgp-sum/rr$num-bgp-sum.out
    docker exec RR$num vtysh -c 'sh bgp ipv4 unicast json' > ribs/rr$num-ipv4-unicast.json
    docker exec RR$num vtysh -c 'sh bgp ipv4 unicast' > ribs/rr$num-ipv4-unicast.out
    docker exec RR$num vtysh -c 'write mem' > /dev/null
    docker exec RR$num bash -c 'cat /etc/frr/frr.conf' > configs/rr$num-frr.conf
done

for num in 0 1 2 3 4 5
do
    docker exec R$num vtysh -c 'sh bgp sum json' > bgp-sum/r$num-bgp-sum.json
    docker exec R$num vtysh -c 'sh bgp sum' > bgp-sum/r$num-bgp-sum.out
    docker exec R$num vtysh -c 'sh bgp ipv4 unicast json' > ribs/r$num-ipv4-unicast.json
    docker exec R$num vtysh -c 'sh bgp ipv4 unicast' > ribs/r$num-ipv4-unicast.out
    docker exec R$num vtysh -c 'write mem' > /dev/null
    docker exec R$num bash -c 'cat /etc/frr/frr.conf' > configs/r$num-frr.conf
done
