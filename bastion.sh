#!/bin/bash

gcloud compute instances create bastion \
	--boot-disk-size=10GB \
	--image=ubuntu-1604-xenial-v20191010 \
	--image-family=ubuntu-1604-lts \
	--zone=europe-north1-a \
	--machine-type=g1-small \
	--tags=vpn \
	--restart-on-failure \

gcloud compute instances create someinternalhost \
	--boot-disk-size=10GB \
	--image=ubuntu-1604-xenial-v20191010 \
	--image-family=ubuntu-1604-lts \
	--zone=europe-north1-a \
	--machine-type=g1-small \
	--tags=vpn \
	--restart-on-failure \
	--no-address

gcloud compute firewall-rules create "default-vpn-server" --allow tcp:80,tcp:443 \
	--source-ranges="0.0.0.0/0" \
	--description="vpn server" \