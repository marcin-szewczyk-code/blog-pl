Tytuł wpisu w przyszłości: Jak generuję miniatury PDF do bloga (Poppler + ImageMagick)


==========================
PDF → PNG preview pipeline
==========================

Cel. Wygenerowanie zoptymalizowanego podglądu pierwszej strony PDF do publikacji webowej:
- stała szerokość: 620 px
- biała ramka (efekt „kartki”)
- cienki zewnętrzny obrys
- miękki cień
- kompresja pod web

Krok 0 - Instalacja pdftoppm (Poppler) w MSYS2 MinGM

1 - pdftoppm jest częścią pakietu Poppler — biblioteki do renderowania PDF opartej na silniku z Xpdf.

Instalacja: pacman -S mingw-w64-x86_64-poppler

Sprawdzenie: pdftoppm -v

2 - Imagemagick

Instalacja: pacman ...

Sprawdzenie: ...

Krok 1 — PDF → surowy PNG (wysoka jakość)

pdftoppm -png -r 300 -f 1 -singlefile hello-practical-en.pdf hello-practical-en-raw

Efekt: hello-practical-en-raw.png

To jest wersja „technicznie czysta”, bez przetwarzania wizualnego.

Krok 2 — stylizacja webowa (ImageMagick)

magick hello-practical-en-raw.png \
  -resize 620x \
  -bordercolor white -border 12 \
  -bordercolor "#e0e0e0" -border 1 \
  -alpha set \
  \( +clone -background black -shadow 45x4+0+3 \) \
  +swap -background none -compose over -composite \
  -strip -quality 92 \
  hello-practical-en-preview.png

Dlaczego tak, a nie inaczej?
- 300 DPI przy konwersji → tekst pozostaje ostry
- resize dopiero w ImageMagick → kontrola końcowej szerokości
- biała ramka przed szarą → szara linia jest zewnętrznym obrysem
- cień generowany po obrysie → wygląda jak jeden obiekt UI

Podsumowanie:

- PL:

pdftoppm -png -r 300 -f 1 -singlefile hello-practical-pl.pdf hello-practical-pl-raw

magick hello-practical-pl-raw.png \
  -resize 620x \
  -bordercolor white -border 12 \
  -bordercolor "#e0e0e0" -border 1 \
  -alpha set \
  \( +clone -background black -shadow 45x4+0+3 \) \
  +swap -background none -compose over -composite \
  -strip -quality 92 \
  hello-practical-pl-preview.png

- EN:

pdftoppm -png -r 300 -f 1 -singlefile hello-practical-en.pdf hello-practical-en-raw

magick hello-practical-en-raw.png \
  -resize 620x \
  -bordercolor white -border 12 \
  -bordercolor "#e0e0e0" -border 1 \
  -alpha set \
  \( +clone -background black -shadow 45x4+0+3 \) \
  +swap -background none -compose over -composite \
  -strip -quality 92 \
  hello-practical-en-preview.png
