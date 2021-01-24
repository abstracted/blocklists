#!/usr/bin/env bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
blacklist_file="/etc/dnscrypt-proxy/blacklist.txt"
whitelist_file="/etc/dnscrypt-proxy/whitelist.txt"

blacklist="${dir}/domains-blacklist.txt"
whitelist="${dir}/domains-allowlist.txt"

# Generate the blacklist
sudo ./generate-domains-blocklist.py -o $blacklist

echo -e "\nCopy the blacklist"
[ $? -eq 0 ] && sudo cat $blacklist | sudo tee $blacklist_file
echo -e "\nCopy the whitelist"
[ $? -eq 0 ] && sudo cat $whitelist | sudo tee $whitelist_file

echo -e "\nRefresh the service"
sudo systemctl restart dnscrypt-proxy.service

exit 0
