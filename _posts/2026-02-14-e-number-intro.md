---
title: "Liczba „e” (1/3): Skąd się bierze i dlaczego jest ważna"
date: 2026-02-14 07:00:00 +0100
categories: [Mathematics]
tags: [math, e]
---

Idziemy teraz z grubej rury. Odpoczywamy od instalacji i konfiguracji i zanurzamy się w odrobinę ciekawej, prostej matematyki.

> **Źródło** Ten wpis jest dostosowanym do bloga rozdziałem mojej książki: M. Szewczyk, *[Metody analityczne w obliczeniach procesów łączeniowych w systemie elektroenergetycznym](https://www.sklep.pw.edu.pl/produkty/metody-analityczne-w-obliczeniach-procesow-laczeniowych-w-systemie-elektroenergetycznym)*, OWPW 2024.

## Funkcja wykładnicza $a^x$ i eksponencjalna $e^x$

Funkcja $e^x$ uznawana jest za jedną z najważniejszych funkcji analizy matematycznej. Doniosłym miejscem jej wprowadzenia jest obliczenie pochodnej funkcji *wykładniczej*, $a^x$, a następnie rozważenie tej pochodnej dla pewnej szczególnej *podstawy*, i wprowadzenie dla niej oznaczenia jako $a=e$. Uzyskuje się wówczas funkcję *eksponencjalną*, $e^x$, przy czym stosuje się również oznaczenie: $e^x=\exp(x)$.

Wprowadźmy proste nazwy: $a$ nazywamy podstawą, a $x$ nazywamy wykładnikiem funkcji $a^x$.

Poniżej zamieszczam ciekawą intuicję wynikającą z definicji pochodnej i z pewnego prostego oszacowania numerycznego. W kursie analizy matematycznej liczba $e$ jest wprowadzana wcześniej niż pochodne, już przy badaniu zbieżności ciągów i szeregów nieskończonych. Ale ta intuicja numeryczna jest na tyle ciekawa, że warto za nią podążyć.

Punktem wyjściowym jest prosty wzór definicyjny pochodnej funkcji $f(x)$ jako granicy:

$$
\frac{\mathrm{d}f(x)}{\mathrm{d}x}
=\lim_{\Delta x\to 0}{\frac{f(x+\Delta x)-f(x)}{\Delta x}}.
$$

## Pochodna funkcji wykładniczej $a^x$

Pochodną funkcji wykładniczej $a^x$ obliczamy, korzystając wprost z podanej wyżej definicji pochodnej:

$$		
\frac{\mathrm{d}a^x}{\mathrm{d}x}
=\lim_{\Delta x\to 0}{\frac{a^{x+\Delta x} - a^x}{\Delta x}}
=\lim_{\Delta x\to 0}{a^x\frac{a^{\Delta x} - 1}{\Delta x}}
=a^x\lim_{\Delta x\to 0}{\frac{a^{\Delta x} - 1}{\Delta x}}.
$$

Zauważamy natychmiast, że granica występująca w powyższym wzorze (ostatni *limes* po prawej stronie) nie zależy od zmiennej niezależnej $x$, a zależy od $a$. Będzie to istotne dla dalszego badania, dlatego dla uwidocznienia tego faktu zapisujemy powyższy wzór w postaci:
		
$$
\frac{\mathrm{d}a^x}{\mathrm{d}x}
=C_a a^x,\:\:\:\text{gdzie:}\:\:C_a=\lim_{\Delta x\to 0}{\frac{a^{\Delta x} - 1}{\Delta x}}.
$$
		
Zatem pochodna funkcji wykładniczej $a^x$ jest równa tej samej funkcji $a^x$ pomnożonej przez pewną liczbę $C_a.$ Przy czym stała $C_a$ jest niezależna od $x$, natomiast jest zależna od $a$. Ta liczba $C_a$ jest równa podanej wyżej granicy.

## Oszacowanie numeryczne stałej $C_a$

Ścisłe obliczenie granicy $C_a$ wymaga głębszego wglądu w strukturę analizy matematycznej, w szczególności odwołania się do ,,języka'' ciągów i wyrażenia w tym języku liczby $e$. Zamiast tego przedstawię pewne proste oszacowanie *numeryczne*, ponieważ sama intuicja wynikająca z tego oszacowania jest tak interesująca, że warto za nią podążyć.

<!--

\footnote{\label{footnote:granica_axex}~Granicę \eqref{eq:pochodna_axex_2} można łatwo obliczyć, \textit{znając} pochodną funkcji $e^x$, posługując się wówczas rozwinięciem funkcji $e^x$ w~szereg Taylora\index{Taylor} \eqref{eq:zbieznosc_taylora_12} lub, jeszcze prościej, regułą \textit{de l'Hospitala\index{de l'Hospital}} \eqref{eq:delhospital_final}. Obie te metody wymagają jednak posługiwania się pochodną funkcji $e^x$, np. wg reguły de l'Hospitala\index{de l'Hospital}: $\lim_{\Delta x\to 0}{\tfrac{e^{\Delta x} - 1}{\Delta x}}=\lim_{\Delta x\to 0}{\tfrac{(e^{\Delta x} - 1)'_{\Delta x}}{(\Delta x)'_{\Delta x}}}=\lim_{\Delta x\to 0}{\tfrac{e^{\Delta x}}{1}}=1$.}.

