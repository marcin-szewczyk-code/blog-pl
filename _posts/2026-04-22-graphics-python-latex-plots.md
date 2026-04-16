---
title: "Grafika: Wykresy w Pythonie (Matplotlib) z formatowaniem LaTeX"
description: "Tworzenie wykresów w Pythonie (Matplotlib) z użyciem LaTeX do opisu osi, tytułów i legend."
author: Marcin Szewczyk
date: 2026-04-22 07:00:00 +0100
categories: [Grafika, Python]
tags: [python, latex, plots]
---

Poprzednio pokazałem w jaki sposób wykonuję grafiki, skryptując je w MATLAB-ie. Teraz pokazuję analogiczne podejście w Pythonie. W obu przypadkach możliwe jest użycie LaTeX-a do opisu osi, tytułów i legend.

Python jest mocnym silnikiem obliczeniowym do wielu rzeczy, więc można w nim najpierw wykonać obliczenia, a następnie wygenerować wykresy.

<img src="/assets/posts/graphics-python-latex-plots/elon-rossum-python.png" width="400" alt="Power of Python">
***Rys. 1.** Power of Python. Źródło: X (Guido van Rossum, Elon Musk), 2026; zrzut ekranu (autor nieznany).*

Skryptowanie pozwala uzyskać wysoką jakość grafik z wykorzystaniem zapisu matematycznego i kodu.

W tym wpisie pokazuję przykład wykresu w Pythonie z użyciem biblioteki Matplotlib, zawierający na jednym rysunku wybrane najważniejsze elementy.


## Wykres tłumionego przebiegu oscylacyjnego w Pythonie

Poniżej znajduje się przykładowy wykres zapisany jako grafika PNG do osadzenia na stronie oraz jako plik PDF do osadzenia w dokumencie LaTeX.

Jest to wykres funkcji:

$$
i(t)=I_\mathrm{m}\cos(\omega t)\,\mathrm{e}^{-t/\tau}
$$

gdzie:

- $I_\mathrm{m}$ – amplituda dla $t=0$ [p.u.],
- $f$ – częstotliwość [Hz],
- $\omega = 2\pi f$ – częstotliwość kątowa [rad/s],
- $\tau$ – stała czasowa [s].

![Przebieg oscylacyjny tłumiony](/assets/posts/graphics-python-latex-plots/current_oscillatory_waveform.png)  
***Rys. 2.** Przebieg oscylacyjny tłumiony.*

Pliki wykorzystane w przykładzie:

- [plik źródłowy Python (.py)](/assets/posts/graphics-python-latex-plots/current_oscillatory_waveform.py),
- [wynikowy w wersji rastrowej (PNG)](/assets/posts/graphics-python-latex-plots/current_oscillatory_waveform.png),
- [wynikowy w wersji wektorowej (PDF)](/assets/posts/graphics-python-latex-plots/current_oscillatory_waveform.pdf).

## Kod Python

Przykład wykresu zawierający najważniejsze elementy: przebieg, obwiednię, opisy osi, legendę.

Kluczowe ustawienie: `text.usetex = True`, czyli użycie LaTeX do renderowania elementów tekstowych.

Opis znajduje się bezpośrednio w komentarzach w kodzie.

