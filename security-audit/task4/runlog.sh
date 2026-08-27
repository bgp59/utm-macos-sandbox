#!/bin/bash
LOG="$HOME/security-audit/task4/sandbox-test.log"
ts() { date "+%Y-%m-%d %H:%M:%S"; }
logrun() {
  local attempt="$1"; local cmd="$2"; local verdict="${3:-INCONCLUSIVE}"
  { echo "[$(ts)] ATTEMPT: $attempt"
    echo "[$(ts)] COMMAND: $cmd"
    local out; out="$(eval "$cmd" 2>&1)"
    echo "[$(ts)] RESULT:"
    echo "$out" | head -25
    echo "[$(ts)] VERDICT: $verdict"
    echo
  } | tee -a "$LOG"
}
