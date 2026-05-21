# HS Ansbach — Marp Theme

Marp-Theme im Corporate Design der Hochschule Ansbach: grüner
Hintergrund, einheitliche Fußzeile (Vorlesungstitel links, Dozent
mittig, Seitenzahl rechts), Titelfolie und Spalten-Layouts.

Beispieldeck mit allen Funktionen → [`Slides/template.md`](Slides/template.md).

## Gliederung

- [Inhalt dieses Ordners](#inhalt-dieses-ordners)
- [Voraussetzung](#voraussetzung)
- [Schnellstart](#schnellstart)
- [Template zentral nutzen (mehrere Präsentationen)](#template-zentral-nutzen-mehrere-präsentationen)
- [Theme konfigurieren (zentrale Stelle)](#theme-konfigurieren-zentrale-stelle)
- [Folienklassen (Layout)](#folienklassen-layout)
  - [Spalten auf gleicher Höhe: `.below-title`](#spalten-auf-gleicher-höhe-below-title)
- [Inline-Klassen](#inline-klassen)
- [Markdown-Features im Überblick](#markdown-features-im-überblick)
  - [Gliederung mit Sprung-Links](#gliederung-mit-sprung-links)
- [Kommentare & Speaker Notes](#kommentare--speaker-notes)
- [Live-Preview in VS Code](#live-preview-in-vs-code)
- [Auto-HTML beim Speichern](#auto-html-beim-speichern)
- [Präsentation halten (empfohlener Weg: HTML)](#präsentation-halten-empfohlener-weg-html)
- [Export](#export)
- [Theme weitergeben](#theme-weitergeben)
- [Troubleshooting](#troubleshooting)
- [Contribution](#contribution)

## Inhalt dieses Ordners

```
Presentation_Template_Marp/
├── README.md                         ← diese Datei
├── Slides/                           ← Beispieldeck (.md) liegt hier
│   ├── template.md                   ← Beispieldeck (alle Funktionen demonstriert)
│   └── html_Slides/                  ← Auto-Output der Watch-Task (gitignored)
├── bin/
│   └── init-marp-workspace.sh        ← One-Shot-Skript zum Einrichten neuer Workspaces
├── .marprc.yml                       ← Marp-CLI-Config (Theme-Pfad für CLI/Watch)
├── .vscode/
│   ├── settings.json                 ← registriert das Theme für die VS-Code-Preview
│   └── tasks.json                    ← Marp-Watch-Task (auto-HTML on save)
├── images/                           ← Beispielbilder fürs Template
│   └── Logo_HS_Ansbach.png
└── themes/
    ├── hs-ansbach-gruen.css           ← Theme-CSS (Single Source)
    └── hintergrund_hs_ansbach_gruen.png  ← Quell-Asset (im CSS schon base64-inline)
```

Das Hintergrund-PNG ist als `data:`-URI direkt in die CSS eingebettet —
beim Weitergeben reicht **ausschließlich `themes/hs-ansbach-gruen.css`**
(die `.png` muss nicht mit kopiert werden).

## Voraussetzung

[Marp-Extension für VS Code](https://marketplace.visualstudio.com/items?itemName=marp-team.marp-vscode):
`marp-team.marp-vscode`.

Für PDF/HTML/PPTX-Export optional die [Marp-CLI](https://github.com/marp-team/marp-cli):

```bash
npm install -g @marp-team/marp-cli
```

## Schnellstart

1. **Repo einmal zentral klonen** (Pfad nach Geschmack):
   ```bash
   git clone <repo-url> /pfad/zu/Presentation_Template_Marp
   ```
2. **Theme personalisieren** — in
   [`themes/hs-ansbach-gruen.css`](themes/hs-ansbach-gruen.css) ganz oben
   die CSS-Variable `--lecturer-name` auf den eigenen Namen ändern
   (Details unter [Theme konfigurieren](#theme-konfigurieren-zentrale-stelle)).
3. **Neuen Vorlesungs-Workspace einrichten** mit dem Init-Skript:
   ```bash
   /pfad/zu/Presentation_Template_Marp/bin/init-marp-workspace.sh ~/Lehre/Vorlesung-XYZ
   ```
   Das Skript legt Symlink, alle Configs, den `Slides/`-Ordner und ein
   Starter-Deck `Slides/01-folien.md` mit fertigem Frontmatter an.
4. VS Code im Workspace öffnen, `Slides/01-folien.md` öffnen — Preview
   mit `Ctrl+Shift+V`. Frontmatter ist bereits gesetzt:
   ```yaml
   ---
   marp: true
   theme: hs-ansbach-gruen
   paginate: true
   footer: "Vorlesungstitel"
   ---
   ```

Details, Hintergründe und Alternativen: siehe
[Template zentral nutzen](#template-zentral-nutzen-mehrere-präsentationen).

`footer:` muss gesetzt sein, damit Marp das Footer-Element rendert.
Der angezeigte Text erscheint unten links auf jeder Folie; der
Dozent-Name unten Mitte kommt aus der CSS-Variable (siehe
[Theme konfigurieren](#theme-konfigurieren-zentrale-stelle)).

## Template zentral nutzen (mehrere Präsentationen)

Du musst das Repo **nicht** pro Präsentation neu klonen. Einmal zentral
ablegen, eigenen Namen eintragen — und in jedem Workspace, in dem du
Folien schreiben willst, einen **Symlink** in den `themes/`-Ordner
legen. Das Theme lebt physisch nur einmal, jede Änderung greift sofort
in allen Präsentationen.

### Warum Symlink — und nicht User-Settings?

Die Marp-VS-Code-Extension lädt CSS-Themes aus
`markdown.marp.themes` **nur, wenn sie innerhalb des geöffneten
Workspaces liegen** — ein absoluter Pfad in den User-Settings, der
außerhalb zeigt, wird aus Sicherheitsgründen ignoriert (still, ohne
Fehlermeldung — die Preview rendert dann das Default-Theme). Ein
Symlink im Workspace umgeht diese Schranke sauber: aus Sicht der
Extension liegt das Theme im Workspace, physisch lebt es weiter
zentral.

### Schritt 1 — Repo einmal zentral ablegen

```bash
git clone <repo-url> "/pfad/zu/Vorlagen/Presentation_Template_Marp"
```

Der Pfad ist frei wählbar — er taucht später nur in den Symlinks auf,
nicht in den Workspace-Dateien.

### Schritt 2 — Theme personalisieren

In [`themes/hs-ansbach-gruen.css`](themes/hs-ansbach-gruen.css) ganz
oben im `CENTRAL CONFIGURATION`-Block den eigenen Namen eintragen:

```css
--lecturer-name: 'Prof. Dr. Mustermann';
```

Wirkt automatisch in jeder Präsentation, die das Theme via Symlink
nutzt — siehe [Theme konfigurieren](#theme-konfigurieren-zentrale-stelle).

### Schritt 3 — Pro neuem Präsentations-Workspace einrichten

#### Schneller Weg: Init-Skript

Im Template-Repo liegt [`bin/init-marp-workspace.sh`](bin/init-marp-workspace.sh) —
ein One-Shot-Skript, das in einem Zielordner alles Nötige anlegt:
Symlink `themes/`, `.marprc.yml`, `.vscode/settings.json`,
`.vscode/tasks.json`, `.gitignore`, `Slides/`-Ordner **und** ein
Starter-Deck `Slides/01-folien.md` mit fertigem Frontmatter.

```bash
/pfad/zu/Presentation_Template_Marp/bin/init-marp-workspace.sh ~/Lehre/Vorlesung-XYZ
```

Das Skript überschreibt **keine** bestehenden Dateien — es ergänzt nur,
was fehlt, und meldet was es übersprungen hat. Existiert eine
`.vscode/settings.json` schon, musst du den `markdown.marp.themes`-
Eintrag manuell ergänzen (siehe unten).

#### Manueller Weg

Wenn du lieber selbst Hand anlegst — drei Dinge:

**(a) Symlink in den Workspace legen**

```bash
cd ~/Lehre/Vorlesung-XYZ
ln -s /pfad/zu/Presentation_Template_Marp/themes themes
echo "themes" >> .gitignore   # Symlink nicht ins Repo committen
```

`ls -la themes` muss danach so aussehen:
```
lrwxrwxrwx ... themes -> /pfad/zu/Presentation_Template_Marp/themes
```

**(b) `.vscode/settings.json` anlegen** — registriert das Theme über
den Symlink für die VS-Code-Preview und den manuellen Export:

```json
{
    "markdown.marp.themes": [
        "./themes/hs-ansbach-gruen.css"
    ]
}
```

Der relative Pfad `./themes/...` folgt dem Symlink — du musst hier
nie den zentralen Pfad eintragen.

**(c) `.marprc.yml` und `.vscode/tasks.json` anlegen** — für die
Marp-CLI (Watch-Build beim Speichern + Terminal-Export für PDF/PPTX).
Siehe nächster Abschnitt.

Danach: VS Code im Workspace öffnen, eine `.md` mit
`theme: hs-ansbach-gruen` anlegen — Preview, manueller Export und
Auto-Build funktionieren.

### Theme-Update an einer Stelle

Änderst du `themes/hs-ansbach-gruen.css` im zentralen Repo, sehen das
**alle** Workspaces mit Symlink sofort — der Symlink folgt dem
Original.

### CLI-Export & Auto-HTML-Watch in den eigenen Projekten

Wichtig zu verstehen — es gibt **zwei** Marp-Welten, die separat
konfiguriert werden:

- **VS-Code-Preview / manueller Export**: liest `markdown.marp.themes`
  aus der Workspace-`settings.json` (Schritt 3b) → `./themes/hs-ansbach-gruen.css`
  über den Symlink.
- **Marp-CLI** (Watch-Task, Terminal-Export): kennt die VS-Code-
  Settings nicht. Findet das Theme nur über `.marprc.yml` im
  Workspace.

**Zwei zusätzliche Dateien pro Workspace** (Schritt 3c):

1. **`.marprc.yml`** im Workspace-Root — folgt ebenfalls dem Symlink:
   ```yaml
   themeSet:
     - ./themes
   ```

2. **`.vscode/tasks.json`** mit der Watch-Task — direkt aus diesem
   Repo kopierbar:
   ```json
   {
       "version": "2.0.0",
       "tasks": [{
           "label": "Marp: HTML watch (auto-export on save)",
           "type": "shell",
           "command": "marp --watch --html --allow-local-files --input-dir Slides --output Slides/html_Slides",
           "isBackground": true,
           "runOptions": { "runOn": "folderOpen" },
           "problemMatcher": []
       }]
   }
   ```
   → [`.vscode/tasks.json`](.vscode/tasks.json) in diesem Repo.

Damit ist der Symlink die einzige Quelle der Wahrheit — Extension
**und** CLI lesen beide über `./themes/`. Biegst du den Symlink mal
um (anderer Speicherort des zentralen Repos), folgen beide
automatisch — keine Datei im Workspace muss angepasst werden.

**Kann man das automatisieren?** Leider nein — VS Code startet
Watch-Tasks nur pro Workspace beim Folder-Open. Pragmatisch: die drei
Dateien (`themes`-Symlink, `.marprc.yml`, `.vscode/tasks.json`) einmal
pro Workspace per Copy & Paste anlegen — 30 Sekunden Aufwand.

### Brauche ich die `.vscode/settings.json` überhaupt?

**Ja** — die Marp-Extension prüft beim Aktivieren, welche Themes
registriert sind, und reagiert nur auf solche, die in
`markdown.marp.themes` stehen. Der Symlink alleine reicht nicht; der
relative Pfad muss zusätzlich eingetragen sein. Aber: nur **diese eine
Zeile** ist nötig — keine Trust-Settings, keine absoluten Pfade,
keine sonstigen Konfigurationen.

### Übersicht: was wo liegt

| Datei im Workspace | Inhalt | Wofür |
|---|---|---|
| `themes/` (Symlink) | → zentrales Theme-Repo | Quelle der Wahrheit |
| `.gitignore` (Zeile `themes`) | — | Symlink wird nicht committed |
| `.vscode/settings.json` | `markdown.marp.themes: ["./themes/hs-ansbach-gruen.css"]` | VS-Code-Preview + manueller Export |
| `.marprc.yml` | `themeSet: ./themes` | Marp-CLI (Watch + Terminal-Export) |
| `.vscode/tasks.json` | Watch-Task `marp --watch ...` | Auto-HTML beim Speichern |

### Windows-Hinweis

`ln -s` funktioniert in der Git-Bash; alternativ in PowerShell mit
`New-Item -ItemType SymbolicLink -Path themes -Target "C:\pfad\zu\Presentation_Template_Marp\themes"`.
Windows verlangt für Symlinks **Admin-Rechte oder aktivierten
Entwicklermodus** (Einstellungen → Update & Sicherheit → Für
Entwickler → Entwicklermodus).

Falls Symlinks auf Windows nicht möglich sind: Theme einfach pro
Projekt kopieren. Updates müssen dann manuell nachgezogen werden —
nicht ideal, aber funktioniert.

## Theme konfigurieren (zentrale Stelle)

**Dozent-Name** ist zentral in der CSS, **Vorlesungstitel** pro Deck
im `footer:`-Feld.

### Dozent-Name (zentral)

In [`themes/hs-ansbach-gruen.css`](themes/hs-ansbach-gruen.css) ganz
oben im `section { ... }`-Block, im `CENTRAL CONFIGURATION`-Abschnitt:

```css
--lecturer-name: 'Prof. Dr. Mustermann';
```

Wirkt automatisch auf **alle** Foliendateien, die
`theme: hs-ansbach-gruen` verwenden. Keine Änderung pro Deck nötig.

**Pro-Deck-Override** (z.B. ein einzelner Gastvortrag mit anderem
Dozenten): im YAML-Frontmatter der jeweiligen `.md`:

```yaml
style: |
  section { --lecturer-name: 'Gastdozent'; }
```

### Vorlesungstitel (pro Deck)

Im Frontmatter jeder `.md` über die Standard-Marp-Direktive `footer:`:

```yaml
---
marp: true
theme: hs-ansbach-gruen
paginate: true
footer: "Clean Code Bootcamp"
---
```

Der Wert erscheint unten links auf jeder Folie (außer Titelfolien).

## Folienklassen (Layout)

Per HTML-Kommentar als **erste Zeile** der Folie aktivieren:

| Klasse | Wirkung | Demo |
|---|---|---|
| `<!-- _class: title -->` | Titelfolie: zentriert, kein Footer, keine Seitenzahl | [Slides/template.md](Slides/template.md) Folie 1, 14 |
| `<!-- _class: split -->` | 2 Spalten 50/50 | Folie 8 |
| `<!-- _class: split-60 -->` | 2 Spalten 60/40 | Folie 9 |
| `<!-- _class: split-40 -->` | 2 Spalten 40/60 | Folie 10 |
| `<!-- _class: split-30 -->` | 2 Spalten 30/70 | Folie 11 |
| `<!-- _class: compact -->` | Schriftgröße 20 px statt 24 (für dichte Folien) | Folie 14 |
| `<!-- _class: dense -->` | Schriftgröße 18 px (für sehr dichte Folien) | Folie 14 |

**Klassen sind kombinierbar** — mehrere Klassen durch Space getrennt:

```markdown
<!-- _class: split compact -->
<!-- _class: split-60 dense -->
```

Code-Blöcke nutzen `font-size: 0.83em` (relativ), skalieren also mit
`.compact` / `.dense` proportional mit.

**Konvention für Split-Folien:**

```markdown
<!-- _class: split -->

# Folientitel

<div>

Linke Spalte (steht unter dem Titel)

</div>

<div>

Rechte Spalte (vertikal über die ganze Folienhöhe zentriert)

</div>
```

### Spalten auf gleicher Höhe: `.below-title`

Standardmäßig wird die **rechte Spalte über die ganze Folienhöhe**
vertikal zentriert — sie sitzt damit „neben" dem Titel, also höher
als der linke Text. Wenn du beide Spalten auf gleicher Höhe haben
willst, leg `class="below-title"` auf den rechten `<div>`:

```markdown
<!-- _class: split-40 -->

# Folientitel

<div>

Linker Text (unter dem Titel).

</div>

<div class="below-title">

Rechter Text — startet erst unter dem Titel, auf gleicher Höhe
wie der linke.

</div>
```

Demo: [Slides/template.md](Slides/template.md) Folie 10.

## Inline-Klassen

| Klasse | Wirkung | Beispiel |
|---|---|---|
| `.center` | Block-Inhalt zentrieren (Logos, QR-Codes) | `<div class="center">![](qr.png)</div>` |
| `.source` | Kleine kursive Quellenangabe, rechtsbündig | `<span class="source">Quelle: …</span>` |
| `.below-title` | Spalte einer Split-Folie unter dem Titel positionieren | `<div class="below-title">…</div>` |

Demo: [Slides/template.md](Slides/template.md) Folie 12 (`.center`/`.source`) und Folie 10 (`.below-title`).

## Markdown-Features im Überblick

Alle als Beispiele in [`Slides/template.md`](Slides/template.md):

| Feature | Syntax | Demo-Folie |
|---|---|---|
| Gliederung mit Sprung-Links | `[Abschnitt](#3)` | Folie 2 |
| Hervorhebung | `**fett**`, `*kursiv*`, `` `code` `` | Folie 4 |
| Aufzählungen | `- punkt` / `1. punkt` | Folie 4 |
| Zitate | `> Zitat` | Folie 5, 11 |
| Code-Block | ` ```python … ``` ` | Folie 5 |
| Tabelle | `\| Spalte \| Spalte \|` + `\|---\|---\|` | Folie 6 |
| Bild mit Größe | `![w:300](pfad)`, `![h:150](pfad)` | Folie 7 |
| Bild als Hintergrund | `![bg right:35% w:70%](pfad)` | Folie 7 |
| Speaker Notes | `<!-- Notiz -->` auf einer Folie | jede Folie |
| Markdown-only-Kommentar | `[//]: # (Notiz)` | Folie 13 |

### Gliederung mit Sprung-Links

In Marp-Bespoke-HTML (Standard-Export) ist jede Folie über die URL
`#N` (Folien-Nummer ab 1) ansteuerbar. Eine Gliederung mit Links:

```markdown
# Gliederung

1. [Konfiguration](#3)
2. [Markdown-Grundlagen](#4)
3. [Tabelle](#6)
```

Funktioniert im HTML-Export — in der VS-Code-Preview springen die
Anker nicht zuverlässig. Demo: [Slides/template.md](Slides/template.md) Folie 2.

## Kommentare & Speaker Notes

**Zwei Kommentar-Arten** in einer `.md`-Datei — Übersicht:

| Syntax | Folie | Presenter Mode | Quelltext |
|---|:-:|:-:|:-:|
| `<!-- … -->` (HTML-Kommentar) | — | ✓ | ✓ |
| `[//]: # (…)` (Markdown-only) | — | — | ✓ |

**HTML-Kommentare** dienen doppelt:

1. **Folienklasse setzen** — als *erste Zeile* der Folie:
   ```markdown
   <!-- _class: split -->
   ```
2. **Speaker Notes** — überall sonst auf der Folie:
   ```markdown
   <!-- Diese Notiz erscheint im Presenter Mode,
        nicht auf der Folie selbst. -->
   ```

**Markdown-only-Kommentare** (`[//]: # (…)`) tauchen *nirgends* im
gerenderten Output auf — auch nicht im Presenter Mode. Nutzen:
Editor-interne TODOs, Review-Notizen, deaktivierte Folien-Inhalte.

```markdown
[//]: # (TODO: Quelle für die Folie noch suchen.)
```

Demo: [Slides/template.md](Slides/template.md) Folie 13.

Marp behandelt jeden HTML-Kommentar, der **nicht** mit `_class:`,
`_backgroundColor:`, `_color:` o.ä. anfängt, als Speaker Note. Diese
sind im HTML-Presenter-Mode sichtbar (siehe nächster Abschnitt).

## Live-Preview in VS Code

| Shortcut | Wirkung |
|---|---|
| `Ctrl+Shift+V` | Preview im Editor öffnen |
| `Ctrl+K V` | Preview daneben (Split) |

Änderungen am Markdown und an [`themes/hs-ansbach-gruen.css`](themes/hs-ansbach-gruen.css)
werden live übernommen.

## Auto-HTML beim Speichern

Marp CLI's Watch-Modus regeneriert die HTML-Dateien bei jedem Save —
als VS Code Task vorkonfiguriert in [`.vscode/tasks.json`](.vscode/tasks.json):

- **Auto-Start**: Beim Öffnen des Workspace startet die Task automatisch.
  Beim allerersten Mal fragt VS Code „Allow automatic tasks in folder" —
  einmal mit *Allow* bestätigen, danach läuft sie still im Hintergrund.
- **Output**: `Slides/html_Slides/template.html`, … — alle generierten
  HTML-Dateien landen im `html_Slides/`-Unterordner. Browser nochmal
  laden zeigt den aktuellen Stand.
- **Manuell starten/stoppen**: `Ctrl+Shift+P` → „Tasks: Run Task" →
  *Marp: HTML watch*. Stop über das Terminal-Tab (Mülltonnen-Icon).
- **Voraussetzung**: Marp CLI installiert
  (`npm install -g @marp-team/marp-cli`).
- **Beobachtet** werden alle `.md`-Dateien in `Slides/`. Neue Dateien
  werden bei Marp's `--input-dir`-Mode automatisch mit erfasst — kein
  Task-Restart nötig.

## Präsentation halten (empfohlener Weg: HTML)

1. Folien als HTML exportieren (siehe nächster Abschnitt) — eine
   `.html`-Datei, in jedem Browser lauffähig, **inklusive Speaker
   Notes**.
2. HTML-Datei im Browser öffnen.
3. Steuerung im Browser:

| Taste | Wirkung |
|---|---|
| `f` | Fullscreen-Modus |
| `p` | **Presenter Mode** — Notizen + nächste Folie in extra Fenster |
| `→` / `Space` | Nächste Folie |
| `←` | Vorherige Folie |
| `b` | Bildschirm schwarz |
| `w` | Bildschirm weiß |
| `Esc` | Fullscreen verlassen |

**Empfehlung für den Vortrag:** Browser im Fullscreen (`f`) für die
Projektion, parallel ein zweites Browser-Fenster im Presenter Mode
(`p`) auf dem Notebook-Display — dort siehst du Notizen und die
nächste Folie.

## Export

In VS Code: `Ctrl+Shift+P` → **„Marp: Export slide deck…"** → Format wählen.

Per Marp-CLI:

| Format | Befehl | Hinweise |
|---|---|---|
| HTML (empfohlen) | `marp folien.md -o folien.html` | Self-contained, Presenter Mode inklusive. Mit Bildern: `--allow-local-files` ergänzen. |
| PDF | `marp folien.md -o folien.pdf --allow-local-files` | Statisch, keine Notizen. |
| PPTX | `marp folien.md -o folien.pptx --allow-local-files` | PowerPoint-kompatibel; Theme wird als Bild gerendert (kein editierbares Layout). |

`--allow-local-files` wird gebraucht, wenn das Deck eigene Bilder
referenziert (`images/...`). Der Theme-Hintergrund ist bereits als
base64 in der CSS und braucht das Flag **nicht**.

## Theme weitergeben

**An Kolleg:innen, die das ganze Setup übernehmen wollen:** das komplette
Repo klonen — danach kann der Empfänger genauso wie in
[Schnellstart](#schnellstart) `bin/init-marp-workspace.sh` für neue
Workspaces nutzen.

**An Empfänger, die nur das Theme brauchen** (z. B. Studierende, die
nur einmalig ein Deck rendern wollen) — eine einzige Datei reicht:

```
themes/hs-ansbach-gruen.css   ← komplettes Theme (Hintergrund inline)
```

Empfänger packt die CSS neben sein `.md`-Deck und ergänzt im Frontmatter
`theme:` mit Pfad-Referenz, oder registriert die CSS in seinen eigenen
VS-Code-Settings. `images/` und `themes/hintergrund_hs_ansbach_gruen.png`
werden nicht gebraucht — das PNG ist bereits base64-inline in der CSS.

## Troubleshooting

| Problem | Ursache / Lösung |
|---|---|
| **Preview zeigt nicht das HS-Ansbach-Layout** | Theme liegt aus Extension-Sicht nicht im Workspace. Symlink `themes` prüfen: `ls -la themes` muss `themes -> /pfad/.../Presentation_Template_Marp/themes` zeigen. Falls fehlend: `bin/init-marp-workspace.sh .` aus dem Workspace heraus aufrufen. |
| **„theme not recognized"-Warning** | VS Code hat `.vscode/settings.json` noch nicht neu eingelesen. `Ctrl+Shift+P` → „Developer: Reload Window". |
| **Preview geht, Watch-Task baut aber nichts** | `.marprc.yml` im Workspace-Root fehlt oder zeigt nicht auf `./themes`. Datei prüfen oder vom Init-Skript neu anlegen lassen. |
| **Auto-Build greift nicht beim Speichern** | Watch-Task wurde noch nicht gestartet. Beim ersten Öffnen des Workspaces fragt VS Code „Allow automatic tasks in folder" — einmal **Allow**. Notfalls: `Ctrl+Shift+P` → *Tasks: Run Task* → *Marp: HTML watch …* |
| Footer **wird nicht angezeigt** | Im Frontmatter fehlt `footer:` — Marp emittiert ohne Direktive kein `<footer>`-Element, das Pseudo-Element greift dann nicht. Beliebigen Wert setzen, z.B. `footer: " "`. |
| Hintergrund **fehlt in PDF/PPTX-Export** | Sollte nicht passieren (base64-inline). Falls doch: prüfen, ob die CSS-Datei beim Export geladen wurde. |
| Eigene Bilder **fehlen im Export** | Marp-CLI mit `--allow-local-files` aufrufen. |
| Dozent **falsch** | In [`themes/hs-ansbach-gruen.css`](themes/hs-ansbach-gruen.css) die CSS-Variable `--lecturer-name` ändern. |
| Vorlesungstitel **falsch** | Im YAML-Frontmatter der jeweiligen `.md` das `footer:`-Feld ändern. |

## Contribution

Pull Requests sind willkommen. Wenn du eigene **Layouts**, **Inline-Klassen**
oder andere praktische **Funktionen** ergänzt, pushe sie gerne zurück —
so können alle anderen Nutzer:innen davon profitieren.

**Vorschlag für den Workflow:**

1. Feature-Branch anlegen: `git checkout -b feature/<kurz-beschreibung>`
2. Änderungen am Theme (`themes/hs-ansbach-gruen.css`) **und** ein Beispiel
   in [`Slides/template.md`](Slides/template.md) ergänzen (damit das neue Feature für
   andere sichtbar und nachvollziehbar ist).
3. README-Tabellen aktualisieren — neue Klasse oder Folien-Funktion
   einreihen, sodass die Übersicht vollständig bleibt.
4. Pull Request öffnen, kurz beschreiben *was* das Feature tut und
   *wofür* es nützlich ist.

**Ideen für sinnvolle Erweiterungen** (unverbindlich):

- weitere Split-Verhältnisse (z.B. `split-20` / `split-70`)
- Klassen für Hervorhebungs-Boxen (Info, Warnung, Beispiel)
- Theme-Variante mit anderem Farbschema oder Header-Bild
- Snippet-Sammlung für VS Code (häufig genutzte Folien-Skelette)
