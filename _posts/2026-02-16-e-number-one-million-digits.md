---
title: "Liczba „e” (3/3): Z dokładnością do miliona miejsc po przecinku"
date: 2026-02-16 07:00:00 +0100
categories: [Mathematics]
tags: [math, e, taylor-series, c, gmp]
---

## Szereg Taylora funkcji $e^x$

Liczba $e$ ma wiele ciekawych własności i zastosowań, a dodatkowo ciekawe jest też to, że szereg Taylora będący rozwinięciem funkcji $e^x$ dla $x=1$ jest dodatni (nie naprzemienny) i bardzo szybko zbieżny. Jest tak dlatego, że ma silnię kolejnych indeksów sumy w mianowniku:

$$
e^x=\sum_{n=0}^{\infty}\frac{x^n}{n!}
\:\:\Rightarrow\:\:
e=\sum_{n=0}^{\infty}\frac{1}{n!}.
$$

Skoro tak, to łatwo jest napisać kod np. w C, który liczy ten szereg z dobrą precyzją, a z użyciem biblioteki GMP z dowolną precyzją.

GMP (GNU Multiple Precision Arithmetic Library) to biblioteka do obliczeń na liczbach o dowolnie dużej precyzji, znacznie większej niż oferowana przez standardowe typy zmiennoprzecinkowe, ograniczonej jedynie dostępną pamięcią.

## Obliczanie liczby $e$ z szeregu Taylora

Tutaj zamieściłem dwa kody:
- zwykłe C, bez GMP, oblicza $e$ do dziesięciu miejsc po przecinku: [e_number.c](/assets/posts/e-number-one-million-digits/e_number.c)
- analogiczny kod z GMP, oblicza $e$ do miliona miejsc po przecinku: [e_number_gmp.c](/assets/posts/e-number-one-million-digits/e_number_gmp.c)

Wynikiem kodu `e_number.c` jest liczba $e=2.7182818284$..

Wynikiem kodu `e_number_gmp.c` jest liczba $e$ z milionem miejsc po przecinku, zapisana w pliku [e_number_gmp.txt](/assets/posts/e-number-one-million-digits/e_number_gmp.txt). Pierwsze 1000 z miliona cyfr po przecinku wygląda tak:

```txt
e = 2.718281828459045235360287471352662497757247093699959574966967627724076630353545
713821785251664274274663919320030599218174135966290435729003342952605956307381323286
279434907632338298807531952510190115738341879307021540891499348841675092447614606680
822648001684774118537423454424371075390777449920695517027618386062613313845830007520
449338265602976067371132007093287091274437470472306969772093101416928368190255151086
574637721112523897844250569536967707854499699679468644549059879316368892300987931277
361782154249992295763514822082698951936680331825288693984964651058209392398294887933
203625094431173012381970684161403970198376793206832823764648042953118023287825098194
558153017567173613320698112509961818815930416903515988885193458072738667385894228792
284998920868058257492796104841984443634632449684875602336248270419786232090021609902
353043699418491463140934317381436405462531520961836908887070167683964243781405927145
6354906130310720851038375051011574770417189861068739696552126715468895703503540212..
```

Jest więcej takich obliczeń, np. w projekcie
[y-cruncher na numberworld.org](https://www.numberworld.org/y-cruncher/),
wraz z dużymi rekordami wyników dla $e$, $\pi$ i innych stałych.

Zrobiłem też kiedyś skład w LaTeX-u ciekawej książki na ten temat i napisałem do niej przedmowę:
[Number e to Approximately 1 Million Places](/assets/posts/e-number-one-million-digits/number_e_to_approximately_1_million_places.pdf).

## Kod w C (bez GMP)

Prosty kod w C bez GMP, który sam się tłumaczy, z pliku [e_number.c](/assets/posts/e-number-one-million-digits/e_number.c):

```c
#include <stdio.h>
/*
 Obliczenie liczby e bez GMP (mała precyzja).
 Liczymy szereg: e = sum_{n=0..∞} 1/n!
 Zatrzymanie po osiągnięciu zadanego progu eps,
 a wynik wypisywany do 10 miejsc po przecinku.

 Kompilacja: gcc e_number.c -O2 -o e_number.exe
 */

int main(void)
{
    const int DIGITS = 10;
    const long double eps = 1e-12L;  // zapas w stosunku do 1e-10

    long double e = 1.0L;      // suma
    long double term = 1.0L;   // 1/0!
    unsigned long k = 1;

    // zatrzymanie, gdy kolejny wyraz jest na tyle mały, że nie wpływa na wynik
    while (term > eps) {
        term /= (long double)k;   // term = 1/k!
        e += term;
        k++;
    }

    printf("e = %.*Lf\n", DIGITS, e);
    printf("Uzyte wyrazy szeregu: %lu\n", k);

    return 0;
}
```

Kody C kompiluję w MinGW:

```bash
gcc e_number.c -O2 -o e_number.exe
gcc e_number_gmp.c -O2 -lgmp -o e_number_gmp.exe
```

Robię → działa → jest fajnie.

To zamyka serię trzech wpisów o liczbie $e$: od intuicji, przez wzór Eulera i szereg Taylora, do obliczeń z precyzją miliona cyfr po przecinku.

