---
title: "Grafika: Wykresy w MATLAB-ie z formatowaniem LaTeX"
description: "Tworzenie wykresów w MATLAB-ie z użyciem LaTeX do opisu osi, tytułów i legend."
date: 2026-03-22 07:00:00 +0100
categories: [Grafika, MATLAB]
tags: [matlab, latex, plots, tikz]
---

Dla grafików tworzenie grafiki jest naturalne, natomiast dla osób zajmujących się obliczeniami i modelowaniem stanowi odrębne wyzwanie.

Realizuję to poprzez kodowanie:

- wykresy tworzę w MATLAB-ie oraz w Pythonie (Matplotlib),
- stosuję interpreter LaTeX, żeby uzyskać skład tekstu spójny z resztą dokumentu,
- rysunki tworzę w TikZ (pakiet LaTeX do rysowania m.in. schematów elektrycznych i blokowych).

Pozwala to uzyskać wysoką jakość grafik z wykorzystaniem zapisu matematycznego i skryptowania.

W tym wpisie pokazuję przykład wykresu w MATLAB-ie, zawierający na jednym rysunku wszystkie najważniejsze elementy. Przykłady w Pythonie i TikZ opiszę osobno.

Osobnym tematem są nieco bardziej złożone rysunki: układy wielowykresowe (funkcja `subplot`), insety, podwójne osie (lewa i prawa oś Y) oraz bardziej zaawansowane formatowanie. Opiszę je w osobnych wpisach.

## Wykres tłumionego przebiegu oscylacyjnego w MATLAB-ie

Poniżej znajduje się przykładowy wykres zapisany jako grafika PNG do osadzenia w dokumencie.

Jest to wykres funkcji:

$$
i(t)=I_\mathrm{m}\cos(\omega t)\,\mathrm{e}^{-t/\tau},
$$

gdzie: $I_\mathrm{m}  = 1$ – maksymalna wartość amplitudy [p.u.], $f = 50$ – częstotliwość [Hz], $\omega = 2\pi f$ – częstotliwość kątowa [rad/s],
$\tau = 0.05$ – stała czasowa [s].


![Przebieg oscylacyjny tłumiony](/assets/posts/graphics-matlab-latex-plots/current_oscillatory_waveform.png)
***Rys. 1.** Przebieg oscylacyjny tłumiony.*

Pliki wykorzystane w przykładzie:

- [plik źródłowy MATLAB (.m)](/assets/posts/graphics-matlab-latex-plots/current_oscillatory_waveform.m),
- [wynikowy w wersji rastrowej (PNG)](/assets/posts/graphics-matlab-latex-plots/current_oscillatory_waveform.png),
- [wynikowy w wersji wektorowej (PDF)](/assets/posts/graphics-matlab-latex-plots/current_oscillatory_waveform.pdf).

## Kod MATLAB

Przykład wykresu zawierający najważniejsze elementy: przebieg, obwiednię, opisy osi, legendę.

Kluczowe ustawienie: interpreter LaTeX jako domyślny dla wszystkich elementów tekstowych.

Opis znajduje się bezpośrednio w komentarzach w kodzie.

