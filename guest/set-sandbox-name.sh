#! /bin/bash

this_dir=$(dirname "$(realpath $0)")

case "$1" in
    -h*|--h*|"") echo >&2 "Usage: ${0##*/} SANDBOX_NAME";;
    *) sandbox_name=$1; shift;;
    
esac

sudo bash -c "echo '$sandbox_name' > $this_dir/sandbox-name"
sudo launchctl unload -w /Library/LaunchDaemons/com.utm.SandboxSetup.plist
sudo launchctl load -w /Library/LaunchDaemons/com.utm.SandboxSetup.plist
