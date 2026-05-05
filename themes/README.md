# Marp-Theme „hs-ansbach-weeger"

Marp-Theme im Corporate Design der Hochschule Ansbach: grünes
Header-Banner mit HS-Logo, einheitliche Fußzeile (Veranstaltung links,
Dozent mittig, Seitenzahl rechts), Titelfolie und mehrere
Spalten-Layouts.

## Inhalt dieses Ordners

```
hs-ansbach-weeger/
├── template.md                            ← selbständiges Beispiel-Foliendeck
├── images/
│   └── Logo_HS_Ansbach.png                ← Beispielbild (nur fürs Template)
└── themes/                                ← alles, was zum Theme gehört
    ├── README.md                          ← diese Datei
    ├── hs-ansbach-weeger.css              ← das komplette Theme-CSS (Referenz)
    └── hintergrund_hs_ansbach_grün.png    ← Theme-Asset (Pflicht, vom CSS referenziert)
```

## Wie das Theme verteilt wird (wichtig zu verstehen)

Marp-VSCode kann **kein** zentrales Theme über absolute Pfade laden
(weder in User-Settings noch in `.vscode/settings.json` mit absolutem
Pfad noch über `file://`-URLs noch über `@import`). Die Marp-Extension
akzeptiert für `markdown.marp.themes` nur:

- HTTPS-URLs, oder
- relative Pfade **innerhalb** des aktuellen Workspace-Folders.

Daher wird dieses Theme **als selbständiges Inline-Style verteilt**:
Das komplette CSS steht im YAML-Frontmatter (`style: |`) jeder
Foliendatei. Vorteil: Die `.md`-Datei ist self-contained, funktioniert
sofort in jeder VS-Code-Installation mit Marp-Extension, ohne weiteres
Setup.

Nachteil: Theme-Änderungen müssen pro Foliendatei nachgezogen werden.
Dieser Ordner ist die **Single Source of Truth** für das CSS — bei
Änderungen am Theme den `style:`-Block in den Foliendateien gegen den
Inhalt von `hs-ansbach-weeger.css` synchronisieren.

## Voraussetzung

Marp-Extension für VS Code:
[`marp-team.marp-vscode`](https://marketplace.visualstudio.com/items?itemName=marp-team.marp-vscode)

(Optional: Marp-CLI für Export nach PDF/HTML/PPTX:
`npm install -g @marp-team/marp-cli`)

## Neue Präsentation anlegen

1. **template.md** und **themes/-Ordner** in dein Projekt kopieren:

   ```bash
   cp "/pfad/zu/MarpThemes/hs-ansbach-weeger/template.md" /pfad/zu/deinem/projekt/folien.md
   cp -r "/pfad/zu/MarpThemes/hs-ansbach-weeger/themes" /pfad/zu/deinem/projekt/
   ```

   Der `themes/`-Ordner enthält das vom CSS referenzierte
   Hintergrundbild — er muss **neben** der Markdown-Datei liegen.

2. **`footer:`** im Frontmatter auf den eigenen Veranstaltungstitel ändern.
3. **Inhalte** in den Folien ersetzen.
4. **Live-Preview** in VS Code: `Ctrl+Shift+V` (Preview im Editor)
   oder `Ctrl+K V` (Preview daneben). Das Theme greift sofort, da
   im Frontmatter inline definiert.

## Verfügbare Layout-Klassen

Per HTML-Kommentar als **erste Zeile** der Folie aktivieren:

| Klasse | Wirkung |
|---|---|
| `<!-- _class: title -->` | Titelfolie: zentriert, ohne Footer und Seitenzahl |
| `<!-- _class: split -->` | Zwei Spalten 50/50 |
| `<!-- _class: split-60 -->` | 60/40 |
| `<!-- _class: split-40 -->` | 40/60 |
| `<!-- _class: split-30 -->` | 30/70 |

**Konvention für Split-Folien:**

```markdown
<!-- _class: split -->

# Folientitel

<div>

Linke Spalte (steht unter dem Titel)

</div>

<div>

Rechte Spalte (vertikal über die ganze Folienhöhe zentriert,
unabhängig vom Titel)

</div>
```

## Inline-Klassen

| Klasse | Wirkung | Beispiel |
|---|---|---|
| `.center` | Block zentrieren (für QR-Codes, Logos) | `<div class="center"> ![](qr.png) </div>` |
| `.quelle` | Kleine kursive Quellenangabe, rechtsbündig | `<span class="quelle">Quelle: …</span>` |

## Eigene Bilder

Bilder gehören in den `images/`-Ordner **deines Projekts**, nicht in
den `themes/`-Ordner. `themes/` enthält ausschließlich das vom CSS
referenzierte Hintergrund-PNG (Theme-Asset).

Im Markdown referenzieren:

```markdown
![w:300](images/mein_bild.png)
```

## PDF/HTML/PPTX exportieren

Per Marp-CLI:

```bash
marp folien.md -o folien.pdf
marp folien.md -o folien.html
marp folien.md -o folien.pptx --allow-local-files
```

Per VS Code-Extension: `Ctrl+Shift+P` → **„Marp: Export slide deck…"**

## Troubleshooting

| Problem | Ursache / Lösung |
|---|---|
| Preview zeigt **kein Hintergrundbild** | `themes/hintergrund_hs_ansbach_grün.png` fehlt neben der `.md`-Datei. |
| Hintergrund **funktioniert in Preview, aber nicht im Export** | Marp-CLI mit `--allow-local-files` aufrufen. |
| **Layout sieht anders aus als erwartet** | Der `style:`-Block im Frontmatter ist beschädigt oder unvollständig — frische Kopie aus `themes/hs-ansbach-weeger.css` einsetzen. |
| **Dozent-Name** falsch | Im `style:`-Block hartkodiert (`section::before { content: 'Prof. Nicolas Weeger'; }`). Direkt in der `.md`-Datei ändern. |

## Theme aktualisieren

`themes/hs-ansbach-weeger.css` ist die **Referenz-Version** des Themes
(reines, kommentiertes CSS). Bei Änderungen:

1. CSS hier zentral anpassen.
2. Den Inhalt in den `style:`-Block der einzelnen Foliendateien
   übertragen (manuell oder per Skript).

Tipp für Bulk-Updates: Da der `style:`-Block immer zwischen den
YAML-Markern `style: |` und `---` steht, lässt sich der Austausch
mit einem kleinen `sed`/`awk`-Skript automatisieren.
