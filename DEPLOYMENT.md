# HRMS Lite - Deployment Guide

Deploy the **backend** to Railway and the **frontend** to Vercel, then connect them.

**Deploy order:** Backend first (Railway) → then Frontend (Vercel) so you have the API URL for the frontend env var.

---

## Step 1: Deploy Backend to Railway

### 1.1 Push your code to GitHub

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main
```

### 1.2 Create Railway project

1. Go to [railway.app](https://railway.app) and sign in (GitHub recommended).
2. Click **New Project** → **Deploy from GitHub repo**.
3. Select your repository.
4. **Root Directory:** Set to `backend` (important).
5. Railway will auto-detect Python and deploy.

### 1.3 Configure Railway environment variables

In your Railway project → **Variables** tab, add:

| Variable | Value |
|----------|-------|
| `USE_SQLITE` | `true` |
| `DATABASE_URL` | *(optional)* Your MySQL URL if using external DB |

- **SQLite:** Set `USE_SQLITE=true` for a simple demo (data resets on redeploy).
- **MySQL:** Set `DATABASE_URL=mysql+pymysql://user:pass@host:port/db` and `USE_SQLITE=0` for persistent data.

### 1.4 Generate public URL

1. Go to **Settings** → **Networking**.
2. Click **Generate Domain**.
3. Copy the URL (e.g. `https://hrms-lite-backend.up.railway.app`).

---

## Step 2: Deploy Frontend to Vercel

### 2.1 Create Vercel project

1. Go to [vercel.com](https://vercel.com) and sign in (GitHub recommended).
2. Click **Add New** → **Project**.
3. Import your GitHub repository.
4. **Root Directory:** Set to `frontend`.
5. **Framework Preset:** Create React App (auto-detected).

### 2.2 Set environment variable

Before deploying, add:

| Name | Value |
|------|-------|
| `REACT_APP_API_BASE_URL` | `https://YOUR-RAILWAY-URL.up.railway.app` |

Replace with your actual Railway backend URL (no trailing slash).

### 2.3 Deploy

Click **Deploy**. Vercel will build and deploy your frontend.

---

## Step 3: Connect Frontend to Backend

The frontend uses `REACT_APP_API_BASE_URL` for all API calls. After setting it in Vercel, the app will talk to your Railway backend.

**CORS:** The backend allows all origins (`allow_origins=["*"]`), so your Vercel domain can call the API.

---

## Quick Reference

| Platform | URL | Config |
|----------|-----|--------|
| **Backend (Railway)** | `https://xxx.up.railway.app` | Root: `backend` |
| **Frontend (Vercel)** | `https://xxx.vercel.app` | Root: `frontend`, Env: `REACT_APP_API_BASE_URL` |

---

## Troubleshooting

- **CORS errors:** Ensure backend CORS allows your Vercel domain (current config allows all).
- **404 on refresh:** Vercel rewrites are configured for client-side routing.
- **Backend not responding:** Check Railway logs; ensure `PORT` is used (Railway sets it automatically).
