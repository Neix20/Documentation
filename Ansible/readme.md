
# Ansible

This directory is used for me to familiarize myself with Ansible Playbooks

## Repositories

- <https://github.com/leucos/ansible-tuto>
- <https://github.com/devopsjourney1/ansible-labs>
- <https://github.com/mpsOxygen/ansible>
- <https://medium.com/@thebaldevyadav/how-to-use-ansible-roles-b3345acd1cda>
- <https://iam-athirakk.medium.com/mastering-ansible-roles-structuring-reusability-and-best-practices-6b593e8ac124>

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

```yaml
- name: Insert a line based on line number
  lineinfile:
    path: /home/ubuntu/file.txt
    line: "This is the new line"
    insertafter: 5
```

```yaml
- name: Replace Line Based on Regex, Lines that start with var1
  lineinfile:
    path: /path/to/file.txt
    regexp: "^var1"
    line: "var1=111111"
```

```yaml
- name: Insert a New line
  lineinfile:
    path: /path/to/file.txt
    line: "Line To Replace"
    state: present
    create: true
```

```yaml
- name: Remove Line
  lineinfile:  
    path: /path/to/file.txt
    regexp: "^Pattern to match"
    state: absent
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

# Get Information About Servers
ansible -i /root/hosts servers  -m setup

# Filter With Specific Information
ansible servers -i /root/hosts -m setup -a 'filter=ansible_distribution' > /root/version

ansible servers -i /root/hosts -m file -a 'path=/opt/deployment state=directory'
ansible servers -i /root/hosts -m shell -a 'cd /opt && mkdir deployment'

ansible servers -i /root/hosts -m copy -a 'src=/root/configfile.cfg dest=/opt/deployment'

# Run Playbooks
ansible-playbook -i <hosts-location> <playbook-location>
ansible-playbook -i /root/hosts /root/deploy.yml

```

## Ansible Variables

To use variables inside your playbook, wrap your variable in `{{` and ``}}``

```shell
Here comes a variable {{ variable1 }}
```

To use variable, you need 2 folders, `host_vars` and `group_vars`

`host_vars` is where you place the hosts directly, for example `node02.yml`

`group_vars` is where you place the groups directly, for example, `server.yml`

Place it in a yaml format

```yaml
---
stage: dev
```

## Ansible Handlers

*It is basically post-commit hooks, where it runs after you trigger a git push*

Sometimes when a task does make a change to the system, an additional task or tasks may need to be run. For example, a change to a service’s configuration file may then require that the service be restarted so that the changed configuration takes effect.

Here Ansible’s handlers come into play. Handlers can be seen as inactive tasks that only get triggered when explicitly invoked using the "notify" statement. Read more about them in the Ansible Handlers documentation.

```yaml
---
- name: manage httpd.conf
  ...
  tasks:
  - name: Copy Apache configuration file
    ....
    notify:
        - restart_apache
  handlers:
    - name: restart_apache
      service:
        name: httpd
        state: restarted
```

So what’s new here?

The "notify" section calls the handler only when the copy task actually changes the file. That way the service is only restarted if needed - and not each time the playbook is run.
The "handlers" section defines a task that is only run on notification.

## Ansible Templates

Template is how you replace a file

## Ansible Roles

Roles is basically Ansible Modules, or Library, if you want programtically

```shell
ansible-galaxy init role_name
```

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