```python
# Imports
import numpy as np
import matplotlib.pyplot as plt

# Rendering settings (LaTeX + global style)
plt.rcParams.update({
    "text.usetex": True,
    "text.latex.preamble": r"\usepackage{amsmath}",
    "font.family": "serif",
    "axes.labelsize": 12,
    "font.size": 12,
    "legend.fontsize": 12,
    "xtick.labelsize": 12,
    "ytick.labelsize": 12,
    "lines.linewidth": 1.15
})

# Signal definition (damped cosine current)
Im  = 1
f   = 50
w   = 2 * np.pi * f
tau = 0.05

t = np.arange(0, 1 + 1e-4, 1e-4)

i = Im * np.cos(w * t) * np.exp(-t / tau)
envelope = Im * np.exp(-t / tau)

blueColor = (0.0000, 0.4470, 0.7410)
redColor  = (0.8500, 0.3250, 0.0980)

# Figure and Plot
plt.close('all')
fig = plt.figure(figsize=(500/72, 200/72), dpi=72)

hp1, = plt.plot(t, i, color=blueColor)
hp2, = plt.plot(t, envelope, '--', color=redColor)
plt.plot(t, -envelope, '--', color=redColor)

# Axes configuration
plt.grid(True)
plt.xlim(0, 200e-3)
plt.ylim(1.19 * np.array([-1, 1]))

# Ticks
xtick_values = np.arange(0, 200e-3 + 1e-9, 20e-3)
plt.xticks(xtick_values, [rf'${int(x*1e3)}$' for x in xtick_values])
plt.yticks([-1, 0, 1], [r'$-I_\mathrm{m}$', r'$0$', r'$I_\mathrm{m}$'])

# Labels
plt.xlabel(r'$t\:[\mathrm{ms}]$')
plt.ylabel(r'$i(t)$')

# Title
plt.title(r'$i(t)=I_\mathrm{m}\cos(\omega t)\,\mathrm{e}^{-t/\tau}$')

# Legend
plt.legend(
    [hp1, hp2],
    [r'$i(t)$', r'$\pm\,I_\mathrm{m}\,\mathrm{e}^{-t/\tau}$'],
    loc='upper right'
)

# Layout
plt.tight_layout()

# Export (vector PDF + raster PNG for web)
plt.savefig(
    'current_oscillatory_waveform.pdf',
    bbox_inches='tight',
    pad_inches=0
)

plt.savefig(
    'current_oscillatory_waveform.png',
    dpi=150,
    bbox_inches='tight',
    pad_inches=0
)
plt.show()
```

## Uwagi do przykładu

Kod jest bezpośrednim odpowiednikiem opisanego wcześniej przykładu z MATLAB-a, ale zapisanym w Pythonie z użyciem biblioteki Matplotlib.

Kilka praktycznych uwag:

- `NumPy` służy do obliczeń numerycznych,
- `Matplotlib` odpowiada za rysowanie wykresu,
- `plt.rcParams.update(...)` ustawia globalny styl wykresu,
- `text.usetex = True` pozwala używać składni LaTeX w podpisach osi, legendzie i tytule,
- `plt.savefig(...pdf)` zapisuje grafikę wektorową do pliku PDF do użycia w dokumencie LaTeX,
- `plt.savefig(...png)` zapisuje grafikę rastrową do pliku PNG do użycia np. na stronie webowej.

Warto zwrócić uwagę, że przy włączonym `usetex` Python korzysta z zewnętrznej instalacji LaTeX (kompilacja przez pdflatex). Oznacza to, że na lokalnym komputerze musi być dostępna działająca dystrybucja LaTeX (np. [https://www.tug.org/texlive/](https://www.tug.org/texlive/)).

## Podgląd wykresu obok kodu (VS Code)

W trakcie pracy wygodne jest jednoczesne wyświetlanie kodu i wygenerowanego wykresu.

Korzystam z prostego układu w VS Code:

1. Usuwam `plt.show()` ze skryptu (żeby nie otwierało się osobne okno).
2. Otwieram folder projektu (`Ctrl+Shift+E`).
3. Otwieram plik `.py`.
4. Dzielę edytor: `Split Right` (`Ctrl+\`), jest ikonka; możliwe jest też dzielenie w dół (`Split Down`).
5. W prawym panelu otwieram wygenerowany plik `.png`.

Po uruchomieniu skryptu plik graficzny jest nadpisywany, a podgląd w VS Code automatycznie się aktualizuje.

Powrót do jednego widoku (unsplit) przez standardowy skrót zamykania (`Ctrl+W`).

Pozwala to pracować w trybie: kod → uruchom → natychmiastowy podgląd, bez przełączania okien.

Tak to wygląda:

![Podgląd wykresu w VS Code](/assets/posts/graphics-python-latex-plots/vscode-preview.png)
***Rys. 3.** Podgląd wykresu w VS Code.*

## Uwagi

- Interpreter LaTeX w Matplotlib daje bardzo dobry efekt wizualny, ale wymaga działającej instalacji LaTeX.
- Do dokumentów technicznych warto eksportować wykresy do PDF, a nie tylko do PNG.

## Podsumowanie

Podejście skryptowe pozwala uzyskać powtarzalne i wysokiej jakości wykresy.

Koduję → rysuję → jest fajnie.
