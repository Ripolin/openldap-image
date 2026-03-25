FROM mcr.microsoft.com/vscode/devcontainers/cpp:dev-debian13 AS build

ADD https://github.com/openldap/openldap.git#OPENLDAP_REL_ENG_2_6_13 /tmp/openldap

WORKDIR /tmp/openldap

RUN apt-get update && \
    apt-get install -y \
        libsasl2-dev && \
    ./configure \
        --enable-overlays \
        --enable-spasswd \
        --prefix=/opt/bitnami/openldap \
        --with-cyrus-sasl \
        --with-subdir="" && \
    make depend && \
    make && \
    make install && \
    rm -rf /opt/bitnami/openldap/share/man

FROM docker.io/debian:13-slim

ENV HOME="/" \
    OS_FLAVOUR="debian-13" \
    OS_NAME="linux"

COPY prebuildfs /
SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c"]
# Install required system packages and dependencies
RUN install_packages ca-certificates libargon2-1 libcap2-bin libcom-err2 libcrypt1 libgssapi-krb5-2 libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0 libltdl7 libnsl2 libnss3-tools libodbc2 libperl5.40 libsasl2-2 libssl3 libtirpc3 libwrap0 mdbtools procps psmisc

COPY --from=build /opt/bitnami/openldap /opt/bitnami/openldap

RUN apt-get update && apt-get upgrade -y && \
    apt-get clean && rm -rf /var/lib/apt/lists /var/cache/apt/archives
RUN chmod g+rwX /opt/bitnami
RUN find / -perm /6000 -type f -exec chmod a-s {} \; || true

COPY rootfs /
RUN /opt/bitnami/scripts/openldap/postunpack.sh
ENV APP_VERSION="2.6.13" \
    BITNAMI_APP_NAME="openldap" \
    IMAGE_REVISION="0" \
    PATH="/opt/bitnami/openldap/libexec:/opt/bitnami/openldap/bin:/opt/bitnami/openldap/sbin:$PATH"

EXPOSE 1389 1636

USER 1001
ENTRYPOINT [ "/opt/bitnami/scripts/openldap/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/openldap/run.sh" ]