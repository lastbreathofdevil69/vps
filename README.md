# Ubuntu 24.04 LTS Desktop with Web Browser on Render (noVNC + XFCE)

Run a clean, browser-accessible **Ubuntu 24.04 LTS Desktop GUI** on [Render](https://render.com) with the **Falkon Web Browser** pre-installed.

---

## 🖥️ System & Account Details

- **OS:** **Ubuntu 24.04 LTS (Noble Numbat)**
- **Desktop Environment:** XFCE4 (Compositing disabled for maximum performance on 0.1 CPU)
- **Web Browser:** **Falkon** (Lightweight Chromium/QtWebEngine browser, runs smoothly within 512 MB RAM)
- **Logged-in User:** `viru` (with full `sudo` privileges)
- **User Password:** `viru`
- **VNC Password:** `4215` (or whatever you set via the `VNC_PASSWORD` environment variable)
- **Color Depth:** 16-bit Fast Mode (drastically reduces bandwidth and lag)

---

## 🚀 How to Deploy on Render

### Step 1: Push Changes to GitHub
```bash
git push origin main
```

---

### Step 2: Access Your Desktop

1. Once deployment shows **Live**, open your Render URL:
   👉 `https://vps-lza0.onrender.com`
2. Enter your password: **`4215`**.
3. You will see your fresh **Ubuntu 24.04 Desktop**:
   - Double-click the **Falkon Browser** icon on the desktop to browse the web!
   - Double-click the **Terminal** icon on the desktop to run shell commands as user `viru`.

---

## 🖱️ Browser Lag Tip: Turn ON "Local Cursor"

To make your mouse pointer completely lag-free (0ms):
1. In the browser, click the small tab arrow (**`>`**) on the far-left edge of the screen.
2. Click the **Gear icon (Settings)**.
3. Turn **Local Cursor** to **ON**.