```matlab
%% MATLAB settings
clc; clear; format compact;

%% Graphics settings
% Use LaTeX for axis labels, text, and legend
set(groot, ...
    'defaultAxesTickLabelInterpreter','latex', ...
    'defaultTextInterpreter','latex', ...
    'defaultLegendInterpreter','latex');

% Global graphics defaults for consistent appearance
set(groot, ...
    'defaultLineLineWidth',1.15, ...
    'defaultAxesFontSize',12, ...
    'defaultTextFontSize',12);

% Figure size: [left, bottom, width, height] in points
set(gcf, 'Units', 'points', 'Position', [200,150,500,200]);

%% Signal parameters
% Cosine current with exponentially decaying amplitude
Im  = 1;          % peak current amplitude
f   = 50;         % frequency [Hz]
w   = 2*pi*f;     % angular frequency [rad/s]
tau = 0.05;       % time constant [s]

%% Time vector and waveform definition
% Signal computed over 1 s
t = 0:1e-4:1;     

% Damped oscillatory current waveform
i = Im*cos(w*t).*exp(-t/tau);

% Positive exponential envelope
envelope = Im*exp(-t/tau);

%% Plot
% Color definitions
blueColor = [0.0000 0.4470 0.7410];
redColor  = [0.8500 0.3250 0.0980];

% Plot with handles
hp1 = plot(t, i, 'Color', blueColor); hold on; grid on;
hp2 = plot(t, envelope, '--', t, -envelope, '--');
set(hp2, 'Color', redColor);
hold off;

%% Axes limits
xlim([0 200]*1e-3); % Only initial transient part is displayed, 0-200 ms
ylim(1.19*[-1 1]);  % Approximately 1.2

%% Axis ticks and labels
% Time axis in milliseconds for easier interpretation
xtick_values = 0:20e-3:200e-3;
xticks(xtick_values);
xticklabels(num2str(xtick_values'*1e3));
xlabel('$t\:[\mathrm{ms}]$');

% Y-axis normalized to peak current Im
yticks([-1 0 1]);
yticklabels({'$-I_\mathrm{m}$','0','$I_\mathrm{m}$'});
ylabel('$i(t)$');

%% Title and legend
title('$i(t)=I_\mathrm{m}\cos(\omega t)\,\mathrm{e}^{-t/\tau}$');

legend([hp1 hp2(1)], ...
    {'$i(t)$', '$\pm\,I_\mathrm{m}\,\mathrm{e}^{-t/\tau}$'}, ...
    'Location','northeast');

%% Export figure
% PDF (vector graphics) – suitable for LaTeX documents
exportgraphics(gcf, 'current_oscillatory_waveform.pdf');

% PNG (raster graphics) – suitable for web use
exportgraphics(gcf, 'current_oscillatory_waveform.png', 'Resolution', 300);
```

## Domyślna paleta kolorów MATLAB (RGB)

Plik z domyślną paletą kolorów MATLAB dostępny jest [tutaj](/assets/posts/graphics-matlab-latex-plots/matlab_default_color_palette.m) (warto mieć ją pod ręką przy tworzeniu wykresów).

Fragment kodu:

``` matlab
%% MATLAB default color order (RGB)
% Order matches MATLAB default axes ColorOrder

blueColor       = [0.0000 0.4470 0.7410]; % blue
redColor        = [0.8500 0.3250 0.0980]; % red
yellowColor     = [0.9290 0.6940 0.1250]; % yellow
purpleColor     = [0.4940 0.1840 0.5560]; % purple
greenColor      = [0.4660 0.6740 0.1880]; % green
lightBlueColor  = [0.3010 0.7450 0.9330]; % light blue
darkRedColor    = [0.6350 0.0780 0.1840]; % dark red
```

Są to kolory używane domyślnie przez MATLAB dla kolejnych serii danych na wykresie.

Przykładowy wykres:

![Przebiegi oscylacyjne tłumione dla różnych stałych czasowych](/assets/posts/graphics-matlab-latex-plots/current_oscillatory_waveforms_color_order.png)
***Rys. 2.** Przebiegi oscylacyjne tłumione dla różnych stałych czasowych.*

Pliki wykorzystane w przykładzie:

- [plik źródłowy MATLAB (.m)](/assets/posts/graphics-matlab-latex-plots/current_oscillatory_waveforms_color_order.m),
- [wynikowy w wersji rastrowej (PNG)](/assets/posts/graphics-matlab-latex-plots/current_oscillatory_waveforms_color_order.png),
- [wynikowy w wersji wektorowej (PDF)](/assets/posts/graphics-matlab-latex-plots/current_oscillatory_waveforms_color_order.pdf).

## Uwagi

- Interpreter LaTeX w MATLAB-ie obsługuje tylko podzbiór składni LaTeX (nie jest to pełny LaTeX).
- Warto eksportować wykresy do PDF (format wektorowy), a nie tylko do PNG.

## Podsumowanie

Podejście skryptowe pozwala uzyskać powtarzalne i wysokiej jakości wykresy.

Koduję → rysuję → jest fajnie.