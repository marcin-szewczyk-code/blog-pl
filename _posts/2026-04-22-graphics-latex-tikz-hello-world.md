---
title: "Grafika: Rysunki TikZ w LaTeX – przykład Hello World (prawie minimalny)"
description: "Minimalny przykład użycia TikZ w LaTeX: jak narysować prosty rysunek i zrozumieć podstawową składnię."
date: 2026-04-22 07:00:00 +0100
categories: [Grafika]
tags: [latex, tikz, hello-world]
---

TikZ to pakiet LaTeX do tworzenia grafiki. Skoro działa w LaTeX, to rysunki definiowane są za pomocą kodu.

Definiowanie rysunków tekstowo przy użyciu składni TikZ daje kilka przydatnych rzeczy:

- dużą kontrolę nad szczegółami rysunku,
- spójność rysunku z dokumentem (np. czcionki)
- możliwość łatwych modyfikacji w przyszłości (wyszukuję dany fragment, zmieniam, kompiluję).

Poniżej pokazuję (prawie) najprostszy przykład, zakończony rysunkiem:

![Przykładowy rysunek TikZ z widoczną siatką i węzłami](/assets/posts/graphics-latex-tikz-hello-world/figures/rlc-3.png)
***Rys. 1.** Przykładowy rysunek TikZ z widoczną siatką i węzłami.*

---

## Minimalny przykład -- okrąg (Hello World)

TikZ działa bezpośrednio w LaTeX, a rysunek to fragment kodu w środowisku `tikzpicture`.

Przykładowy rysunek okręgu z zaznaczonym środkiem, promieniem i średnicą:

<img src="/assets/posts/graphics-latex-tikz-hello-world/figures/circle.png" width="200">
***Rys. 2.** Przykładowy rysunek Tikz -- okrąg.*

Kod:

``` latex
\begin{tikzpicture}[scale=2]
	% circle
	\draw (0,0) circle (1);
	% center
	\fill (0,0) circle (1.5pt) node[below left] {$O$};
	% radius
	\draw[->] (0,0) -- (1,0) node[midway, below] {$r$};
	% extension lines
	\draw (-1,0) -- (-1,1.4);
	\draw (1,0) -- (1,1.4);
	% diameter (dimension line)
	\draw[<->] (-1,1.4) -- (1,1.4)
	node[midway, above] {$d=2r$};
\end{tikzpicture}
```

Podstawowe elementy składni:

- `\begin{tikzpicture}` --- środowisko rysunku
- `\draw` --- rysowanie
- `(x,y)` --- współrzędne
- `--` --- linia
- `node` --- opis
- `[->]`, `[<->]` --- strzałki

---

## Minimalny przykład -- obwód RLC

Poniżej pokazuję kod TikZ rysunku obwodu w trzech wariantach składni: od najprostszej do najbardziej złożonej.

### Wariant 1

Rysunek, który powstaje z super-prostego kodu, ale w którym nie podoba mi się niewyrównanie strzałek w poziomie:

![Przykładowy rysunek Tikz -- obwód LCR, bez siatki i węzłów](/assets/posts/graphics-latex-tikz-hello-world/figures/rlc-1.png)
***Rys. 3.** Przykładowy rysunek Tikz -- obwód LCR, bez siatki i węzłów.*

Kod:

```latex
\begin{circuitikz}[scale=0.7,line width=1pt]
	\draw
	(0,0) to[isource, l=$e(t)$] (0,4)
	-- (1.5,4)
	to[L, l=$L$, v_<=$u_\mathrm{L}(t)$] (3.5,4)
	-- (4.5,4)
	to[R, l=$R$, v_<=$u_\mathrm{R}(t)$] (6.3,4)
	-- (7.3,4)
	to[closing switch, l=$S$, bipoles/length=2cm] (9.3,4)
	to[short, i>^=$i(t)$] (11.1,4)
	-- (11.1,0) -- (0,0);
\end{circuitikz}
```

### Wariant 2

Rysunek identyczny jak wyżej, tylko inny sposób zadawania współrzędnych węzłów (przesunięcia względem poprzednich).

Kod:

