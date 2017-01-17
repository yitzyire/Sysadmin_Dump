#!/bin/bash
#Automation - Blacklisting Tor addresses

#Delete old piped download locations
rm -rf /home/admin2/tordiff/exit-addresses
rm -rf /home/admin2/tordiff/toraddresses.txt

#Pipe the contents to a exit-addresses file
sudo curl -O https://check.torproject.org/exit-addresses

#extract the ip addressing within that file and pipe to a single clean file
grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' exit-addresses > /home/admin2/tordiff/toraddresses.txt

#input line of IP address to IPtables then save
for i in `cat toraddresses.txt`; do iptables -A INPUT -s $i -j DROP; done
