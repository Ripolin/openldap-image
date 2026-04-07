# Bitnami-compatible OpenLDAP image

A drop-in replacement for the [Bitnami OpenLDAP image](https://github.com/bitnami/containers/blob/main/bitnami/openldap/README.md), built entirely from open-source components.

**Key differences from the official Bitnami image:**
- OpenLDAP is compiled directly from the [upstream sources](https://github.com/openldap/openldap) (no Bitnami-built tarball)
- Base image is `debian:13-slim` instead of Bitnami's `minideb`

## Quick start

```yaml
# docker-compose.yml
services:
  openldap:
    image: ghcr.io/ripolin/openldap:latest
    ports:
      - '1389:1389'
      - '1636:1636'
    environment:
      - LDAP_ADMIN_USERNAME=admin
      - LDAP_ADMIN_PASSWORD=adminpassword
      - LDAP_USERS=user01,user02
      - LDAP_PASSWORDS=password1,password2
    volumes:
      - openldap_data:/bitnami/openldap

volumes:
  openldap_data:
```

## Available tags

| Tag                                           | OpenLDAP version | Base OS        |
|-----------------------------------------------|------------------|----------------|
| `latest`, `2.6`, `2.6.13`, `2.6.13-debian-13` | 2.6.13           | Debian 13 slim |

Images are published to [ghcr.io/ripolin/openldap](https://github.com/Ripolin/openldap/pkgs/container/openldap) for `linux/amd64` and `linux/arm64`.

## Compiled modules

In addition to the standard overlays, the following contrib modules are included:

| Module      | Description                                                |
|-------------|------------------------------------------------------------|
| `autogroup` | Automatic group membership management                      |
| `lastbind`  | Records the last successful bind time                      |
| `pbkdf2`    | PBKDF2 password hashing scheme                             |
| `sha2`      | SHA-2 password hashing schemes (SHA-256, SHA-384, SHA-512) |
| `smbk5pwd`  | Samba and Kerberos password synchronization                |

## Configuration

This image is fully compatible with the Bitnami OpenLDAP image configuration. All environment variables, volumes, and entrypoint scripts behave identically.

See the [Bitnami OpenLDAP documentation](https://github.com/bitnami/containers/blob/main/bitnami/openldap/README.md) for the full list of configuration options.

## Building locally

```sh
cd 2.6/debian-13
docker build -t openldap:local .
```

## License

Apache 2.0 — see [LICENSE](LICENSE).
