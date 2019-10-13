#!/bin/bash

gcloud compute instances create bastion \
	--boot-disk-size=10GB \
	--image-family=ubuntu-1604-lts \
	--image-project=ubuntu-os-cloud \
	--zone=europe-north1-a \
	--machine-type=f1-micro \
	--tags=vpn \
	--restart-on-failure \

gcloud compute instances create someinternalhost \
	--boot-disk-size=10GB \
	--image-family=ubuntu-1604-lts \
	--image-project=ubuntu-os-cloud \
	--machine-type=f1-micro \
	--zone=europe-north1-a \
	--tags=vpn \
	--restart-on-failure \
	--no-address

gcloud compute firewall-rules create "default-vpn-server" --allow tcp:80,tcp:443 \
	--source-ranges="0.0.0.0/0" \
	--description="vpn server" \