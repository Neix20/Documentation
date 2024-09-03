
# Ansible

This directory is used for me to familiarize myself with Ansible Playbooks

## Repositories

## Basics of Ansible

Lets first talk about file structure

```shell
.
├── ansible.cfg
├── assets
│   ├── auth.htpasswd
│   ├── nginx.conf
│   └── public.tar.gz
├── inventory
│   └── hosts
├── neix-key
├── playbooks
│   └── starter.yml
└── vm-witsh_key.pem
```

Within the folder, there will always be a `hosts`, `starter.yml` and optionally, `ansible.cfg`

### What is Hosts File?

Hosts file, is a file that contains all the server information of your servers.

It contains:

- Server IP
- You may group the servers together, for example, `[ubuntu]`

```yaml
[ubuntu]
20.15.97.91 ansible_ssh_user=root-witsh ansible_ssh_private_key_file=./Starter/vm-witsh_key.pem
```

### What is starter.yml?

`starter.yml` is the main ansible playbook. Ansible playbook, is the type of file, where it contains all the server steps to run on your servers

```yaml
---
- name: Starter Playbook for Fresh Server
  hosts: ubuntu
  become: true
  vars: []
  tasks:
    - name: Update & Upgrade APT Version
      ansible.builtin.apt:
        force: true
        update_cache: true
        upgrade: "yes"
```

### What is ansible.cfg?

`ansible.cfg` is similar to .env, where it is the configuration for Ansible. Here, you will store location of inventory hosts or other information

```ini
[defaults]
INVENTORY = ./inventory/hosts

[ssh_connections]
pipelining = true
```

### Commonly Used Modules

#### File Operations

```yaml
- name: Copy a file
  copy:
    src: /path/to/source
    dest: /path/to/destination
```

```yaml
- name: Remove a file
  file:
    path: /path/to/file
    state: absent
```

```yaml
- name: Create a Directory
  file:
    path: /path/to/directory
    state: directory
```

```yaml
- name: Remove Directory
  file:
    path: /path/to/directory
    state: absent
```

```yaml
- name: Update file permissions
  file:
    path: /path/to/file
    mode: '0755'
```

```yaml
- name: Create a new file
  file:
    path: /path/to/myfile.txt
    state: touch
```

#### HTTP Method

```yaml
- name: Make HTTP Get Request
  uri:
    url: https://swapi.dev/api/people/
  register: swapi
- debug:
  var: swapi
```

#### Archiving Operation

```yaml
- name: Unpackage deploy.tar.gz
  # Comment
  unarchive:
    src: /opt/deploy.tar.gz
    dest: /opt/my-app
```

```yaml
- name: Archive Files Together
  archive:
    path: /apps/tomcat/logs/catalina.2019-07-24.log
    dest: /apps/tomcat/catalina.2019-07-24.log.zip
    format: zip
```

#### Shell Operations

```yaml
- name: Check processes
  shell: ps aux | grep some_process
  register: process_list
- debug:
    var: process_list.stdout
```

```yaml
- name: Check service status
  service:
    name: some_service
    state: started
```

#### Task Schedule Operations

```yaml
- name: Schedule a cron job
  cron:
    name: "My cron job"
    minute: "0"
    hour: "2"
    job: "/path/to/command"
```

#### Install File

```yaml
- name: "Install Nginx to version {{ nginx_version }}"
  apt:
    name: "nginx={{ nginx_version }}"
    state: present
```

```yaml
 - name: Install Required Packages
  ansible.builtin.apt:
    pkg:
      - nginx
      - p7zip-full
    state: latest
    update_cache: true
```

#### Line In File

```yaml
- name: Insert a line after a specific pattern
  lineinfile:
    path: /home/ubuntu/file.txt
    line: "This is the new line"
    insertafter: "^Pattern to match"
```

#### File Templating

```yaml
- name: Copy the Nginx configuration file to the host
  template:
    src: templates/nginx.conf.j2
    dest: /etc/nginx/sites-available/default
```

## Ansible Ad-Hoc Command

```shell

# Youtube
# https://www.youtube.com/watch?v=w9eCU4bGgjQ
# https://www.youtube.com/watch?v=SvcOwBFLVLM
# https://www.youtube.com/watch?v=Z7p9-m4cimg

# Docs
# https://spacelift.io/blog/ansible-playbooks
# https://github.com/leucos/ansible-tuto
# https://stackoverflow.com/questions/57919339/how-to-run-ansible-playbook-using-a-public-ssh-key

# Ansible Get Number of Modules
ansible-doc -l | wc -l > /root/modules

# Ping All File In Hosts
ansible all -m ping

# Run Ad Hoc Command
ansible all -m shell -a 'hostname'

# Format
ansible <hosts-group> ...
ansible servers -i /root/hosts -m ping

# Ping All The Hosts
ansible <hosts-group> -i <host-name> ...
ansible ubuntu -i ./inventory/hosts -m ping --user ubuntu

# List All Hosts in Ansible
ansible-inventory -i /root/hosts --list

# Graph Output
ansible-inventory -i /root/hosts --graph

# Yaml Output
ansible-inventory -i /root/hosts --list -y

# Get Servers Uptime
ansible servers -i /root/hosts -m shell -a 'uptime'

# Get Servers OS Version
ansible -i /root/hosts <host-name> -m shell -a 'uname -a'
ansible -i /root/hosts ubuntu -m shell -a 'uname -a'
ansible -i /root/hosts servers  -m shell -a 'uname -a'

ansible servers -i /root/hosts -m file -a 'path=/opt/deployment state=directory'
ansible servers -i /root/hosts -m shell -a 'cd /opt && mkdir deployment'

ansible servers -i /root/hosts -m copy -a 'src=/root/configfile.cfg dest=/opt/deployment'

# Run Playbooks
ansible-playbook -i <hosts-location> <playbook-location>
ansible-playbook -i /root/hosts /root/deploy.yml

```

## Ansible Variables

## Ansible Handlers

## Ansible Templates

## Ansible Roles

## Ansible Galaxy

For this scenario, assume we want to use Ansible to Install PHP on list of servers

To Search for PHP Galaxy, use the following command

```shell
ansible-galaxy search "<term>"
ansible-galaxy search "PHP"
```

Once you have searched for the term, you will be prompted a list. To download the galaxy, (similar to git), run the following command

```shell
Name                            Description
----                            -----------
alikins.php                     PHP for RedHat/CentOS/Fedora/Debian/Ubuntu.
```

```shell
ansible-galaxy install alikins.php
```

To use the following role, add it to your `playbook.yml`

```yaml
---
- hosts: all
  become: true
  roles:
    - alikins.php
  vars:
    - doc_root: /var/www/example
    - php_default_version_debian: "7.2"
```
