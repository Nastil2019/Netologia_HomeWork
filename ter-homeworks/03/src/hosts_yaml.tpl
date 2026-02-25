all:
  children:
    webservers:
      hosts:
%{ for vm in web_servers ~}
        ${vm.name}:
          ansible_host: ${vm.nat_ip}
          fqdn: ${vm.fqdn}
%{ endfor ~}
    databases:
      hosts:
%{ for vm in db_servers ~}
        ${vm.name}:
          ansible_host: ${vm.nat_ip}
          fqdn: ${vm.fqdn}
%{ endfor ~}
    storage:
      hosts:
%{ for vm in storage_servers ~}
        ${vm.name}:
          ansible_host: ${vm.nat_ip}
          fqdn: ${vm.fqdn}
%{ endfor ~}
    all:vars:
      ansible_user: ubuntu
      ansible_ssh_private_key_file: ~/.ssh/id_rsa