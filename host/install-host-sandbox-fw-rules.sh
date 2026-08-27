#! /bin/bash

# Install UTM sandbox isolation firewall rules on host

# Infer location from invocation:
this_dir=$(dirname "$(realpath $0)")

set -ex
cd $this_dir

sudo cp com.utm.sandbox /etc/pf.anchors
if ! grep 'com.utm' /etc/pf.conf; then
    sudo bash -c 'cat pf.conf-fragment >> /etc/pf.conf'
fi
sudo cp com.apple.pfctlenable.plist /Library/LaunchDaemons
sudo chmod 644 /Library/LaunchDaemons/com.apple.pfctlenable.plist

sudo pfctl -a com.utm.sandbox -F all
sudo pfctl -a com.utm.sandbox -f /etc/pf.anchors/com.utm.sandbox

sudo launchctl unload /Library/LaunchDaemons/com.apple.pfctlenable.plist
sudo launchctl load /Library/LaunchDaemons/com.apple.pfctlenable.plist

