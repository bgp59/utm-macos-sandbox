#! /bin/bash

# Mount VM artifacts `.dmg` on host if not in use by VM. The mount will disable
# finder actions to prevent attacks via malicious metadata.

this_script=${0##*/}

usage="
Usage: $this_script [-w] [-x] PATH_TO_DMG

Mount PATH_TO_DMG to \$SANDBOX_ARTIFACTS_ROOT/BASENAME, where:

    SANDBOX_ARTIFACTS_ROOT defaults to \$HOME/Sandbox/Artifacts
    BASENAME is basename of PATH_TO_DMG

Flags:
    -w mount writeable, default R/O
    -x mount permitting execution, default noexec
"

dmg=
ro=ro
noexec=noexec
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h*|--h*|"") echo >&2 "$usage"; exit 1;;
        -w*) ro=;;
        -x*) noexec=;;
        -*) : ;;
        *) dmg=$(realpath "$1");;
    esac
    shift
done

if [[ -z "$dmg" ]]; then
    echo >&2 "$usage"; exit 1
fi

if lsof "$dmg"; then
    echo >&2 "$this_script: '$dmg' in use"
else
    set -e
    mountpoint="${SANDBOX_ARTIFACTS_ROOT:-$HOME/Sandbox/Artifacts}/"$(basename "$dmg" .dmg)
    mkdir -p "$mountpoint"
    hdiutil_out=$(hdiutil attach -nomount "$dmg")
    dev_disk=
    for d in $hdiutil_out; do
        if [[ "$d" = "/dev/disk"* ]]; then
            dev_disk="$d"
        fi
    done
    mount_apfs -o nobrowse${ro+,}$ro${noexec+,}${noexec} "$dev_disk" "$mountpoint"
    sudo mdutil -i off "$mountpoint"
    if [[ -z "$ro" && ! -d "$mountpoint/.metadata_never_index" ]]; then
        touch "$mountpoint/.metadata_never_index"
    fi
fi

