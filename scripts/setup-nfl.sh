#!/usr/bin/env bash
# Follow NFL (tournament 9464) and run an initial sync.
# Usage: ./scripts/setup-nfl.sh
# Requires: docker compose service sofascore-scraper already up (docker compose up -d)

set -euo pipefail

echo "→ Adding NFL follow (tournament 9464)..."
docker compose run --rm --no-deps sofascore-scraper \
  follows add tournament 9464 \
  --name "NFL" \
  --sport american-football \
  --seasons last:1

echo "→ Starting sync (this may take a while on first run)..."
docker compose run --rm --no-deps sofascore-scraper sync

echo "→ Status:"
docker compose run --rm --no-deps sofascore-scraper status

echo ""
echo "Done. Open StatThat → Settings and set API base to:"
echo "  http://127.0.0.1:8000   (local / Codespace port forward)"
echo "Then reload the Schedule tab."
