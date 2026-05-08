# Conference Poster Template

A0 portrait poster template with card-based layout. Reusable across
conferences — only header, content cards, and footer need to be edited.

## Files

- `Poster_Template.tex` — main TeX source
- `references.bib` — sample bibliography (replace with your own)
- `logo_placeholder.png` / `figure_placeholder.pdf` — drop your assets
  here under the same names, or update the paths inside the `.tex`

## Quick start

1. Copy this folder to your new poster project
2. Replace logo and figures with your own (same filenames or update paths)
3. Search the `.tex` for `REPLACE` / placeholder text and edit
4. Update accent colors in the palette section if you have a CI
5. Build:

   ```
   pdflatex Poster_Template
   bibtex Poster_Template
   pdflatex Poster_Template
   pdflatex Poster_Template
   ```

## Card types provided

| Macro              | Header style          | Use for                           |
|--------------------|----------------------|------------------------------------|
| `cardblock`        | blue (primary)        | Most content sections             |
| `cardblockaccent`  | teal (highlight)      | Optional: emphasised highlight    |
| `cardblockmuted`   | light grey (subtle)   | References, footnotes, supplements|

## Layout knobs

- A0 portrait; switch to A1 by changing `size=a0` to `size=a1` and
  scaling the header lengths (header band 13 cm, footer 4.5 cm,
  hardcoded `\fontsize` values) by ~0.71
- Two equal columns at `0.475\paperwidth` each
- Inner card padding: `top/bottom=8mm, left/right=10mm`
  (muted card uses smaller paddings for a footnote-like feel)

## Key idioms baked in

- `tabularx` with `Y` column type for tables that fill the card width
- `qrcode` package for code/paper QR codes (5.5 cm by default; A0 lets
  you go up to 7 cm if you want them very visible)
- `\reqtag{...}` macro for inline pill-shaped tags
- FontAwesome icons in card titles (`\faLightbulb`, `\faServer`,
  `\faProjectDiagram`, `\faCogs`, `\faBalanceScale`, `\faChartLine`,
  `\faBookOpen`, `\faEnvelope`, `\faLinkedin`, `\faOrcid`, `\faGithub`,
  `\faFilePdf`)
