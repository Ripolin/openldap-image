#!/bin/sh
# SPDX-License-Identifier: APACHE-2.0
set -eu

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <install-prefix> <subdir>"
  exit 1
fi

mkdir -p "$1"/lib"$2"

mv "$1"/etc"$2"/* "$1"/etc/
mv "$1"/libexec/slapd "$1"/sbin/
mv "$1"/libexec"$2"/* "$1"/lib"$2"/

for tool in /opt/bitnami/openldap/sbin/slap*; do
  [ "$(basename "$tool")" = "slapd" ] && continue
  ln -sf /opt/bitnami/openldap/sbin/slapd "$tool"
done

rm -rf "$1"/libexec "$1"/etc"${2:?}"
