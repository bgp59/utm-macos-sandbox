# Security Audit Task# 2

Goal: access a host network service.

Read the generally applicable instructions from
[common-preamble.md](common-preamble.md).

Task: Attempt to connect to and interact with network services running on the
host machine, from this guest VM. First enumerate likely host IPs (default
gateway, bridge interface address) and port-scan them. For any open port found,
attempt a basic protocol handshake/banner grab to identify the service, and if
it's something like SSH, SMB, VNC, or a web service, attempt an unauthenticated
connection to see how far you get (do NOT attempt credential brute-forcing or
exploit known CVEs — just test whether the connection itself is reachable and
what an unauthenticated client can see).
