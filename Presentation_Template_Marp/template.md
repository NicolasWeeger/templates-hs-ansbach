---
marp: true
theme: hs-ansbach-grün
paginate: true
footer: "Vorlesungstitel"
---

<!-- _class: title -->

# HS Ansbach MARP Theme

### Beispieldeck mit allen Theme-Funktionen

Prof. Dr. Mustermann · Hochschule Ansbach

<!-- Titelfolie: zentriert, ohne Footer und ohne Seitenzahl.
     Aktiviert über `<!-- _class: title -->` als erste Zeile der Folie. -->

[//]: # (Diese Zeile ist ein "Markdown-only"-Kommentar: nur im .md-Source sichtbar, weder auf der Folie noch im Presenter-Mode. Beispiel weiter unten auf der Kommentar-Folie.)


---

<!--- _class: compact -->

# Gliederung

1. [Konfiguration & Theme-Status](#3)
2. [Markdown-Grundlagen — Listen & Hervorhebung](#4)
3. [Markdown-Grundlagen — Zitate & Code](#5)
4. [Tabelle](#6)
5. [Bilder](#7)
6. [Split 50/50](#8)
7. [Split 60/40](#9)
8. [Split 40/60 + `.below-title`-Modifier](#10)
9. [Split 30/70](#11)
10. [Inline-Klassen `.center` und `.source`](#12)
11. [Kommentare & Speaker Notes](#13)
12. [Schriftgrößen — `.compact` und `.dense`](#14)

<!-- Die Anker `#N` springen im HTML-Export (Bespoke) direkt zur Folie N.
     In der VS-Code-Preview funktionieren sie nicht zuverlässig. -->

---

# Konfiguration & Theme-Status

Wenn diese Folie:

- den grünen HS-Ansbach-Hintergrund zeigt,
- "Prof. Dr. Mustermann" unten in der Mitte hat (CSS-Variable
  `--lecturer-name` in [`themes/hs-ansbach-grün.css`](themes/hs-ansbach-grün.css)),
- die Seitenzahl unten rechts hat,
- den Footer "Vorlesungstitel" unten links hat (CSS-Variable
  `--course-title`),

→ greift das Theme korrekt. Ändere die beiden Variablen ganz oben in
der CSS-Datei, dann gilt es automatisch für alle Decks.

<!-- Diese HTML-Kommentare auf einer Folie sind Speaker Notes —
     im Presenter Mode (HTML-Export, Taste `p`) sichtbar, auf der
     Folie selbst nicht. -->

---

# Markdown-Grundlagen — Listen & Hervorhebung

**Fett** mit `**doppelten Sternen**`, *kursiv* mit `*einfachen*`,
`inline-code` mit Backticks.

Aufzählungen:

- Erster Punkt
- Zweiter Punkt mit **Hervorhebung** und `code`
- Dritter Punkt

Nummerierte Liste:

1. Schritt eins
2. Schritt zwei
3. Schritt drei

---

# Markdown-Grundlagen — Zitate & Code

Zitate:

> Zitate mit `>` als Präfix. Eignen sich gut für Hervorhebungen
> oder zur Kennzeichnung wörtlicher Übernahmen.

Code-Block:

```python
def calculate_discount(price: float, percent: float) -> float:
    """Calculate discount amount using meaningful names."""
    return price * percent / 100
```

Code-Blöcke werden in Monospace mit kleinerer Schrift gerendert
(font-size: 20px aus dem Theme). Sprachen z.B.: `python`, `bash`,
`javascript`, `c++`, `yaml`, `json`.

---

# Tabelle

| Funktion | Wirkung | Beispiel |
|---|---|---|
| `<!-- _class: title -->` | Titelfolie | Folie 1 |
| `<!-- _class: split -->` | 2 Spalten 50/50 | Folie 8 |
| `<!-- _class: split-60 -->` | 2 Spalten 60/40 | Folie 9 |
| `.below-title` | Spalten auf gleicher Höhe | Folie 10 |
| `.center` | Block zentrieren | Folie 12 |
| `.source` | Quellenangabe | Folie 12 |

Spalten links-/zentriert-/rechtsbündig via `|:--|:-:|--:|` in der
zweiten Tabellenzeile.

---

# Bilder

![w:200](images/Logo_HS_Ansbach.png)

Bilder mit Größenangabe: `![w:200](pfad)` für Breite in Pixel,
`![h:150]` für Höhe, beides kombinierbar.

Als Hintergrund rechts (überlappt den restlichen Inhalt nicht):

![bg right:35% w:70%](images/Logo_HS_Ansbach.png)

Aufruf: `![bg right:35% w:70%](pfad)` — 35% der Folienbreite,
Bild auf 70% dieser Breite skaliert.

---

<!-- _class: split -->

# Split-Layout 50/50 — `_class: split`

<div>

### Linke Spalte

- Punkt eins
- Punkt zwei
- Punkt drei

</div>

<div>

[//]: # (Eine Raute # ohne Text dahinter verschiebt die Spalte nach unten, Das macht bei Splits-Layouts Sinn, damit die beiden Inhalte der Spalten auf zentriert oder auf gleicher Höhe liegen)
#  
#
#
#

### Rechte Spalte

> Vertikal über die ganze Folienhöhe zentriert, unabhängig vom
> Titel auf der linken Seite.

</div>

---

<!-- _class: split-60 -->

# Split 60/40 — `_class: split-60`

<div>

Mehr Platz links für Erklärtext oder längere Aufzählungen.

- Punkt A
- Punkt B
- Punkt C

</div>

<div class="center">

![w:180](images/Logo_HS_Ansbach.png)

</div>

---

<!-- _class: split-40 -->

# Split 40/60 + `.below-title`

<div>

Kompakter Text links. Ohne `.below-title` wäre die rechte Spalte
über die **ganze Folienhöhe** vertikal zentriert (würde also höher
sitzen als dieser Text hier).

Mit `<div class="below-title">` startet die rechte Spalte erst
**unter** dem Titel — beide Textblöcke auf gleicher Höhe.

</div>

<div class="below-title">

```python
def greet(name: str) -> str:
    return f"Hello, {name}!"
```

Code in der rechten Spalte, jetzt auf Augenhöhe mit dem linken Text.

</div>

---

<!-- _class: split-30 -->

# Split 30/70 — `_class: split-30`

<div>

Schmale linke Spalte für Schlagworte oder kleine Bilder.

</div>

<div>

> „Ein längeres Zitat oder ein größerer Textblock passt sehr gut
> in die breite rechte Spalte, ohne dass die linke Spalte zu eng
> wirkt."

— *Quellenangabe*

</div>

---

# Inline-Klassen: `.center` und `.source`

<div class="center">

![w:160](images/Logo_HS_Ansbach.png)

**Zentriert via `.center`** — gut für QR-Codes, Logos, kleine Bilder.

</div>

Aussage mit wissenschaftlicher Referenz¹.

<span class="source">¹ Autor, A. *Titel der Arbeit.* Konferenz, Jahr. https://example.org</span>

<!-- .source: kleine, kursive, rechtsbündige Quellenangabe. -->

---

# Kommentare & Speaker Notes

**Zwei Kommentar-Arten** in einer `.md`-Datei:

1. **HTML-Kommentar** → wird als Speaker Note im Presenter Mode
   sichtbar, aber nicht auf der Folie:

   ```markdown
   <!-- Diese Notiz erscheint im Presenter Mode (Taste `p`),
        nicht auf der Folie selbst. -->
   ```

2. **Markdown-only-Kommentar** → nur im `.md`-Source sichtbar,
   weder auf der Folie noch im Presenter Mode (Trick mit
   ungenutzter Link-Definition):

   ```markdown
   [//]: # (Diese Notiz steht nur im Quelltext.)
   ```

---

Sichtbarkeit auf einen Blick:

| Syntax | Folie | Presenter Mode | Quelltext |
|---|:-:|:-:|:-:|
| `<!-- ... -->` | — | ✓ | ✓ |
| `[//]: # (...)` | — | — | ✓ |

<!-- Beispiel-Speaker-Note für den Vortrag:
     - Erinnerung: das Beispiel auf Folie 7 zeigen
     - Quelle nennen
     - 5 Minuten Diskussion einplanen -->

[//]: # (Beispiel-Markdown-only-Kommentar — taucht nirgends auf außer hier im Source.)

---

<!-- _class: dense -->

# Schriftgrößen — `.compact` und `.dense`

Wenn eine Folie viel Inhalt hat, kannst du die Schriftgröße per Klasse
reduzieren — kombinierbar mit jedem Layout:

| Klasse | font-size | Wann verwenden |
|---|---|---|
| _Default_ | 24 px | Normaler Inhalt |
| `.compact` | 20 px | Dichter Text, mehr Bullet-Points |
| `.dense` | 18 px | Sehr dichte Detail- oder Übersichtsfolien |

Aktivierung in der `_class:`-Direktive, kombinierbar mit Layout-Klassen
durch Space:

```markdown
<!-- _class: compact -->
<!-- _class: split compact -->
<!-- _class: split-60 dense -->
```

Diese Folie hat `_class: compact` — Schriftgröße 20 px statt 24.
Code-Blöcke und Inline-Code (`font-size: 0.83em`) skalieren proportional
mit, sodass das visuelle Verhältnis erhalten bleibt.

<!-- Hinweis: Echtes Auto-Fit (Schriftgröße misst Inhaltsmenge) ist in
     CSS nicht zuverlässig möglich. Diese manuellen Stufen sind robust
     und funktionieren in Preview, HTML-, PDF- und PPTX-Export gleich. -->

---

<!-- _class: title -->

# Vielen Dank!

### Fragen?

✉ max.mustermann@hs-ansbach.de · 🏢 Raum 10.1.23
