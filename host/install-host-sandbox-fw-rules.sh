#! /bin/bash

# Install UTM sandbox isolation firewall rules on host

# Infer location from invocation:
this_dir=$(dirname "$(realpath $0)")

set -ex
cd $this_dir

sudo cp com.utm.sandbox /etc/pf.anchors
if ! grep 'com.utm' /etc/pf.conf; then
    sudo bash -c 'cat host/pf.conf-fragment >> /etc/pf.conf'
fi
sudo cp com.apple.pfctlenable.plist /Library/LaunchDaemons
sudo chmod 644 /Library/LaunchDaemons/com.apple.pfctlenable.plist
sudo launchctl load /Library/LaunchDaemons/com.apple.pfctlenable.plist
