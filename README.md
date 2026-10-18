# Free Ubuntu Desktop on Render (noVNC + XFCE)

Run a free, browser-accessible **Ubuntu 22.04 Desktop GUI** on [Render](https://render.com) using XFCE, Xvfb, and noVNC.

---

## 🖥️ System Details

- **Desktop Environment:** XFCE4 (Lightweight, fits within Render's 512 MB RAM limit)
- **Default User:** `viru` (with full `sudo` privileges)
- **User Password:** `viru`
- **VNC Desktop Password:** `viru123` (changeable via the `VNC_PASSWORD` environment variable)
- **Resolution:** `1280x720` (720p HD, auto-scaling)

---

## 🚀 How to Deploy on Render

### Step 1: Push Changes to GitHub
```bash
git add .
git commit -m "Convert to Ubuntu Desktop GUI with user viru"
git push origin main
```

---

### Step 2: Deploy on Render

1. Open your **[Render Dashboard](https://dashboard.render.com/)**.
2. Click **New +** > **Web Service**.
3. Connect your GitHub repository (`vps`).
4. Select the settings:
   - **Runtime:** `Docker`
   - **Instance Type:** `Free`
5. *(Optional)* Under **Environment Variables**, you can set:
   - `VNC_PASSWORD`: Your custom desktop password (default: `viru123`)
   - `RESOLUTION`: e.g. `1280x720` or `1024x768`
6. Click **Create Web Service**.

---

### Step 3: Access Your Desktop

1. Once deployment shows **Live**, click your Render URL (e.g. `https://ubuntu-desktop-xxxx.onrender.com`).
2. When prompted, enter your password: **`viru123`**.
3. The full Ubuntu XFCE Desktop will stream directly inside your web browser!

---

## 📋 Copy & Paste in noVNC

- Click the small chevron arrow tab (`>`) on the far-left edge of your browser screen.
- Open the **Clipboard** tool:
  - Paste any text from your Windows PC into this box, and it immediately becomes available inside the Ubuntu Desktop to paste with `Ctrl+V` or Right-Click!
  - Text copied from inside the desktop will also appear in this box to copy back to your Windows PC.

---

## ⚠️ Important Free Tier Notes

1. **512 MB RAM Limit:** XFCE, noVNC, and system tools run at ~160 MB RAM. Avoid opening full web browsers (like Google Chrome or Firefox) inside this container, as they will exceed the 512 MB RAM limit and crash. Use lightweight tools, terminal, python, text editors, etc.
2. **Inactivity Sleep:** Render free tier services go to sleep after 15 minutes of inactivity. When you visit the link again, it takes ~30–50 seconds to wake up.
