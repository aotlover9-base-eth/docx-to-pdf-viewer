#!/usr/bin/env bash
set -e

echo "Uninstalling Office Document to PDF Viewer..."

rm -f "$HOME/.local/bin/docx-to-pdf-viewer"
rm -f "$HOME/.local/share/applications/docx-pdf-viewer.desktop"

if command -v update-desktop-database &>/dev/null; then
    update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
fi

read -p "Do you also want to clear the document PDF cache (~/.cache/docx-pdf-viewer)? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "$HOME/.cache/docx-pdf-viewer"
    echo "✓ Cache cleared"
fi

echo "✓ Successfully uninstalled!"
