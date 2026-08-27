# Security Audit Task# 3

Goal: read a host file

Read the generally applicable instructions from
[common-preamble.md](common-preamble.md).

Task: Attempt to read the following host file, read-only, from inside this guest
VM: `/Users/Shared/security-audit-test.txt`. Try all plausible vectors: any
mounted shared folder or virtfs/9p mount, any SMB/NFS share the host might be
exposing, SPICE/QEMU guest agent file-transfer channels if present,
clipboard-based exfil if clipboard sharing is somehow enabled, USB mass storage
if passthrough is active, and network-based access if the host is serving files
over HTTP/FTP/etc. Report clearly whether each vector exists at all before
trying to use it — "vector not present" is a valid and useful VERDICT. By way of
verification report the content of the file if successful, the content itself is
a harmless silly phrase, a-la `The quick brown fox jumps over the lazy dog`.
