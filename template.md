---
marp: true
paginate: true
footer: "Veranstaltungstitel hier eintragen"
style: |
  section {
    font-size: 24px;
    padding-top: 120px;
    padding-bottom: 80px;
    background-image: url('themes/hintergrund_hs_ansbach_grün.png');
    background-repeat: no-repeat;
    background-position: center center;
    background-size: cover;
  }
  code { font-size: 20px; }
  footer {
    left: 30px;
    bottom: 25px;
    font-size: 14px;
    color: #555;
  }
  section::before {
    content: 'Prof. Nicolas Weeger';
    position: absolute;
    left: 50%;
    bottom: 25px;
    transform: translateX(-50%);
    font-size: 14px;
    color: #555;
  }
  section::after {
    right: 30px;
    bottom: 25px;
    font-size: 14px;
    color: #555;
  }
  section.split,
  section.split-60,
  section.split-40,
  section.split-30 {
    display: grid;
    grid-template-rows: auto auto;
    gap: 0.3em 2em;
    align-content: center;
    align-items: center;
  }
  section.split    { grid-template-columns: 1fr 1fr; }
  section.split-60 { grid-template-columns: 60% 40%; }
  section.split-40 { grid-template-columns: 40% 60%; }
  section.split-30 { grid-template-columns: 30% 70%; }
  section.split    > h1,
  section.split-60 > h1,
  section.split-40 > h1,
  section.split-30 > h1 {
    grid-column: 1;
    grid-row: 1;
    align-self: end;
    margin-bottom: 0.3em;
  }
  section.split    > div:first-of-type,
  section.split-60 > div:first-of-type,
  section.split-40 > div:first-of-type,
  section.split-30 > div:first-of-type {
    grid-column: 1;
    grid-row: 2;
  }
  section.split    > div:nth-of-type(2),
  section.split-60 > div:nth-of-type(2),
  section.split-40 > div:nth-of-type(2),
  section.split-30 > div:nth-of-type(2) {
    grid-column: 2;
    grid-row: 1 / -1;
  }
  section.title {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    padding-bottom: 0;
  }
  section.title h1 { font-size: 72px; margin-bottom: 0.1em; }
  section.title h2,
  section.title h3 { font-size: 32px; color: #555; font-weight: normal; margin-top: 0; }
  section.title p  { font-size: 20px; color: #666; margin-top: 2em; }
  section.title::before,
  section.title::after,
  section.title footer { display: none; }
  .quelle {
    font-size: 16px;
    color: #555;
    font-style: italic;
    text-align: right;
    display: block;
    margin-top: 0.3em;
  }
  .center { text-align: center; }
  .center img { display: inline-block; }
---

<!--
=============================================================
HS-Ansbach Marp Template (selbständig — Style inline)
=============================================================

Wie es funktioniert:
  - Das komplette Theme-CSS steht im YAML-Frontmatter (style:).
  - Die Datei ist self-contained: kein Theme-Setup in VS Code,
    keine .vscode/settings.json, kein @import nötig.
  - Mitkopieren musst du nur den Bilder-Ordner themes/ (für den
    Hintergrund) und ggf. images/ (für eigene Inhalte).

Voraussetzung:
  - Marp-Extension (marp-team.marp-vscode) installiert.
  - themes/hintergrund_hs_ansbach_grün.png liegt NEBEN dieser
    Markdown-Datei (im hs-ansbach-weeger-Repo bereits vorhanden).

So benutzt:
  1. template.md UND themes/-Ordner in dein Projekt kopieren:
     cp template.md /pfad/zu/deinem/projekt/folien.md
     cp -r themes  /pfad/zu/deinem/projekt/
  2. Footer im Frontmatter anpassen
  3. Inhalte in den Folien unten ersetzen
  4. Bei Theme-Änderungen am zentralen CSS: das style-Block
     manuell synchronisieren (oder neu aus dem zentralen
     hs-ansbach-weeger.css kopieren).

Verfügbare Folien-Klassen (per HTML-Kommentar als erste Zeile der Folie):
  <!- - _class: title  - ->     Titelfolie (zentriert, ohne Footer/Seitenzahl)
  <!- - _class: split  - ->     Zwei Spalten 50/50
  <!- - _class: split-60 - ->   60/40
  <!- - _class: split-40 - ->   40/60
  <!- - _class: split-30 - ->   30/70

Inline-Klassen:
  .center         Block zentrieren (für QR-Codes, Logos)
  .quelle         Kleine kursive Quellenangabe, rechtsbündig

Konventionen für Split-Folien:
  - H1 (#) gehört vor die <div>-Blöcke
  - Linke Spalte:  erstes <div>...</div>
  - Rechte Spalte: zweites <div>...</div>
=============================================================
-->

<!-- _class: title -->

# Titel der Präsentation

### Untertitel oder Modulname

Prof. Nicolas Weeger · Hochschule Ansbach

---

# Standard-Folie mit Aufzählung

Einleitungstext, der die Folie kurz einordnet.

- Erster Punkt
- Zweiter Punkt mit **Hervorhebung**
- Dritter Punkt

### Zwischenüberschrift

Weiterer Text oder ein zusätzlicher Block.

---

<!-- _class: split -->

# Zwei Spalten 50/50

<div>

### Linke Spalte

- Punkt eins
- Punkt zwei
- Punkt drei

</div>

<div>

### Rechte Spalte

> Zitat oder Hervorhebung passt hier gut hin.

Weitere Inhalte rechts.

</div>

---

<!-- _class: split-60 -->

# Zwei Spalten 60/40

<div>

Linke Spalte mit mehr Platz für Text, Aufzählungen oder
längere Erklärungen.

- Punkt A
- Punkt B

</div>

<div class="center">

![w:200](images/Logo_HS_Ansbach.png)
**Beispielbild rechts**

</div>

---

<!-- _class: split-40 -->

# Zwei Spalten 40/60

<div>

Kurzer Erklärungstext links, größerer Inhalt rechts
(z. B. Diagramm, Tabelle, Code-Beispiel).

</div>

<div class="center">

![w:400](images/Logo_HS_Ansbach.png)
<span class="quelle">*Quelle: HS Ansbach*</span>

</div>

---

<!-- _class: split-30 -->

# Zwei Spalten 30/70

<div>

Schmale linke Spalte für Schlagworte oder ein kleines Bild.

</div>

<div>

> "Hier passt ein längeres Zitat oder ein größerer Textblock
> sehr gut hinein, ohne dass es links zu eng wird."

— *Quelle*

</div>

---

# Code-Beispiel

```python
def calculate_annual_return(principal: float, monthly_rate: float) -> float:
    """Berechnet die jährliche Rendite bei monatlicher Verzinsung."""
    return principal * (1 + monthly_rate) ** 12
```

Erläuterung unter dem Code-Block. Inline-Code wie `variable_name`
wird ebenfalls in Monospace dargestellt.

---

# Folie mit Bild im Hintergrund (rechts)

![bg right:35% w:70%](images/Logo_HS_Ansbach.png)

Text links, Bild rechts. Über die Marp-Kurzform `bg right:WIDTH w:SIZE`
lassen sich Bilder ohne `<div>`-Layout direkt platzieren.

- Aufzählungspunkt 1
- Aufzählungspunkt 2

---

# Tabelle

| Spalte 1 | Spalte 2 |
|---|---|
| **Feature** | Beschreibung |
| Lesbar | Code für Menschen optimiert |
| Testbar | Automatisiert prüfbar |
| Wartbar | Änderungen sind sicher |

---

# Quellenangabe-Beispiel

Inhalt der Folie mit einer wissenschaftlichen Aussage¹.

<span class="quelle">¹ Autor, A. *Titel der Arbeit.* Konferenz, Jahr. https://example.org</span>

---

<!-- _class: title -->

# Vielen Dank!

### Fragen?

✉ nicolas.weeger@hs-ansbach.de · 🏢 Raum 50.1.2
