---
title: "Grafika: TikZ w LaTeX – workflow w większym projekcie (PDF zamiast inline)"
description: "Jak generować rysunki TikZ jako pliki PDF, przycinać je narzędziem pdfcrop i używać w dokumentach LaTeX zamiast rysunków inline."
date: 2026-04-25 07:00:00 +0100
categories: [Grafika, LaTeX-TikZ]
tags: [latex, tikz, workflow]
---

Rysunki TikZ są świetne, ale w większych dokumentach LaTeX potrafią znacząco spowalniać kompilację i powodować problemy z pakietami.

Zamiast kompilować rysunki TikZ bezpośrednio w dokumencie, można generować z nich osobne pliki PDF i wstawiać je do dokumentu jako gotową grafikę, np. poleceniem `\includegraphics` z pakietu `graphicx`.

To podejście pokazuję w tym wpisie.

---

## Podejście standardowe – TikZ bezpośrednio w dokumencie

Standardowe podejście polega na wstawianiu rysunku TikZ bezpośrednio do dokumentu:

```latex
\begin{circuitikz}
  % kod TikZ
\end{circuitikz}
```

Kody rysunków bywają rozbudowane, więc wygodnie jest je mieć w osobnych plikach i włączać do dokumentu poleceniem `\input{example.tikz}`:

```latex
\begin{figure}[ht]
	\centering
	\input{example.tikz}
	\caption{Podpis rysunku}
	\label{fig:1}
\end{figure}
```

Plik `example.tikz` zawiera rysunek:

```latex
\begin{circuitikz}
  % kod TikZ
\end{circuitikz}
```

Dobrze się to sprawdza, jednak ma kilka wad:

-   długi czas kompilacji przy wielu rysunkach,
-   potencjalne konflikty pakietów,
-   mniej wygodna organizacja projektu (praca nad rysunkami w głównym dokumencie).

---

## Podejście: TikZ → PDF

Zamiast kompilować rysunki TikZ w głównym dokumencie, rysunek TikZ można przygotować jako osobny plik PDF i przyciąć narzędziem `pdfcrop`.

### Pliki źródłowe

- [`tikz2pdf.tex`](/assets/posts/graphics-latex-tikz-to-pdf/tikz2pdf.tex) – plik kompilujący rysunek do PDF
- [`example.tikz`](/assets/posts/graphics-latex-tikz-to-pdf/figures/example.tikz) – definicja rysunku w języku TikZ
- [`tikz2pdf-crop.cmd`](/assets/posts/graphics-latex-tikz-to-pdf/tikz2pdf-crop.cmd) – skrypt do przycinania PDF (`pdfcrop`)
- [`tikz2pdf-usage.tex`](/assets/posts/graphics-latex-tikz-to-pdf/tikz2pdf-usage.tex) – przykład użycia w dokumencie LaTeX
- [`pdf2png.cmd`](/assets/posts/graphics-latex-tikz-to-pdf/pdf2png.cmd) – skrypt do robienia `png` (opcjonalnie)

### Pliki wynikowe

- [`tikz2pdf.pdf`](/assets/posts/graphics-latex-tikz-to-pdf/output/tikz2pdf.pdf) – wynik kompilacji pliku `tikz2pdf.tex`
- [`tikz2pdf-crop-1.pdf`](/assets/posts/graphics-latex-tikz-to-pdf/output/tikz2pdf-crop-1.pdf) – przycięty plik, wariant 1 (z siatką i węzłami pomocniczymi)
- [`tikz2pdf-crop-2.pdf`](/assets/posts/graphics-latex-tikz-to-pdf/output/tikz2pdf-crop-2.pdf) – przycięty plik, wariant 2 (z węzłami pomocniczymi)
- [`tikz2pdf-crop-3.pdf`](/assets/posts/graphics-latex-tikz-to-pdf/output/tikz2pdf-crop-3.pdf) – przycięty plik, wariant 3 (końcowy, docelowy)

---

## Rysunki

Poniższe rysunki przedstawiają trzy warianty tego samego rysunku wygenerowanego z kodu TikZ.

Wariant 1:

![Wariant 1 – rysunek z siatką i węzłami pomocniczymi](/assets/posts/graphics-latex-tikz-to-pdf/output/tikz2pdf-crop-1.png)
***Rys. 1.** Wariant 1 – rysunek z siatką i węzłami pomocniczymi.*

Wariant 2:

![Wariant 2 – rysunek z węzłami pomocniczymi](/assets/posts/graphics-latex-tikz-to-pdf/output/tikz2pdf-crop-2.png)
***Rys. 2.** Wariant 2 – rysunek z węzłami pomocniczymi.*

Wariant 3:

![Wariant 3 – rysunek docelowy](/assets/posts/graphics-latex-tikz-to-pdf/output/tikz2pdf-crop-3.png)
***Rys. 3.** Wariant 3 – rysunek docelowy.*

---

## Podsumowanie

Generowanie rysunków TikZ jako osobnych plików PDF upraszcza organizację projektu, skraca czas kompilacji i zmniejsza ryzyko konfliktów z pakietami.

W praktyce jest to wygodne podejście przy pracy z większymi dokumentami LaTeX.