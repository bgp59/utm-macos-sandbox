#! /bin/bash

this_script=${0##*/}

usage="
Usage: $this_script SANDBOX_NAME

Eject \$SANDBOX_ARTIFACTS_ROOT/SANDBOX_NAME, where

    SANDBOX_ARTIFACTS_ROOT defaults to \$HOME/Sandbox/Artifacts
"

case "$1" in
    -h*|--h*|"") echo >&2 "$usage"; exit 1;;
    *) sandbox_name="$1"; shift;;
esac

set -x
hdiutil eject "${SANDBOX_ARTIFACTS_ROOT:-$HOME/Sandbox/Artifacts}/$sandbox_name"
