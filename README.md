# RDP Shadow Monitor

A lightweight PowerShell utility for IT administrators to remotely shadow and monitor active RDP sessions on network computers — **without requiring user consent prompts**.

Built for Windows environments using built-in tools (`mstsc.exe`, `qwinsta`) — no third-party dependencies required.

---

## 📋 Features

- 🔍 Automatically detects the active RDP session ID on the target machine
- 🖥️ Launches a shadowed RDP session (view-only monitoring)
- ⚠️ Gracefully handles unreachable computers and sessions with no active users
- 🗂️ Includes individual per-workstation monitoring scripts for quick 1-click access
- 🚫 No hardcoded credentials — runs as the currently logged-in admin user

---

## 🗂️ Project Structure

```
rdp-shadow-monitor/
├── scripts/               # 1-click monitoring scripts per workstation
│   ├── pc-01.ps1
│   ├── pc-02.ps1
│   ├── pc-03.ps1
│   └── ... (one per workstation)
├── README.md
├── LICENSE
└── .gitignore
```

---

## ⚙️ Requirements

| Requirement | Details |
|---|---|
| OS | Windows 10 / Windows 11 / Windows Server 2016+ |
| PowerShell | Version 5.1 or later |
| Privileges | Local Administrator on the **target** machine |
| RDS | Remote Desktop Services must be running on the target |
| Network | Line-of-sight network access to target (LAN / VPN) |
| Group Policy | `Set Remote Desktop shadowing settings` must allow shadowing without user consent |

---

## 🚀 Usage

### Individual Monitors (1-Click)

Pre-configured scripts in the `scripts/` folder are set up for specific generic workstations. Simply right-click and **Run with PowerShell**:

```
scripts/pc-01.ps1
scripts/pc-02.ps1
scripts/pc-03.ps1
```

> 💡 **Tip:** Create Desktop shortcuts pointing to each script for quick IT access.

---

## 🔧 Setup & Customization

### Adding a New Workstation Monitor

1. Copy any existing file from `scripts/`
2. Rename it to match the generic index (e.g., `pc-19.ps1`)
3. Update the `$Target` variable inside the script:

```powershell
# Inside pc-19.ps1
$Target = "PC-19"
...
```

### Required Group Policy Setting

On the **target machine** (or via GPO), configure:

```
Computer Configuration
  → Administrative Templates
    → Windows Components
      → Remote Desktop Services
        → Remote Desktop Session Host
          → Connections
            → Set rules for remote control of Remote Desktop Services user sessions
              → View Session without user's permission ✅
```

---

## 🔒 Security Notes

- This tool uses `mstsc /noconsentprompt` — the end user **will not be notified** of shadowing.
- Use responsibly and only in environments where this is permitted by policy and law.
- Ensure access is limited to authorized administrators only.
- **Do not commit real hostnames or IP addresses** into version control.

---

## 📝 License

This project is licensed under the [MIT License](LICENSE).

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request
