# StatThat

**NFL schedules, standings, and stats** — mobile-first web app powered by [sofascore_scraper](https://github.com/tunjayoff/sofascore_scraper).

Live demo (static + demo data): **https://tuldom84.github.io/StatThat/**

## Features

- **Schedule** — recent results and upcoming games
- **Standings** — AFC / NFC tables
- **Stats** — league leaders snapshot
- **Settings** — point the app at your own `sofascore_scraper` API for live data

Design: charcoal / chalk / steel editorial palette, mobile-first, safe-area aware.

## Quick start (demo)

Open `index.html` or the GitHub Pages site. Demo data loads immediately.

## Live data (self-hosted)

1. Install and run the scraper (see upstream README):

```bash
git clone https://github.com/tunjayoff/sofascore_scraper.git
cd sofascore_scraper
docker compose up -d
# or: pip install + ssc serve  → http://127.0.0.1:8000
```

2. Follow NFL (unique tournament id **9464**):

```bash
ssc follows add tournament 9464 --name NFL --sport american-football --seasons last:1
ssc sync
```

Enable standings / player stats in the follow or defaults if you need them.

3. In StatThat → **Settings**, set API base to `http://127.0.0.1:8000` (or your server) and save.

API used:

- `GET /api/v1/events?tournament=9464&limit=30` — schedule
- Season standings: `GET /api/v1/seasons/{season_id}/standings` (requires a season id from the tournament)

OpenAPI: https://github.com/tunjayoff/sofascore_scraper/blob/main/docs/api/openapi-v1.json

## GitHub Pages

This repo is configured for GitHub Pages from the `main` branch root (`index.html`).

## License

App code: MIT.  
Data source is the unofficial sofascore_scraper project (PolyForm Noncommercial) — respect SofaScore terms and rate limits.
