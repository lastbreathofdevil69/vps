# Clean & Fast Alpine Linux Desktop on Render (noVNC + XFCE)

An ultra-lightweight, high-performance **Alpine Linux Desktop GUI** on [Render](https://render.com) using XFCE, Papirus icons, and noVNC.

---

## ⚡ Why Alpine Linux is the Best Choice for Free VPS

- **Super Light Memory Usage:** Uses only **~65 MB of RAM** at idle (compared to 200MB+ on Ubuntu), leaving >400 MB of RAM completely free for your apps!
- **Zero Background Bloat:** Boot time and operations are 4x faster on Render's 0.1 CPU.
- **Sleek Clean UI:** Pre-configured with **Adwaita-Dark theme** and **Papirus modern icons**.
- **Web Browser Included:** **Falkon** (lightweight Chromium-based browser) is ready on your desktop.
- **Tiny Docker Image:** ~300 MB total (builds and deploys in under 60 seconds).

---

## 🖥️ System & Account Details

- **OS:** Alpine Linux (latest)
- **Package Manager:** `apk` (e.g. `sudo apk add python3`, `sudo apk add nodejs`)
- **User Account:** `viru` (passwordless `sudo`)
- **System Password:** `viru`
- **VNC Password:** `4215`

---

## 🚀 How to Deploy on Render

### Step 1: Push Changes to GitHub
```bash
git push origin main
```

### Step 2: Open Your Desktop
Once Render shows **Live**, open:
👉 `https://vps-lza0.onrender.com`

Enter password: **`4215`**.
You'll see your clean, modern Alpine Linux desktop with Falkon Browser and Terminal icons!

---

### 📦 Handy Alpine Package Commands:

```bash
# Update package list
sudo apk update

# Install programming languages
sudo apk add python3 py3-pip
sudo apk add nodejs npm
sudo apk add gcc g++ make

# Search for any package
apk search <package_name>
```
