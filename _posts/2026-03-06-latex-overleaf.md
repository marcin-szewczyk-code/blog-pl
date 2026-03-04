---
title: "LaTeX: Overleaf – praca zespołowa i submission artykułu"
description: "Praca wieloautorska w Overleaf, synchronizacja projektu (Dropbox, GitHub) oraz przygotowanie submission artykułu do czasopisma."
date: 2026-03-06 07:00:00 +0100
categories: [LaTeX]
tags: [latex, overleaf, workflow]
---

[Overleaf](https://www.overleaf.com/) (Online LaTeX Editor) jest środowiskiem LaTeX działającym w modelu SaaS (Software as a Service, oprogramowanie jako usługa).

Działa w przeglądarce, a kompilacja dokumentu wykonywana jest po stronie serwera. Zapewnia to niezależną od komputera użytkownika wersję kompilatora i pakietów, co przy pracy wieloautorskiej eliminuje problemy typu „u mnie się nie kompiluje”. W przeciwieństwie do lokalnego workflow nie wymaga konfiguracji narzędzi – środowisko jest gotowe do użycia.

> Książkę *[Metody analityczne w obliczeniach procesów łączeniowych w systemie elektroenergetycznym](https://www.sklep.pw.edu.pl/produkty/metody-analityczne-w-obliczeniach-procesow-laczeniowych-w-systemie-elektroenergetycznym)* napisałem w [TeXstudio](https://www.texstudio.org/) – razem ze składem tekstu i opracowaniem graficznym. W jednym z poprzednich wpisów opisałem konfigurację lokalnego środowiska LaTeX w [VS Code](https://code.visualstudio.com/).

Overleaf jest na tyle prosty, że w praktyce wystarczy wiedzieć, że taki system istnieje i poznać kilka funkcji. Po zalogowaniu wystarczy rozejrzeć się w interfejsie.

Największą zaletą Overleaf jest praca zespołowa – u mnie głównie przy tworzeniu artykułów.

W tym wpisie pokazuję podstawowe funkcje Overleaf oraz przygotowanie submission artykułu do czasopisma.

![Panel projektów Overleaf](/assets/posts/latex-overleaf/overleaf-1.png)
***Rys. 1.** Panel główny Overleaf – lista projektów użytkownika.*

---

## Dostęp do Overleaf

Overleaf jest usługą płatną. Wiele uczelni zapewnia jednak dostęp instytucjonalny. Dostęp do Overleaf można też uzyskać np. w ramach członkostwa w IEEE. Ciekawym sposobem dostępu do Overleaf jest też praca w projekcie, w którym inni uczestnicy mają wykupioną licencję.

Dla porównania lokalne edytory [VS Code](https://code.visualstudio.com/) i [TeXstudio](https://www.texstudio.org/) są projektami open source.

---

## Praca z projektem

### Interfejs

Interfejs jest intuicyjny:

-   po lewej – drzewo plików projektu,
-   w centrum – kod źródłowy LaTeX,
-   po prawej – podgląd PDF.

![Edytor Overleaf](/assets/posts/latex-overleaf/overleaf-2.png)
***Rys. 2.** Edytor Overleaf – kod źródłowy LaTeX oraz podgląd skompilowanego dokumentu PDF.*

### Nowy projekt

Nowy projekt można utworzyć z poziomu panelu „New project”:

-   utworzyć dokument z użyciem szablonu (template’u) dostarczanego przez wydawcę,
-   wgrać lub wpisać własny projekt,
-   rozpocząć od minimalnego dokumentu.

Przykładowy minimalny dokument:

``` latex
\documentclass{article}
\begin{document}
Hello World
\end{document}
```

Templaty można wybierać tutaj: [https://www.overleaf.com/latex/templates](https://www.overleaf.com/latex/templates)

### Udostępnianie projektu

Projekt udostępnia się współautorom przez opcję „Share”, definiując poziom dostępu:

-   **Can edit** – pełna edycja,
-   **Can view** – podgląd bez możliwości zmian.

Overleaf umożliwia też śledzenie historii zmian oraz komentowanie i oznaczanie fragmentów tekstu.

### Najważniejsze funkcje

Warto rozpoznać sposób wykorzystania najważniejszych funkcji:

-   kompilacja jest automatyczna po zmianach w dokumencie (można ją wymuszać przez Ctrl+S),
-   dostępny jest też przycisk **Recompile**, po rozwinięciu dostępna jest też opcja „From scratch”,
-   dostępne są logi kompilacji i błędów,
-   jest dwukierunkowa synchronizacja (SyncTeX) między kodem a PDF.

### Integracja z zewnętrznymi usługami

Przydatna jest też integracja z zewnętrznymi usługami – wykonuje się ją w ustawieniach konta (Account → Account settings → Project synchronisation).

Przykładowo projekt można zsynchronizować z Dropbox. Wówczas zapisywany jest lokalnie w katalogu `Apps/Overleaf`, który można udostępniać innym uczestnikom projektu.

To pozwala mieć lokalną kopię projektu równolegle z wersją chmurową.

Można też synchronizować projekty z GitHubem i innymi serwisami.

---

## Submission artykułu

Overleaf umożliwia przygotowanie pakietu submission bezpośrednio z poziomu projektu – opcja **Submit to**.

![Wysyłka artykułu do czasopisma](/assets/posts/latex-overleaf/overleaf-3.png)
***Rys. 3.** Okno przygotowania submission artykułu do czasopisma Scientific Reports.*

Dostępne opcje obejmują:

-   **Download project ZIP with submission files** (w tym plik .bbl),
-   **Download PDF file of your article**,
-   integrację z wybranymi czasopismami (np. Scientific Reports).

Pakiet ZIP zawiera komplet plików wymaganych przez system redakcyjny czasopisma.

---

## Podsumowanie

Overleaf dobrze nadaje się do pracy nad artykułami tworzonymi na bazie template’ów udostępnianych przez wydawców.

Szczególnie dobrze sprawdza się w pracy zespołowej, także z osobami, które nie są mistrzami LaTeXa.

Osobiście do pisania książki wybrałbym VS Code lub TeXstudio, natomiast do artykułów bardzo wygodny jest Overleaf.
