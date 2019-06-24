#!/usr/bin/env bash
# Installs interject and the interject manpage
# Supports Linux, macOS, and BSD systems

set -Eeuo pipefail

if [[ "$OSTYPE" == "linux-gnu" ]] ; then
    MAN_PATH=/usr/local/man/man1
    BIN_PATH=/usr/local/sbin
elif [[ "$OSTYPE" == "darwin"* ]] ; then
    MAN_PATH=/usr/local/share/man/man1
    BIN_PATH=/usr/local/sbin
elif [[ "$OSTYPE" == *"bsd" ]] ; then
    MAN_PATH="${MANPREFIX}"/man
    BIN_PATH=/usr/local/sbin
else
    # This might not be a BSD, Linux, or macOS system
    printf "OS is not recognized as a *nix system\n"
    printf "Unable to determine locations to install binaries and manpage\n"
    printf "Try setting system-specific values for MAN_PATH and BIN_PATH;\n"
    printf "Then proceed with the install using these commands:\n\n"
    printf "install -g 0 -o 0 -m 0755 interject \$BIN_PATH/interject\n"
    printf "install -g 0 -o 0 -m 0644 interject.roff \$MAN_PATH/interject.1\n"
    printf "gzip \$MAN_PATH/interject.1\n\n"
    printf "Exiting the installation process...\n"
    exit 1
fi

install -g 0 -o 0 -m 0755 interject "${BIN_PATH}"/interject
install -g 0 -o 0 -m 0644 interject.roff "${MAN_PATH}"/interject.1
gzip "${MAN_PATH}"/interject.1