-->


***Tab. 1.** Wartości stałej $C_a$ obliczone dla $a=2$, $a=3$ oraz dla $2<a=e<3$, przy określonym $\Delta x.$*

| $\Delta x$ | $C_{a=2}$ | $C_{a=e\approx 2.71828\ldots}$ | $C_{a=3}$ |
|:--:|--:|--:|--:|
| $10^{-1}$ | 0.7177346 | 1.0517092 | 1.1612317 |
| $10^{-2}$ | 0.6955550 | 1.0050167 | 1.1046691 |
| $10^{-3}$ | 0.6933874 | 1.0005002 | 1.0992159 |
| $10^{-4}$ | 0.6931712 | 1.0000500 | 1.0986726 |
| $10^{-5}$ | 0.6931495 | 1.0000050 | 1.0986183 |
| $10^{-6}$ | 0.693147(4) $< 1$ | 1.000000(5) $\approx 1$ | 1.098612(8) $> 1$ |
      	
Zauważając, że granica $C_a$ jest funkcją podstawy $a$, w tab. 1 zbadano wartości tej granicy dla $a=2$ oraz $a=3$, a także dla pewnej pośredniej wartości $2<a<3$, obliczając tę granicę dla każdej z tych trzech wartości $a$ i przyjmując coraz mniejsze wartości $\Delta x=10^{-1}, 10^{-2}, \ldots, 10^{-6}$. Dla najmniejszej wartości $\Delta x = 10^{-6}$ obliczone wartości granic $C_a$ różnią się od wartości dowolnie dokładnych (dla $\Delta x\to 0$) na ostatnim miejscu po przecinku (zaznaczonym w tab. 1 nawiasem).
				
Zauważamy, że przy $\Delta x = 10^{-6}$, dla $a=2$ mamy $C_{a=2}<1$, a dla $a=3$ mamy $C_{a=3}>1$. Ponieważ $C_a$ jest funkcją ciągłą względem $a$ (wzór powyżej), więc pomiędzy krańcami $a=2$ i $a=3$ *musi* istnieć taka wartość $a$, dla której funkcja $C_{a}$ przyjmuje wartość $1$. 

Wartość podstawy $a$, przy której stała $C_a$ występująca we wzorze na pochodną funkcji wykładniczej $(a^x)^\prime_x=C_aa^x$ przybiera wartość $1$, *nazywamy* liczbą $e$.

Jest to liczba niewymierna (czyli taka, której nie można przedstawić w postaci ilorazu liczby całkowitej i liczby całkowitej różnej od zera), wynosząca w przybliżeniu $e\approx 2.7182818284590452\dots$:

$$
C_{a=e}=\lim_{\Delta x\to 0}{\frac{e^{\Delta x} - 1}{\Delta x}}=1.
$$

## Wynik końcowy

Stąd wynika, zgodnie z powyższymi wzorami, że dla $a=e$ mamy:

$$
\frac{\mathrm{d}e^x}{\mathrm{d}x}=e^x.
$$

Czyli pochodna funkcji $e^x$ jest równa samej sobie.

Fakt ten ma wiele bardzo doniosłych konsekwencji.