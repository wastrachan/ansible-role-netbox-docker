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
Configuration and installation options are made available as variables. Some of these (`secret_key`, passwords) _must_ be overridden before use!

| Option                                        | Default                          | Description
|-----------------------------------------------|----------------------------------|------------
| `netbox_base_dir`                             | `/opt/netbox`                    | Root path for netbox's docker-compose file and data store
| `netbox_port`                                 | `8080`                           | Host port to expose netbox on. If blank, netbox's port is not exposed
| `netbox_netbox_image`                         | `netboxcommunity/netbox:v3.3.5`  | Netbox docker image tag
| `netbox_redis_image`                          | `redis:7-alpine`                 | Redis docker image tag
| `netbox_postgres_image`                       | `postgres:14-alpine`             | Postgres docker image tag
| `netbox_admin_api_token`                      | -                                | API token for the default admin user, created on first run
| `netbox_admin_email`                          | `admin@example.com`              | Email of the default admin user, created on first run
| `netbox_admin_password`                       | `admin`                          | Password for the default admin user, created on first run
| `netbox_admin_username`                       | `admin`                          | Username of the default admin user, created on first run
| `netbox_allowed_hosts`                        | `*`                              | If set, connections will be restricted to this host header
| `netbox_cors_origin_allow_all`                | `true`                           | If set to true, all CORS origins will be allowed
| `netbox_cors_origin_whitelist`                | `http://localhost`               | Whitelist of acceptable CORS origin headers
| `netbox_default_page_size`                    | `250`                            | Default number of objects for paginated views
| `netbox_email_certfile`                       | -                                | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)
| `netbox_email_from`                           | `netbox@bar.com`                 | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)
| `netbox_email_keyfile`                        | -                                | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)
| `netbox_email_password`                       | -                                | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)
| `netbox_email_port`                           | `25`                             | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)
| `netbox_email_server`                         | `localhost`                      | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)
| `netbox_email_timeout`                        | `5`                              | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)
| `netbox_email_use_ssl`                        | `false`                          | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)
| `netbox_email_use_tls`                        | `false`                          | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)
| `netbox_email_username`                       | `netbox`                         | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)
| `netbox_enforce_global_unique`                | `false`                          | Enforcement of unique IP space can be toggled on a per-VRF basis. To enforce unique IP space within the global table, set this to true
| `netbox_graphql_enabled`                      | `true`                           | Enable GraphQL API
| `netbox_housekeeping_interval`                | `86400`                          | Interval to run housekeeping worker
| `netbox_container_labels`                     | `[]`                             | Optional extra container labels to apply to the netbox container. See [Traefiknginx-proxy Support](#traefiknginx-proxy-support)
| `netbox_container_env`                        | `[]`                             | Optional extra container environment variables to apply to the netbox container. See [Traefik/nginx-proxy Support](#traefiknginx-proxy-support)
| `netbox_login_required`                       | `false`                          | Whether or not a user must be authenticated to view DCIM details in Netbox
| `netbox_max_page_size`                        | `1000`                           | Maximum number of objects for paginated API requests
| `netbox_metrics_enabled`                      | `false`                          | Expose Prometheus monitoring metrics at the HTTP endpoint '/metrics'
| `netbox_napalm_password`                      | -                                | Credentials that NetBox will use to authenticate to devices when connecting via NAPALM
| `netbox_napalm_timeout`                       | `10`                             | Credentials that NetBox will use to authenticate to devices when connecting via NAPALM
| `netbox_napalm_username`                      | -                                | Credentials that NetBox will use to authenticate to devices when connecting via NAPALM
| `netbox_pg_db`                                | `netbox`                         | Postgres database name
| `netbox_pg_host`                              | `postgres`                       | Postgres database host. This should not be changed if using the default docker-compose setup.
| `netbox_pg_password`                          | `J5brHrAXFLQSif0K`               | Postgres password
| `netbox_pg_user`                              | `netbox`                         | Postgres user
| `netbox_proxy_network_name`                   | -                                | Extra external network to attach to the netbox container. See [Traefiknginx-proxy Support](#traefiknginx-proxy-support)
| `netbox_redis_cache_host`                     | `redis-cache`                    | Redis cache instance host. This should not be changed if using the default docker-compose setup.
| `netbox_redis_cache_insecure_skip_tls_verify` | `false`                          | If true, certificates for redis cache are not checked
| `netbox_redis_cache_password`                 | `H733Kdjndks81`                  | Redis cache instance password
| `netbox_redis_cache_ssl`                      | `false`                          | If true, communication with redis is secured with SSL
| `netbox_redis_host`                           | `redis`                          | Redis instance host. This should not be changed if using the default docker-compose setup.
| `netbox_redis_insecure_skip_tls_verify`       | `false`                          | If true, certificates for redis are not checked
| `netbox_redis_password`                       | `H733Kdjndks81`                  | Redis instance password
| `netbox_secret_key`                           | -                                | [Netbox secret key](https://docs.djangoproject.com/en/stable/ref/settings/#std:setting-SECRET_KEY). Should be at least 50 characters long
| `netbox_skip_startup_scripts`                 | `false`                          | If true, do not run startup scripts on container start
| `netbox_skip_superuser`                       | `false`                          | If true, do not create superuser on container start
| `netbox_webhooks_enabled`                     | `true`                           | If true, enable netbox webhooks functionality
| `netbox_extra_config`                         | -                                | If provided, this string will be rendered in [`config/extra.py`](https://github.com/netbox-community/netbox-docker/blob/release/configuration/extra.py)


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
