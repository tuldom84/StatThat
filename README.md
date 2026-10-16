# StatThat

**NFL schedules, standings, and stats** — mobile-first web app powered by [sofascore_scraper](https://github.com/tunjayoff/sofascore_scraper).

Live demo (static + demo data): **https://tuldom84.github.io/StatThat/**

## Features

- **Schedule** — recent results and upcoming games  
- **Standings** — AFC / NFC tables  
- **Stats** — league leaders snapshot  
- **Settings** — point the app at your own `sofascore_scraper` API for live data  

Design: charcoal / chalk / steel editorial palette, mobile-first, safe-area aware.

---

## Quick start (demo only)

Open the [GitHub Pages site](https://tuldom84.github.io/StatThat/) or open `index.html` locally. Demo data loads immediately — no server required.

---

## Full stack: Codespaces (recommended)

The repo includes a **Codespaces-ready** layout that runs the official `sofascore_scraper` Docker image as the statistics server.

### 1. Create the Codespace

1. Open https://github.com/tuldom84/StatThat  
2. Click **Code** → **Codespaces** → **Create codespace on main**  
3. Wait for the container to finish starting (Docker-in-Docker is installed automatically)

### 2. Start the statistics server

In the Codespace terminal:

```bash
docker compose up -d
```

The scraper API (and its own web UI) is available on port **8000**.  
Codespaces will offer to open the forwarded port — use that URL, or `http://127.0.0.1:8000` inside the Codespace.

### 3. Follow NFL and download data

```bash
# One-shot helper (adds follow + initial sync)
bash scripts/setup-nfl.sh

# Or step by step:
docker compose run --rm --no-deps sofascore-scraper \
  follows add tournament 9464 \
  --name "NFL" \
  --sport american-football \
  --seasons last:1

docker compose run --rm --no-deps sofascore-scraper sync
docker compose run --rm --no-deps sofascore-scraper status
```

NFL unique tournament id on SofaScore is **9464**.

> First sync can take several minutes depending on how much history is requested and the request budget.

### 4. Point StatThat at the API

1. Open the static UI:
   - GitHub Pages demo, **or**
   - Serve locally inside the Codespace: `npx --yes serve -l 5500 .` then open the forwarded port 5500  
2. Go to **Settings**  
3. Set **API base URL** to the scraper address:
   - Inside Codespace: `http://127.0.0.1:8000`  
   - From your browser via Codespaces port forward: use the `*.app.github.dev` URL Codespaces shows for port 8000  
4. Save → reload **Schedule**

You should now see real events from the scraper instead of demo data.

### Useful commands

```bash
docker compose logs -f sofascore-scraper   # follow logs
docker compose run --rm --no-deps sofascore-scraper status
docker compose run --rm --no-deps sofascore-scraper sync
docker compose down                        # stop
```

---

## Local Docker (without Codespaces)

```bash
git clone https://github.com/tuldom84/StatThat.git
cd StatThat
docker compose up -d
bash scripts/setup-nfl.sh
```

Then open `index.html` (or any static server) and set API base to `http://127.0.0.1:8000`.

---

## API surface used by StatThat

| Purpose        | Endpoint                                      |
|----------------|-----------------------------------------------|
| Schedule       | `GET /api/v1/events?tournament=9464&limit=30` |
| Season list    | `GET /api/v1/tournaments/9464/seasons`        |
| Standings      | `GET /api/v1/seasons/{season_id}/standings`   |

Full contract: [sofascore_scraper OpenAPI](https://github.com/tunjayoff/sofascore_scraper/blob/main/docs/api/openapi-v1.json)

---

## Project layout

```
StatThat/
├── index.html                 # mobile-first StatThat UI (also GitHub Pages entry)
├── docker-compose.yml         # sofascore_scraper statistics server
├── .devcontainer/
│   └── devcontainer.json      # Codespaces / VS Code Dev Container
├── scripts/
│   └── setup-nfl.sh           # follow NFL + initial sync
└── README.md
```

---

## GitHub Pages

Static demo is served from the `main` branch root (`index.html`).  
Enable under **Settings → Pages → Deploy from a branch → main / root** if the site still 404s.

---

## License & attribution

- StatThat UI: MIT  
- Data platform: [sofascore_scraper](https://github.com/tunjayoff/sofascore_scraper) (PolyForm Noncommercial 1.0.0)  
- Unofficial; not affiliated with SofaScore. Respect their terms and the scraper’s request budget.
