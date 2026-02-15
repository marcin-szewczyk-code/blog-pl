---
title: "Blog Jekyll (3/6): Konfiguracja bloga w Jekyllu – pliki YAML, HTML i CSS"
date: 2026-02-08 07:00:00 +0100
categories: [Blog]
tags: [blog, jekyll, setup]
---

Kolejny krok budowy bloga to konfiguracja ustawień Jekylla. W Jekyllu większość konfiguracji to edycja plików YAML, a w niektórych przypadkach także HTML i CSS.

## Podstawowa konfiguracja Jekylla (_config.yml)

Podstawowa konfiguracja jest w pliku `_config.yml`:

```yaml
tagline: Notatki i zapiski.       # podtytuł bloga (wyświetlany w nagłówku)
description: >-                   # opis bloga dla SEO i kanału Atom/RSS
    Notatki o programowaniu, matematyce, symulacjach i budowie bloga w Jekyllu.
baseurl: ""                       # podkatalog, w którym działa blog
url: "https://marcin-szewczyk-code.github.io" # główny adres strony
avatar: /assets/img/avatar.jpeg   # ścieżka do avatara autora
theme: jekyll-theme-chirpy        # używany motyw Jekylla
lang: pl                          # język bloga
timezone: "Europe/Warsaw"         # strefa czasowa (daty wpisów)
github:
  username: marcin-szewczyk-code  # nazwa użytkownika GitHub
social:
  name: Marcin Szewczyk           # imię i nazwisko autora
  email:                          # email (opcjonalny, może być pusty)
  github: marcin-szewczyk-code    # profil GitHub
  linkedin: marcin-szewczyk       # profil LinkedIn
  links:
    # pierwszy link traktowany jest jako główny (copyright)
    - https://marcinszewczyk.net/                  # strona osobista
    - https://www.linkedin.com/in/marcin-szewczyk/ # LinkedIn
    - https://github.com/marcin-szewczyk-code      # GitHub
    - https://orcid.org/0000-0003-3699-5559        # ORCID
    - https://www.ee.pw.edu.pl/~szewczyk/          # strona akademicka
```

Zmiana pliku `_config.yml` wymaga zatrzymania (`Ctrl-C`) i restartu serwera Jekylla:
 
```bash
Ctrl-C
bundle exec jekyll serve
```

## Grafiki

### Avatar

Avatar definiuje się w pliku `_config.yml`:

```yml
avatar: /assets/img/avatar_tatry_512.jpeg
```

Plik graficzny powinien być kwadratowy, najlepiej `512x512` px, zoptymalizowany wagowo (kompresja JPEG ~80–85%).

Do przycięcia i skalowania można użyć **ImageMagick** (MSYS2 / MinGW, opisuję w osobnym wpisie):

**zdjęcie JPG:**

```bash
magick input.jpg -gravity center -crop 1:1 -resize 512x512 -quality 82 output.jpg
```
**grafika PNG:**

```bash
magick input.png -gravity center -crop 1:1 -resize 512x512 output.png
```

Opcja ``-gravity center`` zapewnia centralne kadrowanie przed zmianą rozmiaru.

### Favicons

Favicons można wygenerować np. w serwisie: [https://realfavicongenerator.net/](https://realfavicongenerator.net/).

Po wygenerowaniu pliki należy wgrać do katalogu:

```bash
/assets/img/favicons
```

Przykładowa struktura:

```text
assets/
└── img/
    └── favicons/
        ├── apple-touch-icon.png
        ├── favicon.ico
        ├── favicon.svg
        ├── favicon-32x32.png
        ├── web-app-manifest-192x192.png
        └── web-app-manifest-512x512.png
```

Jeśli generator tworzy plik `favicon-96x96.png`, należy zmienić jego nazwę na `favicon-32x32.png`, żeby była zgodna z wymaganiami motywu Chirpy.

## Dodatkowe elementy konfiguracji

### Dostosowanie motywu i struktury strony

Edycja menu po lewej stronie (Kategorie, Tagi, Archiwum, O mnie) robiona jest poprzez pliki w katalogu `_tabs`. Na przykład usunięcie pliku `_tabs/tags.md` powoduje usunięcie *Tags* z lewego menu. Można też dodawać dodatkowe elementy tego menu.

Awatar to wgranie zdjęcia do katalogu `/assets/img`, a następnie wskazanie jego ścieżki w `_config.yml`. Zdjęcie o wymiarach na przykład 512x512.

Polska wersja językowa to plik `pl.yml` w katalogu `_data/locales` i wpis `lang: pl` w `_config.yml`.

Ciekawy jest też sposób dodania pliku `_includes/head.html` i umieszczenia w nim kodu JavaScript (`.js`). Opisałem to przy okazji konfiguracji wzorów matematycznych LaTeX przy użyciu biblioteki MathJax. Podobnie w innym wpisie opisałem plik `_includes/footer.html`.

### Skrót w telefonie

Można utworzyć ikonę na ekranie telefonu (np. iPhone’a), która otwiera blog w trybie pełnoekranowym jak aplikację.

Można też zrobić ikonę na ekranie np. iPhone’a, która otwiera blog jak aplikację (warunek:strona musi działać przez **HTTPS**).

W Safari:
- wchodzę na `https://blog.marcinszewczyk.pl`
- wybieram ikonę *Share* (kwadrat ze strzałką w górę)
- wybieram „Dodaj do ekranu początkowego”

Jako ikona używana jest plik `/assets/img/favicons/apple-touch-icon.png` (zalecany rozmiar 180x180 px). Jeżeli plik nie istnieje, iOS wygeneruje ikonę automatycznie (zrzut strony).
