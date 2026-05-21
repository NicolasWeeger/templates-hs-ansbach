#!/usr/bin/env bash
#
# init-marp-workspace.sh — richtet einen Ordner als Marp-Präsentations-
# Workspace ein, der das zentral abgelegte HS-Ansbach-Theme nutzt.
#
# Anlegt:
#   <workspace>/themes              → Symlink in das zentrale Theme-Repo
#   <workspace>/.marprc.yml         → themeSet: ./themes
#   <workspace>/.vscode/settings.json → markdown.marp.themes registriert
#   <workspace>/.vscode/tasks.json  → Marp HTML watch (auto-export on save)
#   <workspace>/.gitignore          → Symlink + Watch-Output ausgeblendet
#   <workspace>/Slides/             → leerer Ordner für eigene .md-Decks
#
# Bestehende Dateien werden NICHT überschrieben — nur ergänzt, was fehlt.
#
# Usage:
#   bin/init-marp-workspace.sh <ziel-workspace>
#
# Beispiel:
#   ~/Vorlagen/Presentation_Template_Marp/bin/init-marp-workspace.sh ~/Lehre/Vorlesung-XYZ

set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <ziel-workspace>" >&2
    exit 1
fi

TARGET="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_REPO="$(cd "${SCRIPT_DIR}/.." && pwd)"
THEMES_SRC="${TEMPLATE_REPO}/themes"

if [[ ! -d "${THEMES_SRC}" ]]; then
    echo "Fehler: Theme-Ordner nicht gefunden unter ${THEMES_SRC}" >&2
    exit 1
fi

mkdir -p "${TARGET}"
cd "${TARGET}"

# --- Symlink themes/ ---------------------------------------------------------
if [[ -L themes ]]; then
    echo "✓ themes/ ist bereits Symlink: $(readlink themes)"
elif [[ -e themes ]]; then
    echo "⚠ themes/ existiert bereits als echter Ordner — kein Symlink angelegt"
else
    ln -s "${THEMES_SRC}" themes
    echo "✓ Symlink angelegt: themes -> ${THEMES_SRC}"
fi

# --- .marprc.yml -------------------------------------------------------------
if [[ -e .marprc.yml ]]; then
    echo "✓ .marprc.yml existiert bereits — unverändert gelassen"
else
    cat >.marprc.yml <<'EOF'
# Marp CLI configuration.
# themeSet zeigt auf ./themes — das ist ein Symlink auf das zentrale Theme-Repo.
themeSet:
  - ./themes
EOF
    echo "✓ .marprc.yml angelegt"
fi

# --- .vscode/ ----------------------------------------------------------------
mkdir -p .vscode

if [[ -e .vscode/settings.json ]]; then
    echo "⚠ .vscode/settings.json existiert bereits — bitte ergänze manuell:"
    echo "    \"markdown.marp.themes\": [\"./themes/hs-ansbach-gruen.css\"]"
else
    cat >.vscode/settings.json <<'EOF'
{
    "markdown.marp.themes": [
        "./themes/hs-ansbach-gruen.css"
    ]
}
EOF
    echo "✓ .vscode/settings.json angelegt"
fi

if [[ -e .vscode/tasks.json ]]; then
    echo "⚠ .vscode/tasks.json existiert bereits — bitte Watch-Task manuell ergänzen"
else
    cat >.vscode/tasks.json <<'EOF'
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Marp: HTML watch (auto-export on save)",
            "type": "shell",
            "command": "marp --watch --html --allow-local-files --input-dir Slides --output Slides/html_Slides",
            "isBackground": true,
            "presentation": {
                "echo": true,
                "reveal": "silent",
                "focus": false,
                "panel": "dedicated",
                "showReuseMessage": false,
                "clear": false
            },
            "runOptions": {
                "runOn": "folderOpen"
            },
            "problemMatcher": []
        }
    ]
}
EOF
    echo "✓ .vscode/tasks.json angelegt"
fi

# --- .gitignore --------------------------------------------------------------
touch .gitignore
for entry in "themes" "Slides/html_Slides/"; do
    if ! grep -qxF "${entry}" .gitignore; then
        echo "${entry}" >>.gitignore
        echo "✓ .gitignore: ${entry} hinzugefügt"
    fi
done

# --- Slides/ -----------------------------------------------------------------
mkdir -p Slides

# Nur einen Starter anlegen, wenn noch gar keine .md im Slides-Ordner liegt.
if ! compgen -G "Slides/*.md" >/dev/null; then
    cat >Slides/01-folien.md <<'EOF'
---
marp: true
theme: hs-ansbach-gruen
paginate: true
footer: "Vorlesungstitel"
---

<!-- _class: title -->

# Titel der Vorlesung

### Untertitel

Hochschule Ansbach

---

# Erste Folie

- Punkt eins
- Punkt zwei
- Punkt drei

<!-- Speaker Notes erscheinen im Presenter Mode, nicht auf der Folie. -->
EOF
    echo "✓ Slides/01-folien.md angelegt (Starter-Deck mit Frontmatter)"
else
    echo "✓ Slides/ enthält bereits .md-Dateien — kein Starter-Deck angelegt"
fi

echo
echo "Setup fertig in: ${TARGET}"
echo
echo "Nächste Schritte:"
echo "  1. VS Code im Workspace öffnen: code \"${TARGET}\""
echo "  2. Slides/01-folien.md öffnen (oder eigene .md anlegen)"
echo "  3. Preview: Ctrl+Shift+V"
