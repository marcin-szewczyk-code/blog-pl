---
title: "Liczba „e” (2/3): Szereg Taylora i wzór Eulera"
date: 2026-02-15 07:00:00 +0100
categories: [Mathematics]
tags: [math, e, taylor-series, euler]
---

Pobawmy się słynnym wzorem Eulera:

$$
e^{ix}=\cos x + i\sin x.
$$

O tym wzorze R.P. Feynman w swoich *Wykładach* napisał, że jest to ,,najwspanialszy wzór matematyki'' (,,the most remarkable formula in mathematics''). Z niego bierze się wiele rzeczy, a z ciekawostek również to, że dla $x=\pi$ dostajemy słynną tożsamość $e^{i\pi}+1=0$, wiążącą pięć wielkich liczb matematyki.

> **Źródło** Ten wpis jest dostosowanym do bloga rozdziałem mojej książki: M. Szewczyk, *[Metody analityczne w obliczeniach procesów łączeniowych w systemie elektroenergetycznym](https://www.sklep.pw.edu.pl/produkty/metody-analityczne-w-obliczeniach-procesow-laczeniowych-w-systemie-elektroenergetycznym)*, OWPW 2024. A bardziej u źródła, również pięknej książki: Fichtenholz G. *Rachunek różniczkowy i całkowy*, Tom II. PWN, Warszawa, 1965. Tytuł oryginału: Г. М. Фихтенгольц, *Григорий Михайлович Фихтенгольц: Курс дифференциального и интегрального исчисления*, Москва-Ленинград 1958.

## Szereg Taylora

Wzór Eulera: $e^{ix}=\cos x + i\sin x$ można uzyskać, badając rozwinięcia funkcji $e^x$, $\cos x$, $\sin x$ w szereg potęgowy Taylora dla $x_0=0$:

$$
f(x)=\sum_{n=0}^{\infty}{f^{(n)}(0)\over n!}x^n\:\:.
$$

W przypadku funkcji elementarnych kolejne pochodne $f^{(n)}(0)$ we wzorze Taylora obliczane są zgodnie ze znanymi wzorami:

$$
\frac{\mathrm{d}}{\mathrm{d}x}e^x = e^x,\:\:\:
\frac{\mathrm{d}}{\mathrm{d}x}\cos{x} =-\sin{x},\:\:\:
\frac{\mathrm{d}}{\mathrm{d}x}\sin{x} = \cos{x}.
$$

Ponieważ funkcja $e^x$ odtwarza swoją postać w kolejnych stopniach pochodnej, $(e^x)^{\prime}_x=e^x$, mamy więc natychmiast ze wzoru Taylora rozwinięcie tej funkcji w szereg potęgowy:
		
$$
e^x=\sum_{n=0}^{\infty}{x^n\over n!}.
$$
		
W przypadku funkcji $\cos x$ tylko wyrazy *parzyste*, a w przypadku funkcji $\sin x$ tylko wyrazy *nieparzyste* są niezerowe (ponieważ w obu przypadkach pozostałe pochodne są funkcjami proporcjonalnymi do $\sin x$, które zerują się dla $x=0$), a przy tym kolejne wyrazy zmieniają naprzemiennie znak, począwszy od $+$.

Zatem dla $\cos x$:
		
$$
\cos x
=	{x^0\over0!}+0-{x^2\over2!}+0+{x^4\over4!}+0-{x^6\over6!}+0+{x^8\over8!}+0-\ldots
\approx
$$		

$$      
\approx 1-{x^2\over2!}+{x^4\over4!}-{x^6\over6!}+{x^8\over8!}-\ldots
+{(-1)^Nx^{2N}\over (2N)!}
=\sum_{n=0}^{N}{(-1)^nx^{2n}\over (2n)!}
$$

i analogicznie dla $\sin x$:
		
$$
\sin x
={x^1\over1!}+0-{x^3\over3!}+0+{x^5\over5!}+0-{x^7\over7!}+0+{x^9\over9!}+0-\ldots\approx
$$

$$
\approx
x-{x^3\over3!}+{x^5\over5!}-{x^7\over7!}+{x^9\over9!}-\ldots
+{(-1)^Nx^{2N+1}\over (2N+1)!}
=\sum_{n=0}^{N}{(-1)^nx^{2n+1}\over (2n+1)!}.
$$
		
Zatem dla wszystkich trzech funkcji: $e^x$, $\cos x$ i $\sin x$, mamy:
		
$$
e^x=\sum_{n=0}^{\infty}{x^n\over n!}\:\:,
\:\:\:
\cos x=\sum_{m=0}^{\infty}{(-1)^nx^{2n}\over (2n)!}\:\:,
\:\:\:
\sin x=\sum_{n=0}^{\infty}{(-1)^nx^{2n+1}\over (2n+1)!}\:\:.
$$

## Tasowanie 

Dalej należy, odpowiednio przestawiając i grupując (tasując) wyrazy w rozwinięciu funkcji $e^x$:
		
$$
e^x=\sum_{n=0}^{\infty}{x^n\over n!},
$$
	
dostrzec w rozwinięciu funkcji $e^x$ rozwinięcia funkcji $\cos x$ i  $\sin x$.
 
Są na to ciekawe twierdzenia dotyczące permutacji (tasowania) wyrazów szeregów, z których wynika, że, istotnie, w powyższych szeregach można przestawiać i grupować wyrazy.

## Wzór Eulera

Mogąc tasować wyrazy szeregu Taylora oraz przyjmując w tym szeregu $ix$ zamiast $x$, gdzie $i^2 = -1$, czyli przyjmując $T_{e^{ix}}=e^{ix}$, możemy zapisać:
		
$$
e^{ix}=\sum\limits_{n=0}^\infty{(ix)^n\over n!}
=\sum\limits_{n=0}^\infty{\left[
{(ix)^{2n}\over (2n)!} + {(ix)^{2n+1}\over (2n+1)!}
\right]}
=
\sum\limits_{n=0}^\infty{
{(-1)^n\over (2n)!}x^{2n}}
+
i\sum\limits_{n=0}^\infty{
{(-1)^n\over (2n+1)!}x^{2n+1}},
$$
		
gdzie: $(ix)^n=i^nx^n$, $i^{2n}=(i^2)^n = (-1)^n$ oraz $i^{2n+1}=2^{2n} i~= (-1)^ni$.

Dostrzegając w powyższym zapisie szeregi Taylora funkcji $\cos x=T_{\cos x}$ oraz $\sin x=T_{\sin x}$, można powyższy wzór zapisać w postaci nazywanej *wzorem Eulera*:
		
$$
T_{e^{ix}}=T_{\cos x} + i~T_{\sin x}\:\:\Rightarrow\:\:
\boxed{\:e^{ix}=\cos x + i\sin x\:}\:.
$$



