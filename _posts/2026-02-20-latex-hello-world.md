---
title: "LaTeX: Hello World – przykład (prawie) minimalny"
description: "Przykład LaTeX „Hello World” w dwóch wariantach: formalne minimum oraz wersja praktyczna z preambułą, pakietami, sekcjami, wzorami, rysunkiem i bibliografią, wraz z podstawami kompilacji do PDF."
date: 2026-02-20 07:00:00 +0100
categories: [LaTeX]
tags: [latex, hello-world]
---

Dokument LaTeX jest plikiem tekstowym opisującym strukturę i skład typograficzny przy użyciu poleceń i środowisk. Jest kompilowany do formatów wyjściowych, takich jak PDF. Tworzy się go w dowolnym edytorze tekstu, a następnie kompiluje przy użyciu wybranej dystrybucji TeX, np. [TeX Live](https://www.tug.org/texlive/). LaTeX nie jest narzędziem WYSIWYG (*What You See Is What You Get*) -- dokument opisuje się tekstowo, a jego postać końcowa powstaje dopiero po kompilacji.

W większych projektach dołącza się pakiety oraz zarządza się strukturą projektu organizując pracę w wielu plikach tekstowych (rozdziały, bibliografia, rysunki, definicje makr). Aby ułatwić pracę, korzysta się ze środowisk takich jak [Overleaf](https://www.overleaf.com/), [TeXstudio](https://www.texstudio.org/) czy [VS Code](https://code.visualstudio.com/) (z odpowiednimi rozszerzeniami).

Środowiska opisuję w innym wpisie -- tutaj pokazuję przykład *Hello World* w czystym LaTeX-u. Oprócz absolutnego minimum pokazuję wariant praktyczny zawierający niektóre podstawowe elementy, których używam w praktyce i dobrze ilustrujący ideę pracy w LaTeX-u.

Poniżej przedstawiono widok dokumentu PDF wygenerowanego z pliku [`hello-practical-pl.tex`](/assets/posts/latex-hello-world/hello-practical-pl/hello-practical-pl.tex), omawianego w tym wpisie.

![Widok wygenerowanego PDF](/assets/posts/latex-hello-world/hello-practical-pl/hello-practical-pl-preview.png)
***Rys. 1.** Widok wygenerowanego PDF [`hello-practical-pl.pdf`](/assets/posts/latex-hello-world/hello-practical-pl/hello-practical-pl.pdf).*

---

## Struktura dokumentu

LaTeX, podobnie jak HTML, jest językiem znaczników (markup language), w którym dokument opisuje się przy użyciu poleceń sterujących składem. Plik `.tex` stanowi kod źródłowy, który po kompilacji generuje dokument wynikowy (najczęściej PDF). W przypadku HTML plik `.html` jest interpretowany przez przeglądarkę.

Dokument LaTeX zapisuje się w pliku tekstowym z rozszerzeniem `.tex`, np. `hello-minimal.tex`.

Każdy dokument LaTeX ma dwie podstawowe części:
1. Preambuła -- wszystko przed `\begin{document}...\end{document}`
2. Treść właściwa -- tekst i polecenia między `\begin{document}` a `\end{document}`

W preambule definiuje się:
- klasę dokumentu (\documentclass)
- pakiety (\usepackage)
- definicje własnych makr
- ustawienia globalne

W treści właściwej umieszcza się:
- tekst
- sekcje
- wzory
- rysunki
- tabele
- inne (bibliografia, ...)

## Składnia poleceń w LaTeX

Polecenia w LaTeX-u mają postać:

```latex
\polecenie[parametry]{argumenty}
```

gdzie:
- `\polecenie` -- nazwa polecenia,
- `[parametry]` -- argumenty opcjonalne (w nawiasach kwadratowych),
- `{argumenty}` -- argumenty obowiązkowe (w nawiasach klamrowych).

Przykład:
- `\documentclass[a4paper,12pt]{article}` -- klasa dokumentu `article`, rozmiar papieru `a4paper`, wielkość czcionki `12pt`
- `\section{Wprowadzenie}` -- nagłówek pierwszego stopnia

## Dokument Hello World – przykład minimalny

Minimalny dokument `hello-minimal.tex` (przykładowej klasy `article`) wygląda tak:

```latex
% Title: LaTeX Hello World minimal example
\documentclass{article}
\begin{document}
	Hello World
\end{document}
```

Skompilować można go zwykłym poleceniem w linii poleceń:

```bash
pdflatex hello-minimal.tex
```

## Dokument Hello World – przykład (prawie) minimalny

Do tego dochodzą standardowo elementy potrzebne w praktyce:

- w preambule:
    - ustawienie kodowania i języka
    - pakiety matematyczne
    - obsługa grafiki
    - metadane (tytuł, autor, data).
- w treści właściwej:
    - spis treści
    - struktura sekcji
    - bibliografia

Wtedy taki minimalny LaTeX `hello-practical-pl.tex` wygląda tak:

```latex
% File: hello-practical-pl.tex
% Author: Marcin Szewczyk
% Title: LaTeX Hello World practical example
% Created: 2026-02-20

\documentclass[a4paper,11pt]{article}

% --- Encoding & language ---
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage[polish]{babel}

% --- Layout ---
\usepackage[left=18mm,right=18mm,top=18mm,bottom=18mm]{geometry}
\usepackage{microtype}

% --- Section spacing ---
\usepackage{titlesec}
\titlespacing*{\section}{0pt}{0.8\baselineskip}{0.3\baselineskip}
\titlespacing*{\subsection}{0pt}{0.6\baselineskip}{0.2\baselineskip}

% --- Math & graphics ---
\usepackage{amsmath}
\usepackage{graphicx}
\usepackage{wrapfig}

% --- Hyperlinks ---
\usepackage{xcolor}
\usepackage[
colorlinks=true,
linkcolor=blue!50!black,
urlcolor=blue!50!black,
citecolor=blue!50!black
]{hyperref}

% --- Frame settings ---
\setlength{\fboxsep}{4pt}    % frame padding
\setlength{\fboxrule}{0.6pt} % frame thickness

% --- Metadata ---
\title{Hello World in \LaTeX: Struktura dokumentu\\i przykład (prawie) minimalny}
\author{Marcin Szewczyk}
\date{\today}

% --- Section numbering with trailing dot ---
\renewcommand{\thesection}{\arabic{section}.}
\renewcommand{\thesubsection}{\arabic{section}.\arabic{subsection}.}

\begin{document}
	
	\maketitle
	\tableofcontents
	
	\section{Wprowadzenie}
	
	\subsection{Tekst}
	
	To jest przykładowy dokument \LaTeX.
	Możemy pisać zwykły tekst oraz budować strukturę dokumentu.
	
	\subsection{Matematyka}
	
	Wzory matematyczne zapisujemy w linii
	$ e^x=\sum_{n=0}^{\infty}{x^n\over n!} $,
	lub w akapitach:
	\begin{equation}\label{eq-ex}
		e^x=\sum_{n=0}^{\infty}{x^n\over n!},
	\end{equation}
	\noindent a następnie odwołujemy się do nich~\eqref{eq-ex}.
	
	\subsection{Cytowania}
	
	Możemy cytować literaturę \cite{oppenheim2023},
	grupować cytowania \cite{oppenheim2023,stroustrup2013,grebosz2004}
	lub dodawać numery stron \cite[s.~12]{oppenheim2023}.
	
	\section{Rysunki}
	
	\begin{wrapfigure}{r}{0.42\textwidth}
		\centering
		\fbox{\includegraphics[width=0.38\textwidth]{figures/mat-gcb.pdf}}
		\caption{Przykładowy rysunek}
		\label{fig:example}
	\end{wrapfigure}
	
	Przykład wstawiania grafiki.
	Można odwoływać się do rysunku (rys.~\ref{fig:example}).
	
	\section*{Bibliografia}
	
	\begin{thebibliography}{99}
		
		\bibitem{oppenheim2023}
		T.~Oetiker, H.~Partl, I.~Hyna, E.~Schlegl,
		\textit{The Not So Short Introduction to \LaTeX2e}, 2023.
		
		\bibitem{stroustrup2013}
		B.~Stroustrup,
		\textit{The C++ Programming Language},
		4th ed., Addison-Wesley, 2013.
		
		\bibitem{grebosz2004}
		J.~Grębosz,
		\textit{Symfonia C++ Standard. Programowanie w języku C++},
		Edition 2004.
		
	\end{thebibliography}
	
\end{document}
```

To jest punkt wyjścia bliższy rzeczywistej pracy niż formalne minimum składniowe.

## Pliki użyte w tym przykładzie

Pliki użyte w tym wpisie:

- [`hello-minimal.tex`](/assets/posts/latex-hello-world/hello-minimal/hello-minimal.tex) -- przykład minimalny *Hello world*
- [`hello-practical-pl.tex`](/assets/posts/latex-hello-world/hello-practical-pl/hello-practical-pl.tex) -- przykład (prawie) minimalny *Hello world*, w języku polskim (np. kropki po numerach sekcji)
- [`hello-practical-en.tex`](/assets/posts/latex-hello-world/hello-practical-en/hello-practical-en.tex) -- przykład (prawie) minimalny *Hello world*, w języku angielskim (np. brak kropek po numerach sekcji)

Po kompilacji powstaje plik `.pdf` zawierający dokument wynikowy.

Przy kompilacji generowane są automatycznie pliki pomocnicze, nie przeznaczone do ręcznej edycji:
- `hello-practical.aux`  – dane pomocnicze (odwołania, etykiety, cytowania)
- `hello-practical.log`  – log kompilacji
- `hello-practical.toc`  – dane spisu treści
- `hello-practical.out`  – dane zakładek PDF (pakiet `hyperref`)
- `hello-practical.gz`   – skompresowane dane zakładek (jeśli włączona kompresja)

W przypadku dokumentów zawierających odwołania, spis (lub spisy) treści, indeksy lub cytowania
wykonywana jest wielokrotna kompilacja. Pierwsze przejście zapisuje dane pomocnicze (np. numery sekcji, etykiety, cytowania)
do plików takich jak `.aux` czy `.toc`, a kolejne przejścia wykorzystują te dane do poprawnego złożenia dokumentu.

Jeśli dokument kompilowany jest w repozytorium GitHub, pliki pomocnicze należy wykluczyć z kontroli wersji
(dodać ich rozszerzenia do pliku `.gitignore`):

```gitignore
# LaTeX auxiliary files
*.aux
*.log
*.toc
*.out
*.gz
*.lof
*.lot
*.fls
*.fdb_latexmk
*.synctex.gz

# Bibliography
*.bbl
*.blg

# Index files
*.idx
*.ind
*.ilg

# Temporary build directories (optional)
build/
```

## Rozszerzanie projektu

W większych projektach dokument można dzielić na wiele plików źródłowych, włączanych poleceniem `\input{./chapters/chapter-name.tex}` lub `\include{./chapters/chapter-name.tex}`. Bibliografia typowo umieszczana jest w zewnętrznym pliku `.bib`. Taka struktura poprawia czytelność i skalowalność projektu.

Jednocześnie praca z jednym plikiem ma swoje zalety -- przede wszystkim ułatwia wyszukiwanie etykiet, odwołań i definicji w całym dokumencie bez przeskakiwania między plikami.

## Podsumowanie

To wystarczający punkt startowy do budowy większych dokumentów: artykułów, raportów czy książek.