---
title: "Narzędzia: Generowanie miniatur PDF do bloga (Poppler + ImageMagick)"
description: "Konwersja PDF do PNG przy użyciu Poppler (pdftoppm) oraz stylizacja obrazu w ImageMagick w celu generowania miniatur do bloga."
date: 2026-02-22 07:00:00 +0100
categories: [Narzędzia]
tags: [pdf, png, poppler, pdftoppm, imagemagick, graphics, workflow]
---

W tym wpisie opisuję dwustopniowy sposób generowania miniatur PDF publikowanych na blogu.

Celem jest uzyskanie powtarzalnego, estetycznego podglądu wybranej strony dokumentu PDF w formie grafiki PNG zoptymalizowanej pod web.

Efekt końcowy ma następujące parametry:

- stała szerokość: 620px  
- biała ramka (efekt „kartki”)
- cienki zewnętrzny obrys
- miękki cień
- kompresja dostosowana do publikacji online

Proces składa się z dwóch etapów: konwersji PDF do PNG przy użyciu pdftoppm (Poppler) oraz dalszego przetwarzania (stylizacji) obrazu w ImageMagick.

### Przykładowy efekt

Sekwencja przetwarzania: PDF → PNG (raw) → PNG (web)

Plik PDF: [`example-pl.pdf`](/assets/posts/pdf-to-web-image/example-pl.pdf)

Plik PNG (raw): [`example-pl-raw.png`](/assets/posts/pdf-to-web-image/example-pl-raw.png)

Plik PNG (web): [`example-pl-web.png`](/assets/posts/pdf-to-web-image/example-pl-web.png)

![Widok wygenerowanego obrazu](/assets/posts/pdf-to-web-image/example-pl-web.png)
***Rys. 1.** Przykładowy obraz wygenerowany z dokumentu [`example-pl.pdf`](/assets/posts/pdf-to-web-image/example-pl.pdf).*

---

## Środowisko

Środowisko pracy: **MSYS2 MinGW64**.

### Instalacja Poppler (`pdftoppm`)

Program `pdftoppm` jest częścią pakietu Poppler -- biblioteki do renderowania PDF opartej na silniku Xpdf.

Instalacja:

```bash
pacman -S mingw-w64-x86_64-poppler
```

Sprawdzenie:

```bash
pdftoppm -v
```

### Instalacja ImageMagick

Instalacja:

```bash
pacman -S mingw-w64-x86_64-imagemagick
```

Sprawdzenie:

```bash
magick -version
```

---

## Krok 1: Konwersja PDF do PNG (Poppler)

Pierwszy etap polega na konwersji wybranej (poniżej pierwszej) strony dokumentu PDF do obrazu PNG w wysokiej rozdzielczości:

```bash
pdftoppm -png -r 300 -f 1 -singlefile example.pdf example-raw
```

Powstaje plik:

```
example-raw.png
```

Parametry:

- `-r 300` -- wysoka jakość renderu  
- `-f 1` -- pierwsza strona  
- `-singlefile` -- pojedynczy plik wyjściowy  

Na tym etapie obraz jest technicznie czysty -- bez jakiejkolwiek stylizacji.

---

## Krok 2: Stylizacja PNG do wersji webowej (ImageMagick)

Drugi etap nadaje obrazowi formę gotową do publikacji:

```bash
magick example-raw.png   -resize 620x   -bordercolor white -border 12   -bordercolor "#e0e0e0" -border 1   -alpha set   \( +clone -background black -shadow 45x4+0+3 \)   +swap -background none -compose over -composite   -strip -quality 92   example-web.png
```

Powstaje:

```
example-web.png
```

---

## Uzasadnienie parametrów

- **300 DPI przy konwersji**  
  Zapewnia ostrość tekstu po późniejszym skalowaniu.

- **Resize dopiero w ImageMagick**  
  Pozwala precyzyjnie kontrolować szerokość końcową.

- **Biała ramka przed szarą obwódką**  
  Szara linia działa jako subtelny zewnętrzny obrys.

- **Cień generowany po obrysie**  
  Efekt wizualny przypomina kartkę papieru unoszącą się nad tłem.

- **`-strip -quality 92`**  
  Redukcja rozmiaru pliku przy zachowaniu jakości wizualnej.

---

## Automatyzacja (MSYS2 MinGW64)

Poniżej prosty skrypt Bash uruchamiany w środowisku MSYS2 MinGW64.

Skrypt do pobrania: [`pdf-to-web-image.sh`](/assets/posts/pdf-to-web-image/pdf-to-web-image.sh)

``` bash
#!/usr/bin/env bash
set -e

pdf="$1"
[ -n "$pdf" ] || { echo "Usage: ./pdf-to-web-image.sh example.pdf"; exit 1; }

base="$(basename "$pdf" .pdf)"

pdftoppm -png -r 300 -f 1 -singlefile "$pdf" "${base}-raw"

magick "${base}-raw.png"   -resize 620x   -bordercolor white -border 12   -bordercolor "#e0e0e0" -border 1   -alpha set   \( +clone -background black -shadow 45x4+0+3 \)   +swap -background none -compose over -composite   -strip -quality 92   "${base}-web.png"

echo "OK: ${base}-web.png"
```

Nadanie uprawnień:

``` bash
chmod +x pdf-to-web-image.sh
```

Użycie:

``` bash
./pdf-to-web-image.sh example.pdf
```

Skrypt przyjmuje plik PDF jako argument i generuje:

-   `*-raw.png`
-   `*-web.png`

---

## Podsumowanie

To proste narzędzie pozwala generować estetyczne, zoptymalizowane pod web miniatury PDF.

Umożliwia zachowanie spójności layoutu oraz automatyzację workflow publikacyjnego.
