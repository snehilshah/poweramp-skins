#!/usr/bin/env bash
# Downloads the Poweramp resources skins link against, from the official
# powerampapi repo at a pinned commit, and checks its checksum.
# To move to a newer Poweramp build, change the three values below.
set -euo pipefail

COMMIT=a5ea07c23ddd1a48ef8d770eca999565ee695ba9
FILE=Poweramp-build-1026-resources.zip
SHA256=ad05191575b20f7ca3182d27dd783a48bb22548d4c46f95342a288468e727e82

OUT="$(dirname "$0")/../poweramp-resources.zip"

if [ -f "$OUT" ] && echo "$SHA256  $OUT" | sha256sum --check --status; then
  echo "poweramp-resources.zip is up to date"
  exit 0
fi

curl -fsSL -o "$OUT.tmp" "https://raw.githubusercontent.com/maxmpz/powerampapi/$COMMIT/$FILE"
echo "$SHA256  $OUT.tmp" | sha256sum --check --status || {
  rm -f "$OUT.tmp"
  echo "Checksum mismatch for $FILE" >&2
  exit 1
}
mv "$OUT.tmp" "$OUT"
echo "Downloaded $FILE to poweramp-resources.zip"
