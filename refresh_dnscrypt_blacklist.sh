#!/usr/bin/env bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
blacklist_file="/etc/dnscrypt-proxy/blacklist.txt"
blacklist_generated="${dir}/_domains_blacklist_generated.txt"

# Generate the blacklist
./generate-domains-blocklist.py -o $blacklist_generated

# Copy the blacklist
sudo cat $blacklist_file $blacklist_generated \
	| sort \
	| uniq -u \
	| sudo tee $blacklist_file

# Refresh the service
sudo systemctl restart dnscrypt-proxy.service

exit 0
