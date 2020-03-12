#!/bin/bash
#
# Script that replaces the default hostname in files with the environments
# ${HOSTNAME} variable.
#
# This script is intended to be run before starting hbase-server to ensure
# that the hostname matches the configured environment variable. i.e.
# the -h --hostname flag.
#
HOSTNAME=`cat /etc/hostname`

declare -a files=(
	'/root/hbase-1.4.13/conf/hbase-site.xml'
    `/root/apache-phoenix-4.14.3-HBase-1.4-bin/bin/hbase-site.xml`
)

for file in "${files[@]}"; do
	if [ -f "${file}.bak" ]; then
		cp "${file}.bak" "${file}"
	else
		cp "${file}" "${file}.bak"
	fi

	sed -i "s/hbase-docker/${HOSTNAME}/g" "${file}"
done