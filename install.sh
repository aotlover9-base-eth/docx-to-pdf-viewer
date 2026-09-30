#!/usr/bin/env bash
set -e

echo "============================================="
echo "  Office to PDF Viewer - Easy Installer      "
echo "============================================="
echo

# 1. Directories
BIN_DIR="$HOME/.local/bin"
APP_DIR="$HOME/.local/share/applications"
CACHE_DIR="$HOME/.cache/docx-pdf-viewer"

mkdir -p "$BIN_DIR" "$APP_DIR" "$CACHE_DIR"

# 2. Copy binary
SCRIPT_SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/bin/docx-to-pdf-viewer"
if [[ -f "$SCRIPT_SRC" ]]; then
    cp "$SCRIPT_SRC" "$BIN_DIR/docx-to-pdf-viewer"
    chmod +x "$BIN_DIR/docx-to-pdf-viewer"
    echo "✓ Installed executable to $BIN_DIR/docx-to-pdf-viewer"
else
    echo "Error: bin/docx-to-pdf-viewer not found!"
    exit 1
fi

# 3. Create desktop file
cat <<DESKTOP > "$APP_DIR/docx-pdf-viewer.desktop"
[Desktop Entry]
Version=1.0
Type=Application
Name=Office Document to PDF Viewer
GenericName=Document Viewer
Comment=Open Office documents (.docx, .pptx, .xlsx, .odt) automatically as PDF
Exec=$BIN_DIR/docx-to-pdf-viewer %U
Icon=x-office-document
Terminal=false
StartupNotify=true
Categories=Office;Viewer;
MimeType=application/vnd.openxmlformats-officedocument.wordprocessingml.document;application/msword;application/vnd.openxmlformats-officedocument.wordprocessingml.template;application/vnd.oasis.opendocument.text;application/rtf;text/rtf;application/vnd.openxmlformats-officedocument.presentationml.presentation;application/vnd.ms-powerpoint;application/vnd.oasis.opendocument.presentation;application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;application/vnd.ms-excel;application/vnd.oasis.opendocument.spreadsheet;
DESKTOP

echo "✓ Created desktop integration at $APP_DIR/docx-pdf-viewer.desktop"

# 4. Associate MIME types
if command -v xdg-mime &>/dev/null; then
    MIME_TYPES=(
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        "application/msword"
        "application/vnd.openxmlformats-officedocument.wordprocessingml.template"
        "application/vnd.oasis.opendocument.text"
        "application/rtf"
        "text/rtf"
        "application/vnd.openxmlformats-officedocument.presentationml.presentation"
        "application/vnd.ms-powerpoint"
        "application/vnd.oasis.opendocument.presentation"
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        "application/vnd.ms-excel"
        "application/vnd.oasis.opendocument.spreadsheet"
    )
    for mime in "${MIME_TYPES[@]}"; do
        xdg-mime default docx-pdf-viewer.desktop "$mime" 2>/dev/null || true
    done
    echo "✓ Associated file types (.docx, .doc, .pptx, .xlsx, .odt, .rtf)"
fi

if command -v update-desktop-database &>/dev/null; then
    update-desktop-database "$APP_DIR" 2>/dev/null || true
fi

# 5. Dependency checks
echo
echo "--- Checking Dependencies ---"

# LibreOffice check
HAS_LIBREOFFICE=false
if command -v soffice &>/dev/null || command -v libreoffice &>/dev/null; then
    echo "✓ Found system LibreOffice"
    HAS_LIBREOFFICE=true
elif command -v flatpak &>/dev/null && flatpak info org.libreoffice.LibreOffice &>/dev/null; then
    echo "✓ Found Flatpak LibreOffice"
    HAS_LIBREOFFICE=true
fi

if [ "$HAS_LIBREOFFICE" = false ]; then
    echo "⚠️  LibreOffice engine is missing! You need it to convert documents."
    echo "   You can install it quickly without root permissions using Flatpak:"
    echo "     flatpak install --user -y flathub org.libreoffice.LibreOffice"
    echo "     flatpak override --user --filesystem=host org.libreoffice.LibreOffice"
    echo "   Or using your distro's package manager:"
    echo "     Arch/CachyOS: sudo pacman -S libreoffice-fresh"
    echo "     Ubuntu/Debian: sudo apt install libreoffice"
    echo "     Fedora: sudo dnf install libreoffice"
fi

# Zenity check
if command -v zenity &>/dev/null; then
    echo "✓ Found Zenity (loading progress popup will be shown)"
else
    echo "ℹ️  Zenity not found (optional, used for loading popup). Install via 'sudo pacman -S zenity' or 'sudo apt install zenity'."
fi

# Viewer check
if command -v evince &>/dev/null || command -v okular &>/dev/null; then
    echo "✓ Found PDF viewer"
else
    echo "ℹ️  Make sure you have a PDF viewer like Evince ('sudo pacman -S evince') installed."
fi

echo
echo "============================================="
echo "  🎉 Installation Complete!                  "
echo "  Double-click any .docx in your file manager"
echo "  to test it out!                            "
echo "============================================="
