[web_servers]
web_server ${host}

[all:vars]
ansible_user=${user}
ansible_ssh_extra_args='-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
public_dns=${public_dns}
api_key=${api_key}
