# Security Audit Task# 5

Goal: attempt to access devices on the host network

Read the generally applicable instructions from
[common-preamble.md](common-preamble.md).

Attempt to probe access to devices on the VM host network; that network is
**different** than the one exposed to the guest via a bridge device. If you
cannot discover IP addresses on the former, prompt the user for the following
information: host IP, gateway IP and network range. Assume that the gateway is
an ISP router listening to ssh/http/https/smb ports, probe that they cannot be
accessed. The user may provide a path to a file with the following info:

```text
HOST=a.b.c.d
GW=a.b.c.1
NETWORK=a.b.c.0/24
```
