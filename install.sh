#!/usr/bin/env bash
# Installs interject and the interject manpage
set -Eeuo pipefail

install -g 0 -o 0 -m 0755 interject /usr/local/sbin/interject
install -g 0 -o 0 -m 0644 interject.roff /usr/local/man/man1/interject.1
gzip /usr/local/man/man1/interject.1
