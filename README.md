# GetYourData Ansible playbook

This repository contains an [Ansible](http://docs.ansible.com/ansible/) playbook that can be used to install and deploy a working live copy of GetYourData Django web application using nginx as the web server, Redis as the in-memory LRU cache and uWSGI as the app server.

The playbook has been tested more thoroughly on CentOS 7, although untested Debian support is also available. In addition, depending on your environment you'll have to do other minor changes to the playbook in order to deploy the web application correctly. These include configuring the HTTPS certificate as well as the git repository used for continuous deployment.

### Requirements

* A Linux server
  - accessible over SSH, with Python 2.6 support
  - with systemd as the init system (required for service files)
  - CentOS 7, for other distros you'll likely have to modify the playbook


### Setup

Install *pip* (a package manager for Python) and use it to install Ansible

```
sudo apt-get install python-pip
sudo pip install ansible
```

Clone this repository.

```
git clone https://github.com/sakset/ansible-getyourdata
```

Edit the hosts file to point towards the server you want to deploy the web application on.

```
[getyourdata]
YOUR_SERVER_IP	ansible_user=root
```

Create a configuration file in **group_vars/getyourdata** using **group_vars/example** as the example.

**Use Ansible's Vault feature to encrypt the configuration file if you're going to release your playbook publicly!**

```
ansible-vault create group_vars/getyourdata # Create an encrypted configuration file
ansible-vault edit group_vars/getyourdata # Edit the encrypted configuration file
```

For more details, read more [here](http://docs.ansible.com/ansible/playbooks_vault.html)**

Once you have finished configuring your environment, you should be able to run Ansible using the following command.

```
ansible-playbook -i hosts.site.yml
ansible-playbook -i hosts.site.yml --ask-vault-pass # If you have an encrypted configuration file
```

You can use the same command to update your deployed web application (eg. in case you have changed the configuration, or a new version of GetYourData has been released on GitHub...)