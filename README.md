# Linux Office-to-PDF Viewer (`docx-to-pdf-viewer`)

A lightweight Linux integration that automatically converts Word, PowerPoint, and Excel documents to PDF on the fly and opens them in your system's default document viewer.

Designed to remove the friction of uploading `.docx`, `.pptx`, and `.xlsx` files to Google Drive or waiting for heavy office suites to open.

---

## The Problem
On Linux desktops (Arch, Debian, Ubuntu, Fedora, etc.):
- Double-clicking a downloaded `.docx`, `.pptx`, or `.xlsx` file often does nothing or triggers an archive extractor.
- Opening a full office suite just to read a simple document takes unnecessary time and memory.
- Many users resort to uploading documents to Google Drive simply to view them in a web browser.

---

## The Solution
- **One-Click Viewing**: Tap or double-click any document directly in your file manager (Dolphin, GNOME Files, Nautilus, Nemo, Thunar).
- **Instant Background Conversion**: Converts the file into a high-fidelity PDF using a headless office engine.
- **Visual Feedback**: Displays a clean loading dialog (`zenity`) while the document is processing (~1–2 seconds on first run).
- **Smart Caching**: Uses SHA-256 fingerprinting (based on path, file size, and modification timestamp). Re-opening the same file opens instantly (<0.15s) from cache.
- **Default PDF Viewer**: Displays the document in your preferred viewer (Evince, Okular, etc.).
- **Zero Cloud Dependencies**: Runs entirely offline on your local machine.

---

## Supported Formats

- **Documents (Google Docs / Word)**:
  - `.docx`
  - `.doc`
  - `.dotx`
  - `.odt`
  - `.rtf`
- **Presentations (Google Slides / PowerPoint)**:
  - `.pptx`
  - `.ppt`
  - `.odp`
- **Spreadsheets (Google Sheets / Excel)**:
  - `.xlsx`
  - `.xls`
  - `.ods`

---

## Installation

Clone the repository and run the installation script:

```bash
git clone https://github.com/aotlover9-base-eth/docx-to-pdf-viewer.git
cd docx-to-pdf-viewer
./install.sh
```

### What `install.sh` Does:
- Copies the runner to `~/.local/bin/docx-to-pdf-viewer`.
- Creates and installs `~/.local/share/applications/docx-pdf-viewer.desktop`.
- Registers default MIME type associations via `xdg-mime` for all supported formats.
- Checks system dependencies and provides setup commands if any are missing.

---

## Requirements

The installer checks for these dependencies automatically:

- **Python 3**: Standard installation (uses only built-in standard libraries, no `pip` dependencies).
- **Conversion Engine (LibreOffice Headless)**:
  - Arch / CachyOS: `sudo pacman -S libreoffice-fresh`
  - Ubuntu / Debian: `sudo apt install libreoffice`
  - Fedora: `sudo dnf install libreoffice`
  - Non-root alternative (Flatpak):
    ```bash
    flatpak install --user -y flathub org.libreoffice.LibreOffice
    flatpak override --user --filesystem=host org.libreoffice.LibreOffice
    ```
- **GUI Progress Dialog (`zenity`)**:
  - Pre-installed on GNOME.
  - Arch: `sudo pacman -S zenity`
  - Ubuntu / Debian: `sudo apt install zenity`
  - *Note: If `zenity` is not available, the script falls back to desktop notifications (`notify-send`).*
- **PDF Viewer**:
  - Evince (GNOME default), Okular (KDE default), Atril, or any viewer associated with `xdg-open`.

---

## Technical Architecture

```
[Click file in Dolphin / GNOME Files]
                 │
                 ▼
     [Check ~/.cache/docx-pdf-viewer]
     ├── Cache Hit (File unchanged) ──────► [Open PDF in <0.15s]
     │
     └── Cache Miss (First run / Modified)
                 │
                 ├── Display Zenity progress dialog
                 ├── Convert via headless LibreOffice
                 ├── Store converted PDF in cache directory
                 └── Dismiss dialog and launch PDF viewer (Evince)
```

---

## Uninstallation

To remove the integration and clean up desktop entries:

```bash
cd docx-to-pdf-viewer
./uninstall.sh
```

---

## License

MIT License. See [LICENSE](LICENSE) for details.
