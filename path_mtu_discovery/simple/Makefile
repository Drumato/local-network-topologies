all: build test
build: routers servers
	ip netns exec r1 \
		ip route add 192.168.200.0/24 via 192.168.0.200 dev r1-eth0
	ip netns exec r2 \
		ip route add 192.168.100.0/24 via 192.168.0.100 dev r2-eth0

routers: pre-routers r1 r2

pre-routers:
	ip netns add r1
	ip netns add r2

servers: pre-servers s1 s2

pre-servers:
	ip netns add s1
	ip netns add s2

r1:
	ip netns exec $@ \
		ip link add name $@-eth0 \
		mtu 1400 \
		type veth peer name r2-eth0 \
		mtu 1400 \
		netns r2
	ip netns exec $@ \
		ip link set dev $@-eth0 netns $@
	ip netns exec $@ \
		ip link set dev lo up
	ip netns exec $@ \
		ip link set dev $@-eth0 up
	ip netns exec $@ \
		ip addr add 192.168.0.100/16 dev $@-eth0


r2:
	ip netns exec $@ \
		ip link set dev lo up
	ip netns exec $@ \
		ip link set dev $@-eth0 up
	ip netns exec $@ \
		ip addr add 192.168.0.200/16 dev $@-eth0

s1:
	ip netns exec $@ \
		ip link add name $@-eth1 \
		type veth peer name r1-eth1 \
		netns r1
	ip netns exec $@ \
		ip link set dev $@-eth1 netns $@
	ip netns exec $@ \
		ip link set dev lo up
	ip netns exec $@ \
		ip link set dev $@-eth1 up
	ip netns exec r1 \
		ip link set dev r1-eth1 up
	ip netns exec $@ \
		ip addr add 192.168.100.254/24 dev $@-eth1
	ip netns exec r1 \
		ip addr add 192.168.100.1/24 dev r1-eth1
	ip netns exec $@ \
		ip route add default via 192.168.100.1 dev $@-eth1

s2:
	ip netns exec $@ \
		ip link add name $@-eth1 \
		type veth peer name r2-eth1 \
		netns r2
	ip netns exec $@ \
		ip link set dev $@-eth1 netns $@
	ip netns exec $@ \
		ip link set dev lo up
	ip netns exec $@ \
		ip link set dev $@-eth1 up
	ip netns exec r2 \
		ip link set dev r2-eth1 up
	ip netns exec $@ \
		ip addr add 192.168.200.254/24 dev $@-eth1
	ip netns exec r2 \
		ip addr add 192.168.200.1/24 dev r2-eth1
	ip netns exec $@ \
		ip route add default via 192.168.200.1 dev $@-eth1

test:
	ip netns exec r1 \
		ping -w 1 192.168.0.200 > /dev/null
	ip netns exec r2 \
		ping -w 1 192.168.0.100 > /dev/null
	ip netns exec s1 \
		ping -w 1 192.168.100.1 > /dev/null
	ip netns exec s2 \
		ping -w 1 192.168.200.1 > /dev/null

clean:
	ip netns del r1
	ip netns del r2
	ip netns del s1
	ip netns del s2
