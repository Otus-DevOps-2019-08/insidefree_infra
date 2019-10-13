# insidefree_infra
insidefree Infra repository

## Task 5
add SSH keys
GCP path: Compute Engine - Metadata
Generate SSH key
```
ssh-keygen -t rsa -f ~/.ssh/<file_name> -C <user_name> -P ""
```
Create VM instance wit h external IP address

add ssh key to Metadata -> SSH keys

Connect by SSH from local
```
ssh -i ~/.ssh/<file_name> -A -t <user_name>@<external IP VM> <user_name>@<internal IP>
```

ssh config file
```
Host bastion
	HostName 35.228.137.120
	IdentityFile ~/.ssh/appuser
	User appuser

Host someinternalhost
	HostName 10.166.0.3
	IdentityFile ~/.ssh/appuser
	Port 22
	User appuser
	ProxyCommand ssh -q -W %h:%p bastion

Host reddit-app
	HostName 34.89.134.213
	IdentityFile ~/.ssh/appuser
	User appuser
```

bastion_IP = 35.228.137.120
someinternalhost_IP = 10.166.0.3