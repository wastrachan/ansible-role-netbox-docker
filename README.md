Netbox Docker
=============
Ansible role to configure Netbox as a docker-compose project.


Installation
------------
Install this role with Ansible Galaxy:

`ansible-galaxy install git+https://github.com/wastrachan/ansible-role-netbox-docker.git`


Local Installation
------------------
If you'd like to include this role directly in a playbook, set your [`roles_path`](https://docs.ansible.com/ansible/latest/reference_appendices/galaxy.html#roles-path) to `./roles` via environment variable or `ansible.cfg`.

Then, add this role to your playbook's `requirements.yml`:

```
- src: https://github.com/wastrachan/ansible-role-netbox-docker
  version: master
  name: netbox-docker
```

And finally, install the role with Ansible Galaxy:

`ansible-galaxy install -r requirements.yml`


Requirements
------------
`docker` and `docker-compose` must be available and installed on the target system.


Role Variables
--------------
Configuration and installation options are made available as variables. For a complete list, view `defaults/main.yml`.
Some of the options available:

| Option                  | Default             | Description
|-------------------------|---------------------|------------
| `netbox_base_dir`       | `/opt/netbox`       | Root path for netbox's docker-compose file and data store
| `netbox_login_required` | `true`              | Whether or not a user must be authenticated to view DCIM details in Netbox. Please note that the _Netbox default_ is `false`.
| `netbox_admin_username` | `admin`             | Username of the default admin user, created on first run
| `netbox_admin_email`    | `admin@example.com` | Email of the default admin user, created on first run
| `netbox_admin_password` | `admin`             | Password for the default admin user, created on first run


Example Playbook
----------------
Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
        - netbox-docker


Traefik/nginx-proxy Support
---------------------------
This playbook can be used with [traefik](https://hub.docker.com/_/traefik) or jwilder's [nginx-proxy](https://hub.docker.com/r/jwilder/nginx-proxy) by adding labels with `netbox_container_labels`, or environment variables with `netbox_container_env`, respectively. Additionally, `netbox_proxy_network_name` will attach the netbox service to an additional network, as traefik/nginx-proxy usually reside in a network other than that created by docker-compose projects. While not a complete guide to these services, your configuration may look like the below:

#### traefik
```yaml
netbox_port: null
netbox_proxy_network_name: 'default'
netbox_container_labels:
  traefik.enable: "true"
  traefik.http.services.netbox.loadbalancer.server.port: "8080"
  traefik.http.routers.netbox.rule: "Host(`netbox.domain.com`)"
```

#### nginx-proxy
```yaml
netbox_port: null
netbox_proxy_network_name: 'default'
netbox_container_env:
  VIRTUAL_HOST: netbox.domain.com
  VIRTUAL_PORT: "8080"
```


License
-------
This project itself is licensed under the terms of the [MIT License](LICENSE). View [license information](https://github.com/netbox-community/netbox/blob/develop/LICENSE.txt) for software contained within.
