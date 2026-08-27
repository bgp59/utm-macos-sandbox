# Security Audit Task# 1

Goal: host information discovery.

Read the generally applicable instructions from
[common-preamble.md](common-preamble.md).

Task: Attempt to discover information about the host machine from inside this
guest VM. This includes: host hostname, host IP/network config, running services
on the host visible from here, host OS fingerprint, ARP table entries for the
host, mDNS/Bonjour advertised services, DHCP lease info that might reveal host
details, NTP/other protocol banners, and any timing or TTL-based host
fingerprinting. Use standard tools (ip, arp, nmap, dig, avahi-browse/dns-sd,
curl against the gateway, etc.) — install lightweight ones if missing and
network allows. Do not attempt exploitation, only reconnaissance.
