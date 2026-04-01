---
title: "Grafika: Rysunki TikZ – PDF z kodu TikZ do osadzania w LaTeX"
description: "Jak kompilować rysunki TikZ do osobnych plików PDF, przycinać je narzędziem pdfcrop i włączać do dokumentu LaTeX jako gotowe grafiki."
date: 2026-04-23 07:00:00 +0100
categories: [Grafika]
tags: [latex, tikz, workflow]
---

Rysunki tworzone w TikZ są świetne, ponieważ pozwalają definiować grafikę za pomocą kodu. Grafika tworzona jest w LaTeX, a następnie eksportowana wektorowo do PDF.

W przypadku dużych dokumentów LaTeX spowalniają jednak kompilację, zwłaszcza gdy są złożone (np. rysunki z `circuitikz`). Potrafią też wchodzić w konflikt z innymi pakietami -- zwłaszcza w szablonach wydawniczych, których dostosowywanie pod TikZ w pojedynczym dokumencie się nie opłaca.

Dobrym rozwiązaniem jest generowanie rysunków TikZ jako osobnych plików PDF, a następnie włączanie ich do dokumentu LaTeX jako gotowej grafiki (np. za pomocą polecenia `\includegraphics` z pakietu `graphicx`).

To pokazuję w tym wpisie.

---

## Podejście standardowe -- TikZ bezpośrednio w dokumencie

Standardowe podejście polega na wstawianiu rysunku TikZ bezpośrednio do dokumentu:

```latex
\begin{circuitikz}
  % kod TikZ
\end{circuitikz}
```

Zwykle kody rysunków są spore, więc wygodnie jest mieć je w osobnych plikach i włączać do dokumentu w taki sposób:

```latex
\begin{figure}[ht]
	\centering
	\input{example.tikz}
	\caption{Podpis rysunku}
	\label{fig:1}
\end{figure}
```

gdzie `example.tikz` zawiera rysunek opisany jako:

```latex
\begin{circuitikz}
  % kod TikZ
\end{circuitikz}
```

Dobrze się to sprawdza, jednak ma kilka wad:

-   długi czas kompilacji przy wielu rysunkach,
-   potencjalne konflikty pakietów,
-   trudniejsza organizacja projektu (praca nad rysunkami w głównym dokumencie).

---

## Podejście: TikZ → PDF

Zamiast kompilować TikZ w głównym dokumencie, rysunek przygotowuję w osobnym dokumencie jako plik PDF, a następnie przycinam programem `pdfcrop`.

---

## Pliki źródłowe

- [`tikz2pdf.tex`](/assets/posts/graphics-latex-tikz-to-pdf/tikz2pdf.tex) -- plik kompilujący rysunek do PDF
- [`example.tikz`](/assets/posts/graphics-latex-tikz-to-pdf/figures/example.tikz) -- definicja rysunku w języku TikZ
- [`tikz2pdf-crop.cmd`](/assets/posts/graphics-latex-tikz-to-pdf/tikz2pdf-crop.cmd) -- skrypt do przycinania PDF (`pdfcrop`)
- [`tikz2pdf-usage.tex`](/assets/posts/graphics-latex-tikz-to-pdf/tikz2pdf-usage.tex) -- przykład użycia w dokumencie LaTeX
- [`pdf2png.cmd`](/assets/posts/graphics-latex-tikz-to-pdf/pdf2png.cmd) -- skrypt do robienia `png` (opcjonalnie)

---

## Pliki wynikowe

- [`tikz2pdf.pdf`](/assets/posts/graphics-latex-tikz-to-pdf/output/tikz2pdf.pdf) -- wynik kompilacji `tikz2pdf.tex`
- [`tikz2pdf-crop-1.pdf`](/assets/posts/graphics-latex-tikz-to-pdf/output/tikz2pdf-crop-1.pdf) -- przycięty plik, wariant 1 (z siatką i węzłami pomocniczymi)
- [`tikz2pdf-crop-2.pdf`](/assets/posts/graphics-latex-tikz-to-pdf/output/tikz2pdf-crop-2.pdf) -- przycięty plik, wariant 2 (z węzłami pomocniczymi)
- [`tikz2pdf-crop-3.pdf`](/assets/posts/graphics-latex-tikz-to-pdf/output/tikz2pdf-crop-3.pdf) -- przycięty plik, wariant 3 (końcowy, docelowy)

---

## Rysunki

![Podpis](/assets/posts/graphics-latex-tikz-to-pdf/output/tikz2pdf-crop-1.png)
***Rys. 1.** Podpis.*

![Podpis](/assets/posts/graphics-latex-tikz-to-pdf/output/tikz2pdf-crop-2.png)
***Rys. 2.** Podpis.*

![Podpis](/assets/posts/graphics-latex-tikz-to-pdf/output/tikz2pdf-crop-3.png)
***Rys. 3.** Podpis.*

---

## Podsumowanie

TikZ pozwala na definiowanie grafiki za pomocą kodu, i to jest bardzo wygodne.

Generowanie rysunków TikZ jako PDF i wstawianie ich do dokumentu LaTeX jako gotowych grafik upraszcza workflow i poprawia stabilność projektu.
