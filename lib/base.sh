#!/usr/bin/env bash
BASEDIR=$(readlink -f "${BASH_SOURCE%/*}")

set -e

source "${BASEDIR}/config.sh"
source "${BASEDIR}/output.sh"
source "${BASEDIR}/git.sh"
source "${BASEDIR}/version.sh"
source "${BASEDIR}/conventional.sh"