```latex
\begin{circuitikz}[scale=0.7,line width=1pt]
	\draw
	(0,0) to[isource, l=$e(t)$] ++(0,4)
	-- ++(1.5,0)
	to[L, l=$L$, v_<=$u_\mathrm{L}(t)$] ++(2.0,0)
	-- ++(1.0,0)
	to[R, l=$R$, v_<=$u_\mathrm{R}(t)$] ++(1.8,0)
	-- ++(1.0,0)
	to[closing switch, l=$S$, bipoles/length=2cm] ++(2.0,0)
	to[short, i>^=$i(t)$] ++(1.8,0)
	-- ++(0,-4) -- ++(-11.1,0);
\end{circuitikz}
```

### Wariant 3

Docelowy rysunek. Kod nieco spuchł, ale jest w nim wszystko co potrzeba na początek. Potem można swobodnie rozbudowywać w miarę potrzeb pojawiających się przy konkretnych rysunkach.

![Przykładowy rysunek Tikz -- obwód LCR, z siatką i węzłami](/assets/posts/graphics-latex-tikz-hello-world/figures/rlc-3.png)
***Rys. 4.** Przykładowy rysunek Tikz -- obwód LCR, z siatką i węzłami.*

Kod:

```latex
\begin{circuitikz}[scale=0.7,line width=1pt]
	% --- Debug switches ---
	% Enable or disable auxiliary drawing elements (grid and nodes)
		
	\newif\ifshowgrid   % Controls visibility of the background grid
	\newif\ifshownodes  % Controls visibility of debug nodes and labels
		
	\showgridtrue      % Set to \showgridtrue to show the grid
	\shownodestrue      % Set to \shownodesfalse to hide debug markers and labels
		
	% Debug grid to assist with manual layout alignment
	\ifshowgrid
	\draw [help lines] (-3,-1) grid (13,6);
	\fi
		
	% --- Point definitions ---
	\coordinate (n0) at (0,0);
	\coordinate (n1) at (0,4);
	\coordinate (n2) at (1.5,4);
	\coordinate (n3) at (3.5,4);
	\coordinate (n4) at (4.5,4);
	\coordinate (n5) at (6.3,4);
	\coordinate (n6) at (7.3,4);
	\coordinate (n7) at (9.3,4);
	\coordinate (n8) at (11.1,4);
	\coordinate (n9) at (11.1,0);
		
	% Consistent style for debug labels
	\tikzset{
		debug label/.style={
			font=\scriptsize,
			fill=white,
			inner sep=0pt
		}
	}
		
	% --- Main circuit ---
	\draw
	(n0) to[isource, l=$e(t)$] (n1)
	(n1) to[short, -] (n2)
	(n2) to[L=$L$] (n3)
	(n3) to[short, -] (n4)
	(n4) to[R=$R$] (n5)
	(n5) to[short, -] (n6)
	(n6) to[/tikz/circuitikz/bipoles/length=2cm, closing switch=$S$] (n7)
	(n7) to[short, -, i>^=$i(t)$] (n8)
	(n8) to[short, -] (n9)
	(n9) to[short, -] (n0)
	;
		
	% --- Manually drawn voltage arrows ---
	% NOTE: Voltage arrows are drawn manually to control length and alignment
	
	% --- ustaw długość strzałki ---
	\def\varrow{1.6}  % całkowita długość
		
	% u_L
	\draw[<-]
	($(n2)!0.5!(n3)+(-0.5*\varrow,-0.65)$) --
	($(n2)!0.5!(n3)+(0.5*\varrow,-0.65)$)
	node[midway, below=5pt, fill=white, inner sep=0pt] {$u_\mathrm{L}(t)$};
		
	% u_R
	\draw[<-]
	($(n4)!0.5!(n5)+(-0.5*\varrow,-0.65)$) --
	($(n4)!0.5!(n5)+(0.5*\varrow,-0.65)$)
	node[midway, below=5pt, fill=white, inner sep=0pt] {$u_\mathrm{R}(t)$};		
	
	% --- Debug: point names ---
	\ifshownodes
		\foreach \p in {n1,n2,n3,n4,n5,n6,n7,n8}{
			\fill[red] (\p) circle (2pt);
			\node[above=5pt, debug label] at (\p) {\p};
		}
		\foreach \p in {n0,n9}{
			\fill[red] (\p) circle (2pt);
			\node[below=5pt, debug label] at (\p) {\p};
		}
	\fi
\end{circuitikz}
```

## Podsumowanie

TikZ jest prosty, skryptowy, a więc daje możliwość edycji i modyfikacji rysunków w środowisku LaTeX.

W kolejnym wpisie pokazuję praktyczny workflow:

👉 generowanie rysunków TikZ jako osobnych plików PDF i włączanie ich do dokumentu LaTeX.
