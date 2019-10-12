# Task 5
add SSH keys
GCP path: Compute Engine - Metadata
Generate SSH key
```
/>ssh-keygen -t rsa -f ~/.ssh/<file_name> -C <user_name> -P ""
```
Create VM instance wit h external IP address

add ssh key to Metadata -> SSH keys

checkk ssh agen :
/>ssh-add -L

add ssh agen:
/>ssh-add ~/.ssh/<user_name>

config ssh connection:
article : https://www.tecmint.com/access-linux-server-using-a-jump-host/

Connect by SSH from local
1 way:
```
/>ssh -i ~/.ssh/<file_name> -A -t <user_name>@<external IP VM> ssh <user_name>@<internal IP>
```
2 way:
```
ssh -i ~/.ssh/proxy -J <user_name>@<external IP VM> <user_name>@<internal IP>
```
3 way (ssh config file):
```
Host bastion
	HostName 35.204.143.72
	IdentityFile ~/.ssh/proxy
	User deploy

Host someinternalhost
	HostName 10.128.0.2
	IdentityFile ~/.ssh/proxy
	Port 22
	User deploy
	ProxyCommand ssh -q -W %h:%p bastion
```

# Task 6 - Basic services Google Cloud Platform (GCP)
testapp_IP = 34.89.134.213<br>
testapp_port = 9292

- install gcloud sdk
- create instance 
```
gcloud compute instances create reddit-app \
	--boot-disk-size=10GB \
	--image-family ubuntu-1604-lts \
	--image-project=ubuntu-os-cloud \
	--machine-type=g1-small \
	--tags puma-server \
	--restart-on-failure \
	--metadata startup-script='#! /bin/bash
	cd /home/appuser
	sudo apt-get update	
	sudo apt-get install -y ruby-full ruby-bundler build-essential
	export LC_ALL=C
	wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
	echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
	sudo apt-get update
	sudo apt-get install -y mongodb-org
	sudo systemctl start mongod
	sudo systemctl enable mongod
	git clone -b monolith https://github.com/express42/reddit.git
	cd reddit && bundle install
	puma -d
	'
```
- create firewall rule
```
gcloud compute firewall-rules create "default-puma-server" --allow tcp:9292 \
	--source-ranges="0.0.0.0/0" \
	--description="ruby test server" \
	--target-tags=puma-server
```