#!/bin/bash -i

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo "Usage ./bin/setup.sh [OPTIONS]"
	echo ""
	echo "Options:"
	echo ""
	echo "  -t [tags] - a comma separated list that is going to be used to filter what to install"
	exit
fi

ansible-pull -U git@github.com:elpic/ansible-core-servicing.git "$@"
