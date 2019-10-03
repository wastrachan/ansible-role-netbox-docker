Netbox (Docker) Ansible Role
=============================
Ansible role to configure Netbox as a docker-compose project.


#### Installation
Install this role in your playbook with ansible galaxy:

```
ansible-galaxy install https://github.com/wastrachan/ansible-role-netbox
```

#### Configuration
Configuration and installation options are made available as variables. For a complete list, view the `defaults` for this role.
Some of the more important options avialable:

| Option | Default | Description
|--------|---------|------------
| `netbox_root_dir` | `/opt/netbox` | Root path for netbox's docker-compose file and data store
| `netbox_port`| `8080` | The port that the netbox nginx container will listen on.
| `netbox_login_required` | `true` | Whether or not a user must be authenticated to view DCIM details in Netbox. Please note that the _Netbox default_ is `false`.
| `netbox_admin_username` | `admin` | Username of the default admin user, created on first run
| `netbox_admin_email` | `admin@example.com` | Email of the default admin user, created on first run
| `netbox_admin_password` | `admin` | Password for the default admin user, created on first run

##### License
This project itself is licensed under the terms of the [MIT License](LICENSE). View [license information](https://github.com/netbox-community/netbox/blob/develop/LICENSE.txt) for software contained within.
