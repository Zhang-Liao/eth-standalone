#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
export LEAN_NUM_THREADS=1
exec nice -n 19 lake build "$@"
