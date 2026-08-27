#! /bin/bash

# Sandbox setup, installed to be invoked at boot time:

this_dir=$(dirname "$(realpath $0)")

# Network setup:
skip=1 # to skip the 1st line
networksetup -listallnetworkservices | while read network_service; do
    if [[ "$skip" = 1 ]]; then
        skip=
    else
        # Disable IPv6:
        networksetup -setv6off "$network_service"
        # Use external DNS servers:
        networksetup -setdnsservers "$network_service" 8.8.8.8 1.1.1.1
    fi
done

sandbox_name=$(cat "$this_dir/sandbox-name")

if [[ -n "$sandbox_name" ]]; then
    scutil --set ComputerName "$sandbox_name"
    scutil --set LocalHostName "$sandbox_name.local"
    scutil --set HostName "$sandbox_name"
    dscacheutil -flushcache
    
    # Keep the artifacts volume busy to prevent accidental ejection:
    artifacts_volume="/Volumes/$sandbox_name"
    while [[ ! -d "$artifacts_volume" ]]; do sleep 1; done
    cd "$artifacts_volume" && while [[ 1 ]]; do sleep 3600; done
fi
