---
title: "LaTeX: VS Code zamiast TeXstudio – konfiguracja krok po kroku"
description: "Konfiguracja LaTeX w VS Code krok po kroku: instalacja TeX Live, rozszerzenie LaTeX Workshop, ustawienie latexmk, podgląd PDF, SyncTeX oraz organizacja katalogu build i Git."
date: 2026-02-21 07:00:00 +0100
categories: [LaTeX, Tools]
tags: [latex, vscode, texstudio, overleaf, workflow, setup]
---

W [TeXstudio](https://www.texstudio.org/) napisałem oraz wykonałem skład i opracowanie graficzne książki *[Metody analityczne w obliczeniach procesów łączeniowych w systemie elektroenergetycznym](https://www.sklep.pw.edu.pl/produkty/metody-analityczne-w-obliczeniach-procesow-laczeniowych-w-systemie-elektroenergetycznym)*, wydanej przez OWPW w 2024 roku.

Tworząc ten blog, przeniosłem swój workflow z TeXstudio do [VS Code](https://code.visualstudio.com/), żeby pracować w jednym środowisku z Markdownem, HTML0-m, CSS-em, Pythonem, C++, Gitem i LaTeX-em. Tu pewnie będę opracowywał kolejne książki.

Dokument LaTeX jest plikiem tekstowym opisującym strukturę i skład przy użyciu poleceń i środowisk. Jest kompilowany do formatów wyjściowych, takich jak PDF.

W LaTeX-u można tworzyć dokumenty na kilka sposobów:

- **Overleaf** to rozwiązanie chmurowe -- wygodne przy pracy zespołowej i wysyłaniu artykułów bezpośrednio do wydawców, ale zależne od przeglądarki.
- **TeXstudio** to klasyczne, wyspecjalizowane IDE zaprojektowane wyłącznie do pracy z LaTeX-em.
- **VS Code** jest mocnym edytorem ogólnego przeznaczenia, rozszerzalnym przez rozszerzenia (extensions). Po odpowiedniej konfiguracji może pełnić rolę środowiska LaTeX i zastąpić TeXstudio, współpracując jednocześnie z GitHub.

W tym wpisie opisuję konfigurację LaTeX-a w VS Code krok po kroku.

---

## Instalacja LaTeXa

VS Code jest „tylko” edytorem. Do kompilacji potrzebny jest kompilator, w tym wypadku LaTeX-a.

Korzystam z pełnej wersji TeX Live, instalacja stąd: [https://www.tug.org/texlive/](https://www.tug.org/texlive/).

Sprawdzenie instalacji w terminalu VS Code (``Ctrl + ` ``):

``` bash
pdflatex --version
latexmk --version
```

Jeśli zwraca to wersję -- LaTeX jest poprawnie zainstalowany (u mnie: TeX Live 2025).

Przy czym:
- **pdflatex** to silnik kompilujący dokument LaTeX bezpośrednio do formatu PDF
- **latexmk** to narzędzie automatyzujące kompilację, uruchamiające odpowiednie programy (np. pdflatex, biber) tyle razy, ile jest to potrzebne do poprawnego wygenerowania dokumentu.

---

## Instalacja rozszerzenia LaTeX Workshop

W VS Code:

1.  `Ctrl + Shift + X` lub ikona klocków w prawym bocznym pasku
2.  Wyszukaj: **LaTeX Workshop** (James Yu)
3.  Zainstaluj

To rozszerzenie zapewnia:
- kompilację LaTeX do PDF
- wbudowany podgląd PDF
- SyncTeX (synchronizacja między kodem źródłowym a PDF)
- obsługę bibliografii (BibTeX / biber)
- wbudowane szablony środowisk LaTeX (snippety)
- autouzupełnianie poleceń i środowisk

---

## Ustawienie skrótu do kompilacji

VS Code ma własny mechanizm budowania projektów („Run Build Task”), niezależny od rozszerzenia LaTeX Workshop.

Domyślny skrót budowania może uruchamiać ten mechanizm zamiast komendy: `LaTeX Workshop: Build LaTeX project`.

Żeby mieć pewność, że kompilacja wywołuje `LaTeX Workshop: Build LaTeX project`, warto przypisać skrót bezpośrednio do tej komendy.

Warto ustawić własny skrót:

1.  `Ctrl + K`, `Ctrl + S`

2.  Wyszukaj:\
    `LaTeX Workshop: Build LaTeX project`

3.  Ustaw np.:

        Ctrl + Alt + B

4.  Usuń skrót przypisany do:

        Run Build Task

Od tej chwili `Ctrl+Alt+B` wywołuje kompilację przez LaTeX Workshop.

---

## Ustawienie latexmk jako domyślnej metody kompilacji

Ustawiamy teraz `latexmk` jako domyślną metodę kompilacji w `LaTeX Workshop: Build LaTeX project`.

Otwórz:

    Ctrl + Shift + P
    → Preferences: Open User Settings (JSON)

Dodaj:

``` json
{
    "latex-workshop.latex.recipe.default": "latexmk",
    "latex-workshop.latex.autoBuild.run": "onSave"
}
```

Jeśli w pliku `.json` były już wcześniej inne ustawienia -- należy dodać tylko te wewnętrzne linie (z zachowaniem przecinków w JSON).

### Co to daje?

-   używa `latexmk`
-   automatycznie wykrywa bibliografię i wielokrotne przebiegi
-   kompiluje przy zapisie (`Ctrl+S`)

---

## Podgląd PDF w VS Code

W Settings ustaw:

    latex-workshop.view.pdf.viewer → tab

PDF otwiera się jako zakładka w VS Code.

Żeby ponownie otworzyć zakładkę po zamknięciu: **Ctrl + Shift + P**, następnie *LaTeX Workshop: View LaTeX PDF file*.

------------------------------------------------------------------------

## Dwukierunkowa synchronizacja (SyncTeX)

### Kod → PDF

Ctrl + Shift + P, wpisz:

    LaTeX Workshop: SyncTeX from cursor

### PDF → Kod

W podglądzie PDF:

    Ctrl + klik

Edytor przeskakuje do źródła.

---

## Osobny katalog build

Aby nie zaśmiecać katalogu projektu plikami pomocniczymi generowanymi podczas kompilacji, można ustawić osobny katalog wyjściowy.

### Jak go stworzyć

W pliku `settings.json` (Ctrl + Shift + P → `Preferences: Open User Settings (JSON)`) dodaj:

``` json
"latex-workshop.latex.outDir": "%DIR%/build"
```

Co to oznacza:
- `%DIR%` -- katalog, w którym znajduje się aktualny plik `.tex`
- `build` — podkatalog, do którego trafią pliki pomocnicze

Po kompilacji wszystkie pliki `.aux`, `.log`, `.fls`, `.synctex.gz` trafią do `build/`.

### Katalog build a Git

Katalog `build/` zawiera pliki pośrednie generowane przez `latexmk`:

-   `.aux`
-   `.log`
-   `.fls`
-   `.fdb_latexmk`
-   `.synctex.gz`

Nie są to pliki źródłowe projektu, lecz artefakty kompilacji.

Z tego powodu katalog `build/` nie powinien być wersjonowany w Git.

W pliku `.gitignore` warto dodać:

```txt
build/
```

Repozytorium będzie wówczas zawierać wyłącznie:
- pliki `.tex`
- bibliografię
- grafiki
- ewentualnie końcowy plik PDF (jeśli jest przeznaczony do publikacji)

### PDF w katalogu głównym

Jeżeli plik PDF ma być wersjonowany w repozytorium, można kompilować do
katalogu `build/`, a następnie kopiować wygenerowany PDF z `build/` do katalogu
głównego.

W katalogu projektu (obok pliku `.tex`) należy utworzyć plik `latexmkrc`
o treści:

``` perl
$out_dir = 'build';
$pdf_mode = 1;
$success_cmd = 'cp build/%R.pdf %R.pdf';
```
W systemie Windows (cmd / PowerShell) zamiast `cp` należy użyć `copy` oraz windowsowych kresek, czyli:

``` perl
$out_dir = 'build';
$pdf_mode = 1;
$success_cmd = 'copy build\\%R.pdf %R.pdf';
```
Po każdej udanej kompilacji plik PDF zostanie skopiowany z katalogu `build/` do katalogu głównego.

Repozytorium zawierać więc będzie źródła oraz kopię końcowego PDF, natomiast katalog `build/` będzie pełnił funkcję techniczną i nie będzie wersjonowany w GitHub.

---

## Efekt końcowy

Po konfiguracji:

-   `Ctrl+S` → automatyczna kompilacja, `Ctrl+Alt+B` → ręczny build
-   PDF w zakładce bocznej w VS Code
-   latexmk automatycznie wykonuje wymagane przebiegi kompilacji
-   SyncTeX działa w obie strony

Ta konfiguracja pozwala pracować w jednym środowisku VS Code z kodem, dokumentacją i repozytorium Git.

---

## Podsumowanie

Konfiguracja sprowadza się do:

1.  TeX Live -- instalacja z [https://www.tug.org/texlive/](https://www.tug.org/texlive/) (może też być np. MiKTeX)
2.  LaTeX Workshop -- instalacja rozszerzenia z Marketplace VS Code
3.  Ustawienia `latexmk` -- w `settings.json` VS Code

I to wszystko.
