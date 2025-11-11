## 🔔 Windows Unlock Email Notifier

A lightweight PowerShell + Task Scheduler automation that sends you an email every time your Windows 11 computer is **unlocked**.  
Perfect for monitoring workstation access or testing automation triggers.

---

## 🧠 Overview

This script uses **Windows Task Scheduler** to detect the `On workstation unlock` event and runs a short PowerShell script that sends an email notification via Gmail SMTP (or any other mail server).  
It consumes almost no background resources — the script runs only once when triggered, then exits.

---

## ⚙️ Features

- Sends an email automatically when your PC is unlocked  
- Uses your Gmail account securely (via App Password)  
- Optional local logging for debugging  
- Fully silent in the background  
- Works on Windows 10 and 11

---

## 🧩 Requirements

1. **Windows 10 or 11**
2. **PowerShell** (preinstalled)
3. A **Gmail account** with:
   - 2-Step Verification enabled
   - An **App Password** generated for “Mail → Windows Computer”
4. Internet connection to send the email

---

## 🪄 Setup Instructions

### 1. Clone or download the repo

```bash
git clone "https://github.com/Dewmith/Unlock_notification.git"
```
```bash
cd Unlock_notification
```

### 2. Edit the PowerShell script
Open UnlockEmailSMTP.ps1 and update the following values:

```bash
$smtpUser = 'your.email@gmail.com'      # sender email
$smtpPass = 'YOUR_APP_PASSWORD'         # generated Gmail App Password
$to       = 'email_to_recieve_the_notification@gmail.com'   # recipient email
```
Save the file.

Need help creating gmail app password? [Click here](https://github.com/Dewmith/Unlock_notification?tab=readme-ov-file#-tips-enable-app-passwords).

### 3. Create the Task in Task Scheduler

1. Open Task Scheduler → Create Task.

2. General tab

    - Name: Send email on unlock
    - Select your user account
    - Optionally check Run whether user is logged on or not

3. Triggers tab

    - New...
    - Begin the task: On workstation unlock
    - Select Any user (or your user)

4. Actions tab

    - New...
    - Action: Start a program

Program/script:

```bash
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
```

Add arguments:

```bash
-ExecutionPolicy Bypass -File "C:\path\to\UnlockEmailSMTP.ps1"
```

5. Settings tab

    - Uncheck “Stop the task if it runs longer than…”
    - Check “Allow task to be run on demand”

Click OK, enter your password if required, and save.

### 4. Test
You can test it manually:

- In Task Scheduler, right-click your new task → Run

- Check your inbox for an email titled
```bash
PC unlocked: <COMPUTERNAME> by <USERNAME>
```

If the email doesn’t arrive:

- Check your spam folder

- Review the log at
```bash
C:\Users\<YourUser>\unlock_notify.log
```
---
### ✅ Tips: Enable App Passwords

1. Go to this exact link while signed into your account:

👉 https://myaccount.google.com/apppasswords

2. If you see a login prompt, sign in with your password (not a passkey).
3. It should now display the App Passwords page.

    - Choose Mail for the app.

    - Choose Windows Computer for the device.

    - Click Generate.

    - Copy the 16-character code it gives you (no spaces).

4. Paste that into your PowerShell script as:
 ```bash
$smtpPass = 'xxxxxxxxxxxxxxxx'
 ```

---

### 🧠 Notes

The task automatically triggers after every system restart and unlock.

The script only runs for a few milliseconds; it does not stay active in the background.

For privacy and simplicity, you can use a dedicated Gmail account for sending notifications.

---
### 🔒 Security

Never store your primary Gmail password in plain text.

Always use App Passwords (from Google Account → Security → App Passwords).

Limit file access to your user only.

---
### 🧰 Optional Enhancements

Add a second trigger “At startup” to log when the system boots.

Replace Gmail with a webhook (IFTTT/Zapier) for password-free setup.

Extend the script to capture local IP, battery status, or uptime.

---
### 📄 License

MIT License — use and modify freely.

Author: [Dewmith WEERASENA](https://github.com/Dewmith)