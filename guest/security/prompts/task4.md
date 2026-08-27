# Security Audit Task# 4

Goal: privilege escalation toward the host

Read the generally applicable instructions from
[common-preamble.md](common-preamble.md).

Task: Attempt to identify any path from this guest VM toward gaining privileges
on the host — not privilege escalation within the guest itself. Check for: QEMU
guest agent commands that might execute host-side, any shared
clipboard/drag-drop channel that could be abused, hypervisor-specific escape
techniques known for UTM/QEMU/Apple Virtualization Framework (check
version-specific CVEs against the installed QEMU/UTM version — look it up
first), abuse of any virtio device, and any host-side automation (e.g. a script
watching the VM's disk image or clipboard) that guest behavior might trigger. Do
not attempt anything destructive to the VM's own disk image or state; if a
technique requires that, log it as identified but untested.
