# Free Ubuntu VPS on Render (GoTTY)

Run a free, browser-accessible Ubuntu 22.04 terminal environment on [Render](https://render.com) using GoTTY.

---

## 🚀 How to Deploy on Render (Step-by-Step)

### Step 1: Push Changes to GitHub
Make sure your changes in this repository are pushed to your GitHub account:
```bash
git add .
git commit -m "Fix Render deployment and port binding"
git push origin main
```

---

### Step 2: Create a Web Service on Render

1. Log in to your [Render Dashboard](https://dashboard.render.com/).
2. Click **New +** in the top right and select **Web Service**.
3. Connect your GitHub account and select your **`Render-Vps`** repository.
4. Configure the service settings:
   - **Name:** `ubuntu-vps` (or any name you prefer)
   - **Region:** Choose the region closest to you (e.g., Oregon, Frankfurt, Singapore)
   - **Runtime:** **Docker** (Render auto-detects the `Dockerfile`)
   - **Instance Type:** Select **Free** ($0/month)
5. *(Recommended)* Under **Advanced -> Environment Variables**, add:
   - **Key:** `GOTTY_CREDENTIAL`
   - **Value:** `youruser:yourpassword` (e.g. `admin:MySecretPass123`)  
   *(This ensures nobody else on the internet can access your terminal).*
6. Click **Create Web Service**.

---

### Step 3: Access Your Ubuntu VPS

Once the deployment finishes and shows **Live**:
1. Click the URL provided by Render (e.g. `https://ubuntu-vps-xxxx.onrender.com`).
2. If you configured `GOTTY_CREDENTIAL`, enter your username and password when prompted.
3. You now have a full Ubuntu 22.04 bash shell directly in your web browser!

---

## ⚙️ Pre-installed Tools

- `curl`, `wget`, `git`, `nano`, `vim`
- `sudo`, `htop`, `tmux`, `unzip`
- `net-tools`, `iputils-ping`

---

## 📋 How to Copy and Paste in the Terminal

### In Your Web Browser:
1. **Copy:**
   - **Method 1:** Simply highlight any text with your mouse (it automatically copies to your clipboard).
   - **Method 2:** Highlight text and press `Ctrl + Shift + C` (or Right-Click > Copy).
2. **Paste:**
   - **Method 1:** Press `Ctrl + V` or `Ctrl + Shift + V`.
   - **Method 2:** Right-click anywhere in the terminal and choose Paste, or press `Shift + Insert`.

### Transferring Files / Text via Command Line:
- **Share/Copy output to your PC:**
  ```bash
  cat filename.txt | nc termbin.com 9999
  ```
  *(Outputs a 4-letter URL you can open in your browser to copy any command output).*
- **Paste text into a new file:**
  ```bash
  cat << 'EOF' > my_script.sh
  # paste your text here
  EOF
  ```

---

## 📌 Important Notes for Render Free Tier

1. **Inactivity Sleep:** Render's free tier services spin down after 15 minutes of inactivity. When you visit the URL again, it takes ~30–50 seconds to wake up (cold start).
2. **Ephemeral Storage:** Containers on the free tier reset their disk storage when spun down or restarted. Do not store permanent critical data on the container root filesystem.
