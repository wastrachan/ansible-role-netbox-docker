# Netbox Docker

Ansible role to configure Netbox as a docker-compose project.

## Installation

Install this role with Ansible Galaxy:

`ansible-galaxy install git+https://github.com/wastrachan/ansible-role-netbox-docker.git`

## Local Installation

If you'd like to include this role directly in a playbook, set your [`roles_path`](https://docs.ansible.com/ansible/latest/reference_appendices/galaxy.html#roles-path) to `./roles` via environment variable or `ansible.cfg`.

Then, add this role to your playbook's `requirements.yml`:

```
- src: https://github.com/wastrachan/ansible-role-netbox-docker
  version: master
  name: netbox-docker
```

And finally, install the role with Ansible Galaxy:

`ansible-galaxy install -r requirements.yml`

## Requirements

`docker` and `docker-compose` must be available and installed on the target system.

## Role Variables

Configuration and installation options are made available as variables. Some of these (`secret_key`, passwords) _must_ be overridden before use!

| Option                                         | Default                                       | Description                                                                                                                                             |
| ---------------------------------------------- | --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `netbox_base_dir`                              | `/opt/netbox`                                 | Root path for netbox's docker-compose file and data store                                                                                               |
| `netbox_path_media`                            | -                                             | If set, points to a bind mount directory with netbox' media files. Otherwise docker volumes are used.                                                   |
| `netbox_path_postgres`                         | -                                             | If set, points to a bind mount directory with postgresql data files. Otherwise docker volumes are used.                                                 |
| `netbox_path_valkey`                           | -                                             | If set, points to a bind mount directory with valkey data files. Otherwise docker volumes are used.                                                     |
| `netbox_port`                                  | `8080`                                        | Host port to expose netbox on. If blank, netbox's port is not exposed                                                                                   |
| `netbox_netbox_image`                          | `docker.io/netboxcommunity/netbox:v4.1-3.0.1` | Netbox docker image tag                                                                                                                                 |
| `netbox_valkey_image`                          | `docker.io/valkey/valkey:8.0-alpine`          | Valkey docker image tag                                                                                                                                 |
| `netbox_postgres_image`                        | `docker.io/postgres:16-alpine`                | Postgres docker image tag                                                                                                                               |
| `netbox_caddy_image`                           | `docker.io/caddy:2-alpine`                    | Caddy docker image tag                                                                                                                                  |
| `netbox_admin_api_token`                       | -                                             | API token for the default admin user, created on first run                                                                                              |
| `netbox_admin_email`                           | `admin@example.com`                           | Email of the default admin user, created on first run                                                                                                   |
| `netbox_admin_password`                        | `admin`                                       | Password for the default admin user, created on first run                                                                                               |
| `netbox_admin_username`                        | `admin`                                       | Username of the default admin user, created on first run                                                                                                |
| `netbox_allowed_hosts`                         | `*`                                           | If set, connections will be restricted to this list host names (also used in caddy)                                                                     |
| `netbox_cors_origin_allow_all`                 | `true`                                        | If set to true, all CORS origins will be allowed                                                                                                        |
| `netbox_cors_origin_whitelist`                 | `http://localhost`                            | Whitelist of acceptable CORS origin headers                                                                                                             |
| `netbox_default_page_size`                     | `250`                                         | Default number of objects for paginated views                                                                                                           |
| `netbox_email_certfile`                        | -                                             | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)                                       |
| `netbox_email_from`                            | `netbox@bar.com`                              | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)                                       |
| `netbox_email_keyfile`                         | -                                             | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)                                       |
| `netbox_email_password`                        | -                                             | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)                                       |
| `netbox_email_port`                            | `25`                                          | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)                                       |
| `netbox_email_server`                          | `localhost`                                   | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)                                       |
| `netbox_email_timeout`                         | `5`                                           | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)                                       |
| `netbox_email_use_ssl`                         | `false`                                       | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)                                       |
| `netbox_email_use_tls`                         | `false`                                       | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)                                       |
| `netbox_email_username`                        | `netbox`                                      | [Email server settings documentation](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-EMAIL_HOST)                                       |
| `netbox_enforce_global_unique`                 | `false`                                       | Enforcement of unique IP space can be toggled on a per-VRF basis. To enforce unique IP space within the global table, set this to true                  |
| `netbox_graphql_enabled`                       | `true`                                        | Enable GraphQL API                                                                                                                                      |
| `netbox_housekeeping_interval`                 | `86400`                                       | Interval to run housekeeping worker                                                                                                                     |
| `netbox_container_labels`                      | `[]`                                          | Optional extra container labels to apply to the netbox container. See [Traefiknginx-proxy Support](#traefiknginx-proxy-support)                         |
| `netbox_container_env`                         | `[]`                                          | Optional extra container environment variables to apply to the netbox container. See [Traefik/nginx-proxy Support](#traefiknginx-proxy-support)         |
| `netbox_login_required`                        | `false`                                       | Whether or not a user must be authenticated to view DCIM details in Netbox                                                                              |
| `netbox_max_page_size`                         | `1000`                                        | Maximum number of objects for paginated API requests                                                                                                    |
| `netbox_metrics_enabled`                       | `false`                                       | Expose Prometheus monitoring metrics at the HTTP endpoint '/metrics'                                                                                    |
| `netbox_pg_db`                                 | `netbox`                                      | Postgres database name                                                                                                                                  |
| `netbox_pg_host`                               | `postgres`                                    | Postgres database host. This should not be changed if using the default docker-compose setup.                                                           |
| `netbox_pg_password`                           | `RANDOM_SEED`                                 | Postgres password                                                                                                                                       |
| `netbox_pg_user`                               | `netbox`                                      | Postgres user                                                                                                                                           |
| `netbox_additional_network_names`              | -                                             | Extra external networks to attach to the netbox container. See [Traefik/nginx-proxy Support](#traefiknginx-proxy-support)                               |
| `netbox_valkey_cache_host`                     | `valkey-cache`                                | Valkey cache instance host. This should not be changed if using the default docker-compose setup.                                                       |
| `netbox_valkey_cache_insecure_skip_tls_verify` | `false`                                       | If true, certificates for valkey cache are not checked                                                                                                  |
| `netbox_valkey_cache_password`                 | `RANDOM_SEED`                                 | Valkey cache instance password                                                                                                                          |
| `netbox_valkey_cache_ssl`                      | `false`                                       | If true, communication with valkey is secured with SSL                                                                                                  |
| `netbox_valkey_host`                           | `valkey`                                      | Valkey instance host. This should not be changed if using the default docker-compose setup.                                                             |
| `netbox_valkey_insecure_skip_tls_verify`       | `false`                                       | If true, certificates for valkey are not checked                                                                                                        |
| `netbox_valkey_password`                       | `RANDOM_SEED`                                 | Valkey instance password                                                                                                                                |
| `netbox_secret_key`                            | `RANDOM_SEED`                                 | [Netbox secret key](https://docs.djangoproject.com/en/stable/ref/settings/#std:setting-SECRET_KEY). Should be at least 50 characters long               |
| `netbox_skip_startup_scripts`                  | `false`                                       | If true, do not run startup scripts on container start                                                                                                  |
| `netbox_skip_superuser`                        | `false`                                       | If true, do not create superuser on container start                                                                                                     |
| `netbox_webhooks_enabled`                      | `true`                                        | If true, enable netbox webhooks functionality                                                                                                           |
| `netbox_use_caddy`                             | `false`                                       | If set, Caddy will be used to serve Netbox over TLS                                                                                                     |
| `netbox_caddy_letsencrypt_email`               | -                                             | Email address to use for letsencrypt automatic certificate generation                                                                                   |
| `netbox_caddy_http_port`                       | `80`                                          | Caddy HTTP port                                                                                                                                         |
| `netbox_caddy_https_port`                      | `443`                                         | Caddy HTTPS port                                                                                                                                        |
| `netbox_ssl_cert_bundle`                       | -                                             | Caddy certificate bundle                                                                                                                                |
| `netbox_ssl_cert_key`                          | -                                             | Caddy certificate key                                                                                                                                   |
| `netbox_extra_config`                          | -                                             | If provided, this string will be rendered in [`config/extra.py`](https://github.com/netbox-community/netbox-docker/blob/release/configuration/extra.py) |
| `netbox_custom_pipeline_content`               | -                                             | If provided, this string will be rendered in `/opt/netbox/netbox/netbox/custom_pipeline.py`                                                             |

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: servers
  roles:
    - netbox-docker
```

## TLS for localhost

Developing locally and testing TLS (i.e. https) features often poses a challenge. This guide is intended for people developing with, on or for NetBox or NetBox Docker on their computer. It allows to access NetBox Docker through TLS on https://localhost:443, https://127.0.0.1:443 and https://[::1]:443. It is based on the setup recommended by the [Netbox-Docker wiki on TLS](https://github.com/netbox-community/netbox-docker/wiki/TLS#tls-for-localhost).
First install `mkcert` on your computer. It creates and installs a local CA-Certificate, which will be used by mkcert to create and sign other certificates. This way, your certificates are trusted on your own computer and you don't get a TLS warning in your tools (browsers, cURL, and so forth).

Begin by creating the certificates for localhost and it's IPv4 and IPv6 addresses using the following commands.

```shell
mkcert -install
mkcert localhost 127.0.0.1 ::1
```

This should have created a file called `localhost+2.pem` and another file called `localhost+2-key.pem`. Use these two certificates with a slight modification of the setup proposed above:

```yaml
- hosts: localhost
  vars:
    netbox_port: null
    netbox_use_caddy: true
    netbox_ssl_cert_bundle: path_to/localhost+2.pem
    netbox_ssl_cert_key: path_to/localhost+2-key.pem
  roles:
    - netbox-docker
```

## Traefik/nginx-proxy Support

This playbook can be used with [traefik](https://hub.docker.com/_/traefik) or jwilder's [nginx-proxy](https://hub.docker.com/r/jwilder/nginx-proxy) by adding labels with `netbox_container_labels`, or environment variables with `netbox_container_env`, respectively. Additionally, `netbox_additional_network_names` will attach the netbox service to additional networks, as traefik/nginx-proxy usually reside in a network other than that created by docker-compose projects. While not a complete guide to these services, your configuration may look like the below:

#### traefik

```yaml
netbox_port: null
netbox_additional_network_names:
  - traefik
netbox_container_labels:
  traefik.enable: "true"
  traefik.http.services.netbox.loadbalancer.server.port: "8080"
  traefik.http.routers.netbox.rule: "Host(`netbox.domain.com`)"
```

#### nginx-proxy

```yaml
netbox_port: null
netbox_additional_network_names:
  - nginx
netbox_container_env:
  VIRTUAL_HOST: netbox.domain.com
  VIRTUAL_PORT: "8080"
```

## License

This project itself is licensed under the terms of the [MIT License](LICENSE). View [license information](https://github.com/netbox-community/netbox/blob/develop/LICENSE.txt) for software contained within.
