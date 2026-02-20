---
title: "Blog Jekyll: Konfiguracja bloga w Jekyllu – pliki YAML, HTML i CSS"
description: "Konfiguracja bloga Jekyll z motywem Chirpy: edycja _config.yml, ustawienia YAML, avatar i favicons, modyfikacje plików HTML/CSS oraz podstawowe dostosowanie struktury strony."
date: 2026-02-08 07:00:00 +0100
categories: [Blog Jekyll]
tags: [blog, jekyll, setup]
---

Kolejny krok budowy bloga to konfiguracja ustawień Jekylla i motywu Chirpy. Podstawowa konfiguracja to edycja plików YAML. Dalsze konfiguracje można przeprowadzić przez zmiany w plikach HTML motywu oraz dodanie własnych stylów CSS.

## Podstawowa konfiguracja: plik _config.yml

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

Zmiana pliku `_config.yml` wymaga zatrzymania (`Ctrl-C`) i ponownego uruchomienia serwera Jekylla:
 
```bash
Ctrl-C
bundle exec jekyll serve
```

## Dostosowanie motywu przez zmianę HTML i CSS

### Modyfikacja plików HTML

Istotne są zwłaszcza pliki motywu `_includes/*.html`.

Jekyll nadpisuje pliki motywu ich odpowiednikami o tej samej nazwie i ścieżce w projekcie.

Jeśli korzystasz z wersji gem-based Chirpy, pliki `_includes/*.html` pochodzą z motywu i nie są one widoczne w repozytorium.

Można je nadpisać, a następnie zmodyfikować, postępując w następujący sposób:

1.  Należy otworzyć repozytorium motywu (jekyll-theme-chirpy).
2.  Skopiować plik z motywu, który chcemy modyfikować, np.: `_includes/head.html`, `_includes/footer.html`, `_includes/topbar.html`, `_includes/sidebar.html`.
3.  Umieścić go w swoim projekcie, w katalogu `_includes/`
4.  Wprowadzić modyfikacje, uruchomić ponownie jekyll lub zrobić commit i push do gita

### W jaki sposób skopiować pliki motywu

Pliki `_includes/*.html` można skopiować bezpośrednio z katalogu gema motywu.

Najpierw sprawdzenie ścieżki do gema:

```bash
bundle show jekyll-theme-chirpy
```

Następnie skopiowanie wybranych plików:

```bash
copy "E:\Ruby34-x64\lib\ruby\gems\3.4.0\gems\jekyll-theme-chirpy-7.4.1\_includes\head.html" "_includes\head.html"
copy "E:\Ruby34-x64\lib\ruby\gems\3.4.0\gems\jekyll-theme-chirpy-7.4.1\_includes\footer.html" "_includes\footer.html"
copy "E:\Ruby34-x64\lib\ruby\gems\3.4.0\gems\jekyll-theme-chirpy-7.4.1\_includes\topbar.html" "_includes\topbar.html"
copy "E:\Ruby34-x64\lib\ruby\gems\3.4.0\gems\jekyll-theme-chirpy-7.4.1\_includes\sidebar.html" "_includes\sidebar.html"
```

Od tego momentu lokalne wersje plików nadpisują wersje z gema i można je modyfikować.

Opiszę to poniżej na moich przykładach, zaczynając od modyfikacji pliku `_includes/head.html`, która umożliwia nadpisanie istniejącego lub wprowadzenie własnego stylu CSS.

### Modyfikacja stylu CSS

Wygląd bloga określany stylami CSS można modyfikować przez dodanie własnego pliku CSS (np. assets/css/custom.css). Następnie należy załadować go w `_includes/head.html` po CSS motywu, aby nadpisać jego style.

W pliku:

``` text
_includes/head.html
```

należy znaleźć sekcję:

``` html
<!-- Theme style -->
<link rel="stylesheet" href="{{ '/assets/css/:THEME.css' | replace: ':THEME', site.theme | relative_url }}">
```

Bezpośrednio pod nią dodać:

``` html
<!-- Custom overrides -->
<link rel="stylesheet" href="{{ '/assets/css/custom.css' | relative_url }}">
```

Ważne: styl musi być ładowany **po** CSS motywu, aby nadpisania działały.

## Moje zmiany HTML i CSS

W kolejnych wpisach opisuję zmiany zastosowane w tym blogu:

1. W pliku `head.html` dodaję:
- Linię `<link rel="stylesheet" href="{{ '/assets/css/custom.css' | relative_url }}">`, która włącza plik `/assets/css/custom.css` z moimi stylami. Opisałem to przy okazji dostosowania przypiętego postu i sidebaru.
- JavaScript (`.js`) realizujący funkcję bibliteki MathJax do renderowania wzorów matematycznych przy pomocy składni LaTeX.
2. W pliku stopki `_includes/footer.html`
- Edycja stopki z linkami do Google Analitics i licencji -- opisałem to przy okazji konfiguracji Google Analytics.
3. W pliku nagłówka `_includes/topbar.html`
- Dodanie linku do strony Subskrybuj RSS -- opisałem to przy okazji konfiguracji RSS
4. W pliku panelu bocznego `_includes/sidebar.html`
- Dodanie przełącznika light/dark, PL \| EN oraz RSS -- opisałem to w osobnym wpisie
- Dodanie elementów wokół ikon z linkami w dole panelu bocznego -- opisałem to w osobnym wpisie

## Zmiany w stylu CSS – plik assets/css/custom.css

Najważniejsze zmiany jakie wprowadziłem w motywie Chirpy przez plik `assets/css/custom.css`:

- Wygląd przypiętego postu (pinned post) -- opisałem to w osobnym wpisie
- Wygląd elementów wokół ikon z linkami w dole panelu bocznego -- opisałem to w osobnym wpisie

## Inne zmiany

Edycja menu w panelu bocznym `_includes/sidebar.html` (Kategorie, Tagi, Archiwum, O mnie) robiona jest poprzez pliki w katalogu `_tabs`. Na przykład usunięcie pliku `_tabs/tags.md` powoduje usunięcie pozycji *Tags* z panelu bocznego. Można też dodawać dodatkowe elementy tego menu.

Awatar to wgranie zdjęcia do katalogu `/assets/img`, a następnie wskazanie jego ścieżki w `_config.yml`. Zalecane wymiary zdjęcia to np. 512×512 px.

Polska wersja językowa to plik `pl.yml` w katalogu `_data/locales` i wpis `lang: pl` w `_config.yml`.

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

Favicons można wygenerować np. w serwisie **RealFaviconGenerator**: [https://realfavicongenerator.net/](https://realfavicongenerator.net/).

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

### Skrót w telefonie

Można utworzyć ikonę na ekranie telefonu (np. iPhone’a), która otwiera blog w trybie pełnoekranowym jak aplikację (warunek: strona musi działać przez **HTTPS**).

W Safari:
- wchodzę na `https://blog.marcinszewczyk.pl`
- wybieram ikonę *Share* (kwadrat ze strzałką w górę)
- wybieram „Dodaj do ekranu początkowego”

Jako ikona używany jest plik `/assets/img/favicons/apple-touch-icon.png` (zalecany rozmiar 180x180 px). Jeżeli plik nie istnieje, iOS wygeneruje ikonę automatycznie (zrzut strony).

## Podsumowanie

Na początku może to wyglądać na skomplikowane. Wystarczy jednak kilka drobnych zmian i wszystko działa. Po konfiguracji jest tak, jak trzeba.