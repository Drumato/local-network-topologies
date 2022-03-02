all: gobgp_3.0.0_linux_amd64.tar.gz unarchive build

gobgp_3.0.0_linux_amd64.tar.gz:
	@wget https://github.com/osrg/gobgp/releases/download/v3.0.0/gobgp_3.0.0_linux_amd64.tar.gz

unarchive:
	@mkdir -p gobgp
	@tar xvf gobgp_3.0.0_linux_amd64.tar.gz -C gobgp

build:
	docker image build -t gobgp:v3.0.0 .
