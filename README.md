# 📑 Linux Office-to-PDF Viewer (`office-to-pdf-viewer`)

> **Double-click any Word Document, PowerPoint Presentation, or Excel Sheet on Linux and it immediately opens as a crisp PDF in your document viewer.**  
> Supports **all Google Docs, Slides, and Sheets formats** (`.docx`, `.pptx`, `.xlsx`, etc.).  
> No terminal needed. No uploading to Google Drive just to read a file. Just tap and read! 🚀

---

## 😫 The Problem
On Linux (Arch, Ubuntu, Fedora, CachyOS, etc.), you often download files from school, university, or work created in **Google Workspace** or **Microsoft Office**:
- You download a Word document (`.docx`), a presentation (`.pptx`), or an Excel spreadsheet (`.xlsx`).
- Double-clicking the file does nothing, gives an error, or opens an archive manager.
- You are forced to open your web browser, upload the file to Google Drive, and open it in Google Docs/Sheets/Slides just to take a quick look.
- It wastes time and interrupts your workflow.

---

## ✨ The Solution
With this tool:
1. **Tap or double-click** any Office or Google Apps export in your file manager (Dolphin, GNOME Files, Nautilus, Nemo, Thunar).
2. A sleek **loading progress popup** appears for ~1–2 seconds:
   > *"Converting 'Lecture_Notes.pptx' to PDF... Please wait a moment."*
3. The file instantly opens in your default PDF viewer (like **Evince** or **Okular**).
4. **Smart Cache System**: If you reopen the same file later, it opens **instantly in under 0.15 seconds** without re-converting!

---

## 📂 Supported Formats (All Office & Google App Exports)

| Category | File Formats Supported |
| :--- | :--- |
| 📝 **Documents (Google Docs / Word)** | `.docx`, `.doc`, `.dotx`, `.odt`, `.rtf` |
| 📊 **Presentations (Google Slides / PowerPoint)** | `.pptx`, `.ppt`, `.odp` |
| 📈 **Spreadsheets (Google Sheets / Excel)** | `.xlsx`, `.xls`, `.ods` |

---

## 🚀 Easy 1-Minute Install

Open your terminal, copy and paste this command:

```bash
git clone https://github.com/aotlover9-base-eth/docx-to-pdf-viewer.git
cd docx-to-pdf-viewer
./install.sh
```

That's it! 🎉

Now go to your file manager (Dolphin or GNOME Files), double-click any `.docx`, `.pptx`, or `.xlsx` file, and watch it open right away!

---

## 🛠️ Requirements

The installer checks for these automatically, but here is what it uses:

1. **Conversion Engine (LibreOffice)**  
   Runs quietly in headless background mode (you will never see LibreOffice Writer open).
   - **Arch / CachyOS**: `sudo pacman -S libreoffice-fresh`
   - **Ubuntu / Debian**: `sudo apt install libreoffice`
   - **Fedora**: `sudo dnf install libreoffice`
   - **Without Root (Flatpak)**:
     ```bash
     flatpak install --user -y flathub org.libreoffice.LibreOffice
     flatpak override --user --filesystem=host org.libreoffice.LibreOffice
     ```

2. **Loading Progress Bar (`zenity`)** *(Already installed on GNOME)*  
   - Arch: `sudo pacman -S zenity`
   - Ubuntu: `sudo apt install zenity`

3. **PDF Viewer (`evince` or `okular`)** *(Standard default on GNOME/KDE)*  
   - Any PDF viewer installed on your system works automatically.

---

## ⚙️ How It Works

```
[Tap on .docx / .pptx / .xlsx in Dolphin or Files]
                         │
                         ▼
             [Check Smart Cache]
             ├── Already converted & unchanged? ──► [Open PDF in <0.15s!]
             │
             └── First time opening?
                         │
                         ├─► [Show Loading Progress Dialog]
                         ├─► [Convert via Headless Office Engine]
                         └─► [Save to ~/.cache/docx-pdf-viewer/] ──► [Open PDF in Viewer]
```

- **Zero Terminal Needed**: Registers with the system's desktop MIME database (`xdg-mime`), so it behaves just like a native app.
- **Safe & 100% Offline**: Your files never leave your computer. Everything converts locally with zero cloud dependencies.

---

## 🗑️ How to Uninstall

If you ever want to remove it, simply run:

```bash
cd docx-to-pdf-viewer
./uninstall.sh
```

---

## 📄 License

MIT License. Free to use, modify, and share!
