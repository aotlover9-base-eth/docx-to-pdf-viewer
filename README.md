# 📄 Linux Office-to-PDF Viewer (`docx-to-pdf-viewer`)

> **Double-click any `.docx`, `.pptx`, or `.xlsx` file on Linux and it immediately opens as a clean, crisp PDF in your document viewer.**  
> No terminal needed. No uploading to Google Drive. Just tap and read! 🚀

---

## 😫 The Problem
On Linux (Arch, Ubuntu, Fedora, CachyOS, etc.), if you don't want a heavy office suite open or if you only need to read Word documents, you often get stuck:
- Double-clicking a `.docx` file does nothing or opens an archive tool.
- You have to open your browser, upload the file to Google Drive, and read it there.
- It wastes time and breaks your workflow.

## ✨ The Solution
With this tool:
1. **Just tap or double-click** any Word (`.docx`, `.doc`), PowerPoint (`.pptx`), or Excel (`.xlsx`) file in your file manager (Dolphin, GNOME Files, Nautilus, Nemo, Thunar).
2. A nice **loading popup** shows up for 1–2 seconds while converting:
   > *"Converting 'Document.docx' to PDF... Please wait a moment."*
3. The file instantly opens in your default PDF viewer (like **Evince** or **Okular**).
4. **Smart Cache**: If you open the same document again later, it opens **instantly in 0.1 seconds**!

---

## 🚀 Easy 1-Minute Install

Open your terminal, copy and paste this command:

```bash
git clone https://github.com/aotlover9-base-eth/docx-to-pdf-viewer.git
cd docx-to-pdf-viewer
./install.sh
```

That's it! 🎉

Now go to your file manager (Dolphin or GNOME Files), double-click any `.docx` file, and watch it open right away!

---

## 🛠️ Requirements

The installer checks for these automatically, but here is what it uses:

1. **Conversion Engine (LibreOffice)**  
   Used in headless background mode (you will never see LibreOffice Writer open).
   - If you use **Arch / CachyOS**: `sudo pacman -S libreoffice-fresh`
   - If you use **Ubuntu / Debian**: `sudo apt install libreoffice`
   - If you use **Fedora**: `sudo dnf install libreoffice`
   - Or install without root using **Flatpak**:
     ```bash
     flatpak install --user -y flathub org.libreoffice.LibreOffice
     flatpak override --user --filesystem=host org.libreoffice.LibreOffice
     ```

2. **Loading Popup (`zenity`)** *(Already installed on GNOME)*  
   - Arch: `sudo pacman -S zenity`
   - Ubuntu: `sudo apt install zenity`

3. **PDF Viewer (`evince`)** *(Standard default on GNOME)*  
   - Any PDF viewer like Evince or Okular works automatically.

---

## 📂 Supported Formats

- **Word Documents**: `.docx`, `.doc`, `.dotx`, `.odt`, `.rtf`
- **Presentations**: `.pptx`, `.ppt`, `.odp`
- **Spreadsheets**: `.xlsx`, `.xls`, `.ods`

---

## ⚙️ How It Works (Under the Hood)

```
[Tap on .docx in Dolphin / Files]
               │
               ▼
   [Check Smart Cache]
   ├── Already converted & unchanged? ──► [Open PDF in <0.15s!]
   │
   └── Not cached yet?
               │
               ├─► [Show Loading Progress Popup]
               ├─► [Convert via Headless LibreOffice]
               └─► [Save to ~/.cache/docx-pdf-viewer/] ──► [Open PDF in Evince]
```

- **Zero Terminal**: Everything is registered with the system's desktop MIME handler (`xdg-mime`), so it behaves just like a native app.
- **Safe & Local**: Your documents are processed 100% locally on your machine. Nothing is sent to the internet or external servers.

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
