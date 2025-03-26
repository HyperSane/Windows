# Guide: Using PowerShell Scripts with Windows 'Send To' Menu

This guide explains how to integrate PowerShell scripts (or any executable/script file) into the Windows **Send To** right-click menu. This is ideal for users maintaining a PowerShell utilities repo, providing a portable and user-friendly way to run scripts on selected files or folders.

---

## 🧱 Prerequisites
- A working PowerShell script or `.exe`.
- Admin access (if you plan to modify `ProgramData` locations or sign scripts).

---

## 📁 Step 1: Locate the 'SendTo' Directory

Press `Win + R` and enter:
```shell
shell:sendto
```
This opens the **user-specific Send To** folder:
```
C:\Users\<YourName>\AppData\Roaming\Microsoft\Windows\SendTo
```

Any shortcut you place here will show up under `Right-Click > Send To` in Windows Explorer.

---

## ⚙️ Step 2: Create a Shortcut to Your PowerShell Script

1. Right-click inside the `SendTo` folder → **New > Shortcut**.
2. For the shortcut target, use:
   ```powershell
   powershell.exe -ExecutionPolicy Bypass -File "C:\Path\To\YourScript.ps1" "%1"
   ```
   Replace the script path with the actual location of your `.ps1` file.
3. Name your shortcut clearly, e.g.:
   ```
   🧹 Clean Ghost Folder (PowerShell)
   ```

Now this will appear in your right-click menu under "Send To."

---

## 🛠 Advanced Usage

### 🧠 Understanding `%1`
- `%1` is a Windows variable representing the full path of the selected file or folder.
- This allows your script to **dynamically receive the selected item as an argument**.

### 🖼 Optional: Add GUI Support
Add this to your PowerShell script to show popups:
```powershell
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show("Action complete!", "Script Status")
```

### 🔐 Optional: Avoid ExecutionPolicy Errors
To ensure compatibility across systems:
```powershell
powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File "C:\Scripts\MyScript.ps1" "%1"
```

---

## 📦 Packaging Your Repo for Users
If you're distributing your PowerShell repo:
1. Include a `SendTo-Shortcuts` folder.
2. Add `.lnk` shortcuts with correct paths or a README with path setup instructions.
3. Document which scripts support Send To usage.

---

## 🧪 Testing
- Right-click a folder or file → `Send To` → Select your script.
- Verify that it receives the target path correctly.
- Use `Write-Host $args[0]` or `param([string]$TargetPath)` in your script to debug input.

---

## ✅ Use Cases
- Batch renaming tools
- File cleaners
- Folder organizers
- Quick converters (e.g., image or video)
- Diagnostic or cleanup tools

---

## 📌 Notes
- Scripts in `Send To` **do not support drag-and-drop**, only right-click → Send To.
- You can also include `.bat` or `.exe` files in the same way.
- Keep script paths static or use relative paths with installer scripts if packaging.

---

## 🔗 Related
- [Microsoft Docs - PowerShell](https://docs.microsoft.com/en-us/powershell/)
- [How-To Geek - Customize Send To Menu](https://www.howtogeek.com/howto/windows-vista/customize-the-windows-vista-send-to-menu/)

---

Your PowerShell script repo is now fully compatible with right-click workflows in Windows!
