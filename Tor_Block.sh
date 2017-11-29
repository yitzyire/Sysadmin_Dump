#!/bin/bash
#Automation - Blacklisting Tor addresses

#Delete old piped download locations
rm -rf /scripts/tor/addresses/exit-addresses
rm -rf /scripts/tor/addresses/toraddresses

#Pipe the contents to a exit-addresses file
sudo curl -O https://check.torproject.org/exit-addresses
mv /scripts/tor/exit-addresses /scripts/tor/addresses/exit-addresses

#extract the ip addressing within that file and pipe to a single clean file
grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' /scripts/tor/addresses/exit-addresses > /scripts/tor/addresses/toraddresses

#flush the iptables (old entries)
iptables -F

#input line of IP address to IPtables then save
for i in `cat /scripts/tor/addresses/toraddresses`; do iptables -A INPUT -s $i -j DROP; done
