# insidefree_infra

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