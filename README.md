# PHAMS — Pateros Hunger Assistance Management System

Full-stack web app for managing household beneficiary registration, priority scoring, nutritional status tracking, and food distribution records across 10 barangays of Pateros.

- **Frontend:** React 19 + Vite + Tailwind CSS 4 → deployed on Vercel
- **Backend:** Express.js + Supabase Postgres → deployed on Vercel
- **Live app:** https://phams.vercel.app *(or your Vercel URL)*

---

## Quick start (local development)

```bash
npm install
npm run dev
```

Opens at **http://localhost:5173**. Mock API is on by default — no database or backend needed.

---

## Test credentials

### Admin
| Email | Password |
|---|---|
| admin@pateros.gov.ph | admin123 |

### Barangay Staff
All staff accounts use password **`Staff1234`**.

| Barangay | Email |
|---|---|
| Aguho | staff-aguho@pateros.gov.ph |
| Magtanggol | staff-magtanggol@pateros.gov.ph |
| Martires del '96 | staff-martires-del-96@pateros.gov.ph |
| Poblacion | staff-poblacion@pateros.gov.ph |
| San Pedro | staff-san-pedro@pateros.gov.ph |
| San Roque | staff-san-roque@pateros.gov.ph |
| Santa Ana | staff-santa-ana@pateros.gov.ph |
| Santo Rosario-Kanluran | staff-santo-rosario-kanluran@pateros.gov.ph |
| Santo Rosario-Silangan | staff-santo-rosario-silangan@pateros.gov.ph |
| Tabacalera | staff-tabacalera@pateros.gov.ph |

> These credentials work in both **mock mode** (localhost default) and against the configured live backend.

---

## Running modes

### Mock mode (default — no backend needed)
No setup required. Just run `npm run dev`. All data is stored in your browser's localStorage and resets on clear.

```env
# .env (optional — mock is already the default in dev)
VITE_USE_MOCK_API=true
```

### Live backend
To test against the shared production database:

1. Create a `.env` file in the project root:
   ```env
   VITE_USE_MOCK_API=false
   VITE_API_URL=
   ```
2. Run `npm run dev` — the app now hits the configured backend instead of mock data.

> **Note:** `.env` is gitignored. Each team member needs their own copy.

---

## What to expect when testing

- **Staff portal** (`/staff/login`) — select "Barangay Staff", enter a staff email + `Staff1234`. You land on the staff dashboard scoped to that barangay only (families, distributions, and NPA individuals are filtered to your barangay).
- **Admin portal** (`/staff/login`) — select "Administrator", enter `admin@pateros.gov.ph` / `admin123`. You land on `/admin/dashboard` with access to all barangays.
- **Wrong password** → shows an error message (does not silently redirect).
- **NPA individuals** (`/staff/individuals/no-address`) — each barangay staff only sees the NPA individuals registered by their own barangay.

---

## Supabase backend setup

> Skip this if you're only working on frontend.

### Prerequisites
- Node.js
- A Supabase project

### Steps

```bash
# 1. Install backend dependencies
cd backend && npm install

# 2. Set up backend environment
cp backend/.env.example backend/.env
# Set SUPABASE_DB_URL in backend/.env

# 3. Run backend/schema.supabase.sql in the Supabase SQL Editor
# 4. Run backend/seed.supabase.sql in the Supabase SQL Editor for 100+ sample dashboard records

# 5. Start the backend
cd backend && npm start    # runs on http://localhost:8080

# 6. Start the frontend (in a separate terminal, project root)
# Create .env in project root:
# VITE_USE_MOCK_API=false
# VITE_API_URL=http://localhost:8080
npm run dev
```

### Docker (legacy MySQL setup)
```bash
cd backend && docker compose up -d
```
This legacy setup is retained for local reference. Supabase deployments should use `schema.supabase.sql`.

---

## Deployment

| Service | Platform | Notes |
|---|---|---|
| Frontend | Vercel | Auto-deploys from `main`. Only `VITE_API_URL` is needed in Vercel environment variables. |
| Backend + DB | Vercel + Supabase | Express API on Vercel and Postgres on Supabase. |

### Vercel env vars
```
VITE_API_URL=
```

### Vercel backend env vars
```
SUPABASE_DB_URL=postgresql://...
```

---

## Project structure

```
src/
  admin/pages/        # Admin dashboard, families, barangays, accounts
  pages/staff/        # Staff login, dashboard, NPA individuals
  pages/              # Public pages (Home, About, Donation, etc.)
  components/auth/    # AdminProtectedRoute, StaffProtectedRoute
  context/            # AdminAuthContext, StaffAuthContext
  api/                # apiFetch() wrapper, mockApi.js (in-browser DB)
backend/
  server.js           # Express API
  schema.supabase.sql # Supabase Postgres schema
  seed.sql            # Sample data
  tools/seed_staff.js # Seeds staff accounts to the configured backend
```

---

## Design notes

### Household ID (e.g., AGU-2026-0001)
Structured ID following DSWD Listahanan convention: `[BARANGAY_CODE]-[YEAR]-[SEQUENCE]`. Prevents ambiguity when multiple families share a surname in the same barangay.

### Priority Score (0–100)
Computed from five weighted factors: monthly income vs NCR poverty line (35%), malnourished members (30%), vulnerable individuals — children under 5, seniors, PWDs (20%), per-capita dependency burden (10%), days since last distribution (5%). Higher = more urgent.

### BMI-Based Nutritional Status
Computed automatically from height + weight using age-appropriate Philippine DOH/NNC classifications (pediatric, adolescent, and adult bands with Asian BMI cutoffs). Staff can override if measurements are unavailable.

### Multi-Program Enrollment
Families can be enrolled in multiple programs simultaneously (4Ps, Solo Parent, PWD, Senior Citizen, Pregnant/Lactating). Stored as a text field, displayed as checkboxes.

### Soft Delete
Records use `is_active = 0` rather than hard delete to preserve distribution history and audit logs.

---

## Known limitations

- Pediatric nutritional classification uses simplified thresholds, not full WHO Anthro z-score tables.
- Dashboard statistics loaded fresh on each visit; no real-time push updates.
- Food assistance program enrollment history is not tracked — only current enrollment.
