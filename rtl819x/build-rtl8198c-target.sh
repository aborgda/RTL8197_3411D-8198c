#!/bin/sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname "$0")" && pwd)
cd "$ROOT"

PROFILE=${1:-}
case "$PROFILE" in
  gn866_ac) CFG=profiles/rtl8198c_gn866_ac.config ;;
  lg7100)   CFG=profiles/rtl8198c_lg7100.config ;;
  sk337)    CFG=profiles/rtl8198c_sk337.config ;;
  *) echo "usage: $0 {gn866_ac|lg7100|sk337}" >&2; exit 2 ;;
esac

rm -f .config .oldconfig
cp "$CFG" .config
./config/setconfig defaults
make -j${JOBS:-2} V=s
