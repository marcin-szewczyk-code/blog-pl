---
title: "Blog Jekyll: Ikony Font Awesome – jak działają i jak je dodałem"
date: 2026-02-16 07:00:00 +0100
categories: [Blog]
tags: [jekyll, css]
---

Ikony to drobny element interfejsu, który znacząco wpływa na czytelność
i estetykę strony.\
W tym wpisie porządkuję:

-   czym są ikony w nowoczesnym webie,
-   jak działają w motywie **Chirpy**,
-   jak dodałem własne ikony do sidebaru,
-   oraz jak zautomatyzowałem ich katalogowanie przy pomocy Pythona.

------------------------------------------------------------------------

## 1. Czym dziś są „ikony" w HTML

W przeszłości ikony były małymi obrazkami (`.png`, `.gif`).\
Dziś w większości przypadków są to:

-   fonty ikonowe (np. Font Awesome),
-   wektorowe SVG,
-   rzadziej --- bitmapy.

Najpopularniejsze podejście w motywach Jekyll to **Font Awesome** ---
zestaw ikon udostępniany jako font + CSS.

Z technicznego punktu widzenia ikona to po prostu element:

``` html
<i class="fas fa-rss"></i>
```

gdzie:

-   `fas` -- styl (Font Awesome Solid),
-   `fa-rss` -- konkretna ikona.

------------------------------------------------------------------------

## Ikony w motywie Chirpy

Motyw Chirpy domyślnie korzysta z Font Awesome.\
Nie trzeba nic instalować ani konfigurować --- biblioteka jest już
załadowana w layoucie.

Wystarczy użyć odpowiedniej klasy.

Przykłady:

`<i class="fas fa-globe">`{=html}`</i>`{=html}
`<i class="fas fa-rss">`{=html}`</i>`{=html}
`<i class="far fa-copyright">`{=html}`</i>`{=html}
`<i class="fas fa-file-contract">`{=html}`</i>`{=html}

### Różnice między stylami

-   `fas` → solid (wypełnione)
-   `far` → regular (outline)
-   `fab` → brand

------------------------------------------------------------------------

## Mój przypadek: PL \| EN • RSS • License

Kod:

``` html
<div style="position: absolute; top: 0.75rem; left: 1rem; z-index: 10; font-size: 0.9rem; white-space: nowrap;">
  <i class="fas fa-globe text-muted"></i>
  <a href="https://blog.marcinszewczyk.net" class="text-muted fw-semibold ms-1">PL</a>
  <span class="text-muted" style="margin:0 0.12rem;">|</span>
  <a href="https://en.blog.marcinszewczyk.net" class="text-muted">EN</a>
  <span class="text-muted" style="margin:0 0.12rem;">•</span>
  <a class="text-muted text-decoration-none"
     href="{{ '/rss/' | relative_url }}">
    RSS <i class="fas fa-rss"></i>
  </a>
  <span class="text-muted" style="margin:0 0.12rem;">•</span>
  <a class="text-muted text-decoration-none"
     href="{{ '/legal/' | relative_url }}">
    <i class="far fa-copyright"></i>
  </a>
</div>
```

------------------------------------------------------------------------

## Automatyczne generowanie tabeli ikon (Python)

Dodałem prosty generator w Pythonie, który:

1.  czyta listę klas z pliku tekstowego,
2.  generuje tabelę w Markdownie,
3.  zapisuje gotowy plik.

### Plik wejściowy

`font-awesome-icons-names.txt`

    fas fa-globe
    fas fa-rss
    far fa-copyright
    fas fa-file-contract
    fab fa-github
    fas fa-code

### Skrypt

```python
from pathlib import Path

BASE_DIR = Path(__file__).parent

INPUT = BASE_DIR / "font-awesome-icons-names.txt"
OUTPUT = BASE_DIR / "font-awesome-icons-table.md"

icons = [
    line.strip()
    for line in INPUT.read_text(encoding="utf-8").splitlines()
    if line.strip() and not line.startswith("#")
]

with OUTPUT.open("w", encoding="utf-8") as f:
    f.write("| Ikona | Klasa | Kod |\n")
    f.write("|-------|-------|-----|\n")

    for cls in icons:
        html = f'<i class="{cls}"></i>'
        escaped = html.replace("<", "&lt;").replace(">", "&gt;")
        f.write(f"| {html} | `{cls}` | `{escaped}` |\n")
```

------------------------------------------------------------------------

## Przykładowa tabela

  Ikona                                                Klasa
  ---------------------------------------------------- --------------------
  `<i class="fas fa-globe">`{=html}`</i>`{=html}       `fas fa-globe`
  `<i class="fas fa-rss">`{=html}`</i>`{=html}         `fas fa-rss`
  `<i class="far fa-copyright">`{=html}`</i>`{=html}   `far fa-copyright`
  `<i class="fab fa-github">`{=html}`</i>`{=html}      `fab fa-github`

------------------------------------------------------------------------

## Podsumowanie

W Chirpy dodanie ikon to kwestia jednej klasy CSS. Python pozwolił mi
uporządkować ich katalog w sposób powtarzalny i technicznie czysty.
