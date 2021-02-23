# Icinga_HostObject_Template

To add multiple linux clients templates on Icinga server host configuration path  based on Environment (Prod,PreProd,Dev,Test).
This ansible-playbook contains a jinja2 template that is used to get facts from managed hosts using magic variables -

```
  object Host "{{ hostvars[item]['ansible_fqdn'] }}" {
  import "generic-host"
  address = "{{ host_address }}"
  vars.os = "{{ hostvars[item]['ohai_hostnamectl']['operating_system'] }}"
}
```
Template can by modified with data that requires to be added as needed.

Usage:
- To verify if following key(some keys can be deprecated in older version of OS) is available run -
```
  $ ansible all -m setup  --tree /tmp/facts  -u  -k -K
```
- Run playbook using ID which as sudo privileges -
```
  $ ansible-playbook -i <path to inventory file> ~/client.yml -K
  e.g.
  $ ansible-playbook -i /etc/ansible/hosts client.yml -K   [ where client.yml playbook is in current path ]
```
