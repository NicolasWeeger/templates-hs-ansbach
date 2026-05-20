# HS Ansbach — Marp Theme

Marp-Theme im Corporate Design der Hochschule Ansbach: grüner
Hintergrund, einheitliche Fußzeile (Vorlesungstitel links, Dozent
mittig, Seitenzahl rechts), Titelfolie und Spalten-Layouts.

Beispieldeck mit allen Funktionen → [`template.md`](template.md).

## Gliederung

- [Inhalt dieses Ordners](#inhalt-dieses-ordners)
- [Voraussetzung](#voraussetzung)
- [Schnellstart](#schnellstart)
- [Theme konfigurieren (zentrale Stelle)](#theme-konfigurieren-zentrale-stelle)
- [Folienklassen (Layout)](#folienklassen-layout)
  - [Spalten auf gleicher Höhe: `.below-title`](#spalten-auf-gleicher-höhe-below-title)
- [Inline-Klassen](#inline-klassen)
- [Markdown-Features im Überblick](#markdown-features-im-überblick)
  - [Gliederung mit Sprung-Links](#gliederung-mit-sprung-links)
- [Kommentare & Speaker Notes](#kommentare--speaker-notes)
- [Live-Preview in VS Code](#live-preview-in-vs-code)
- [Präsentation halten (empfohlener Weg: HTML)](#präsentation-halten-empfohlener-weg-html)
- [Export](#export)
- [Theme weitergeben](#theme-weitergeben)
- [Troubleshooting](#troubleshooting)
- [Contribution](#contribution)

## Inhalt dieses Ordners

```
Presentation_Template_Marp/
├── README.md                         ← diese Datei
├── template.md                       ← Beispieldeck (alle Funktionen demonstriert)
├── .vscode/settings.json             ← registriert das Theme
├── images/                           ← Beispielbilder fürs Template
│   └── Logo_HS_Ansbach.png
└── themes/
    ├── hs-ansbach-grün.css           ← Theme-CSS (Single Source)
    └── hintergrund_hs_ansbach_grün.png  ← Quell-Asset (im CSS schon base64-inline)
```

Das Hintergrund-PNG ist als `data:`-URI direkt in die CSS eingebettet —
beim Weitergeben reicht **ausschließlich `themes/hs-ansbach-grün.css`**
(die `.png` muss nicht mit kopiert werden).

## Voraussetzung

[Marp-Extension für VS Code](https://marketplace.visualstudio.com/items?itemName=marp-team.marp-vscode):
`marp-team.marp-vscode`.

Für PDF/HTML/PPTX-Export optional die [Marp-CLI](https://github.com/marp-team/marp-cli):

```bash
npm install -g @marp-team/marp-cli
```

## Schnellstart

1. Ordner klonen/kopieren in dein Projekt.
2. [`themes/hs-ansbach-grün.css`](themes/hs-ansbach-grün.css) öffnen,
   ganz oben die zwei Konfigurationszeilen anpassen (siehe nächster
   Abschnitt).
3. [`template.md`](template.md) als Ausgangspunkt für deine eigenen
   Folien duplizieren (`cp template.md vorlesung-01.md`).
4. In VS Code mit `Ctrl+Shift+V` (Preview im Editor) oder `Ctrl+K V`
   (Preview daneben) ansehen.

Die Foliendatei braucht im YAML-Frontmatter:

```yaml
---
marp: true
theme: hs-ansbach-grün
paginate: true
footer: "Vorlesungstitel"   ← egal welcher Wert, dient nur als Trigger
---
```

`footer:` muss gesetzt sein, damit Marp das Footer-Element rendert.
Der angezeigte Text kommt aus der CSS-Variable (siehe nächster Abschnitt),
nicht aus diesem Wert.

## Theme konfigurieren (zentrale Stelle)

In [`themes/hs-ansbach-grün.css`](themes/hs-ansbach-grün.css) ganz oben
im `section { ... }`-Block, im `ZENTRALE KONFIGURATION`-Abschnitt:

```css
--lecturer-name: 'Prof. Dr. Mustermann';
--course-title: 'Vorlesungstitel';
```

Beide Werte ändern → wirkt automatisch auf **alle** Foliendateien, die
`theme: hs-ansbach-grün` verwenden. Keine Änderung pro Deck nötig.

**Pro-Deck-Override** (z.B. ein einzelner Gastvortrag mit anderem
Titel): im YAML-Frontmatter der jeweiligen `.md`:

```yaml
style: |
  section { --course-title: 'Sonderfall'; }
```

## Folienklassen (Layout)

Per HTML-Kommentar als **erste Zeile** der Folie aktivieren:

| Klasse | Wirkung | Demo |
|---|---|---|
| `<!-- _class: title -->` | Titelfolie: zentriert, kein Footer, keine Seitenzahl | [template.md](template.md) Folie 1, 14 |
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

Demo: [template.md](template.md) Folie 10.

## Inline-Klassen

| Klasse | Wirkung | Beispiel |
|---|---|---|
| `.center` | Block-Inhalt zentrieren (Logos, QR-Codes) | `<div class="center">![](qr.png)</div>` |
| `.source` | Kleine kursive Quellenangabe, rechtsbündig | `<span class="source">Quelle: …</span>` |
| `.below-title` | Spalte einer Split-Folie unter dem Titel positionieren | `<div class="below-title">…</div>` |

Demo: [template.md](template.md) Folie 12 (`.center`/`.source`) und Folie 10 (`.below-title`).

## Markdown-Features im Überblick

Alle als Beispiele in [`template.md`](template.md):

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
Anker nicht zuverlässig. Demo: [template.md](template.md) Folie 2.

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

Demo: [template.md](template.md) Folie 13.

Marp behandelt jeden HTML-Kommentar, der **nicht** mit `_class:`,
`_backgroundColor:`, `_color:` o.ä. anfängt, als Speaker Note. Diese
sind im HTML-Presenter-Mode sichtbar (siehe nächster Abschnitt).

## Live-Preview in VS Code

| Shortcut | Wirkung |
|---|---|
| `Ctrl+Shift+V` | Preview im Editor öffnen |
| `Ctrl+K V` | Preview daneben (Split) |

Änderungen am Markdown und an [`themes/hs-ansbach-grün.css`](themes/hs-ansbach-grün.css)
werden live übernommen.

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

Drei Dateien reichen:

```
themes/hs-ansbach-grün.css   ← komplettes Theme (Hintergrund inline)
.vscode/settings.json        ← optional, registriert das Theme
template.md                  ← optional, als Beispieldeck
```

Empfänger ändert ggf. die beiden Variablen oben in der CSS, fertig.
`images/` und `themes/hintergrund_hs_ansbach_grün.png` werden nur als
Quell-Assets gebraucht (Logo für eigene Folien, PNG als Backup für
spätere CSS-Updates).

## Troubleshooting

| Problem | Ursache / Lösung |
|---|---|
| **„theme not recognized"-Warning** | VS Code hat `.vscode/settings.json` noch nicht neu eingelesen. `Ctrl+Shift+P` → „Developer: Reload Window". |
| Footer **wird nicht angezeigt** | Im Frontmatter fehlt `footer:` — Marp emittiert ohne Direktive kein `<footer>`-Element, das Pseudo-Element greift dann nicht. Beliebigen Wert setzen, z.B. `footer: " "`. |
| Hintergrund **fehlt in PDF/PPTX-Export** | Sollte nicht passieren (base64-inline). Falls doch: prüfen, ob die CSS-Datei beim Export geladen wurde. |
| Eigene Bilder **fehlen im Export** | Marp-CLI mit `--allow-local-files` aufrufen. |
| Dozent oder Vorlesung **falsch** | In [`themes/hs-ansbach-grün.css`](themes/hs-ansbach-grün.css) die CSS-Variablen `--lecturer-name` und `--course-title` ändern. |

## Contribution

Pull Requests sind willkommen. Wenn du eigene **Layouts**, **Inline-Klassen**
oder andere praktische **Funktionen** ergänzt, pushe sie gerne zurück —
so können alle anderen Nutzer:innen davon profitieren.

**Vorschlag für den Workflow:**

1. Feature-Branch anlegen: `git checkout -b feature/<kurz-beschreibung>`
2. Änderungen am Theme (`themes/hs-ansbach-grün.css`) **und** ein Beispiel
   in [`template.md`](template.md) ergänzen (damit das neue Feature für
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
