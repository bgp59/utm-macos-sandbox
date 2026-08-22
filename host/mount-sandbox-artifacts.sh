#! /bin/bash

# Mount VM artifacts `.dmg` on host if not in use by VM. The mount will disable
# finder actions to prevent attacks via malicious metadata.

this_script=${0##*/}

usage="
Usage: $this_script PATH_TO_DMG [ro]

Mount PATH_TO_DMG to \$SANDBOX_ARTIFACTS_ROOT/BASENAME, where:

    SANDBOX_ARTIFACTS_ROOT defaults to \$HOME/Sandbox/Artifacts
    BASENAME is basename of PATH_TO_DMG
"

case "$1" in
    -h*|--h*|"") echo >&2 "$usage"; exit 1;;
    *) dmg=$(realpath "$1"); shift;;
esac

if [[ "$1" = "ro" ]]; then
    ro="-ro"
else
    ro=
fi

if lsof "$dmg"; then
    echo >&2 "$this_script: '$dmg' in use"
else
    set -e
    mountpoint="${SANDBOX_ARTIFACTS_ROOT:-$HOME/Sandbox/Artifacts}/"$(basename "$dmg" .dmg)
    mkdir -p "$mountpoint"
    hdiutil attach -nobrowse -mountpoint "$mountpoint" "$dmg" | grep "$mountpoint"
    mdutil -i off "$mountpoint"
    touch "$mountpoint/.metadata_never_index"
fi

