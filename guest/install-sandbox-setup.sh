#! /bin/bash

# Infer location from invocation:
this_dir=$(dirname "$(realpath $0)")
sandbox_name="$1"

set -ex
cd "$this_dir"
sudo mkdir -p /Library/Scripts/SandboxSetup
sudo cp sandbox-setup.sh set-sandbox-name.sh /Library/Scripts/SandboxSetup
sudo chmod +x /Library/Scripts/SandboxSetup/sandbox-setup.sh /Library/Scripts/SandboxSetup/set-sandbox-name.sh
sudo cp com.utm.SandboxSetup.plist /Library/LaunchDaemons

if [[ -n "$sandbox_name" ]]; then
    sudo bash -c "echo '$sandbox_name' > /Library/Scripts/SandboxSetup/sandbox-name"
fi

sudo launchctl load -w /Library/LaunchDaemons/com.utm.SandboxSetup.plist
