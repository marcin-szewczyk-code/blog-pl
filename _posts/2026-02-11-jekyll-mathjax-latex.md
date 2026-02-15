---
title: "Blog Jekyll (6/6): MathJax do wzorów matematycznych LaTeX"
date: 2026-02-11 07:00:00 +0100
categories: [Blog]
tags: [blog, jekyll, latex, setup]
---

W Jekyllu jest parę fajnych rzeczy, a jedną z nich jest możliwość umieszczania wzorów LaTeX w plikach Markdown.

Ponoć najpopularniejszy jest **MathJax**, więc go używam.

## Konfiguracja MathJax

### Dodanie biblioteki MathJax

Jest to biblioteka JavaScript i wystarczy wstawić jej kod do bloku `<head></head>` w odpowiednim pliku:

```html
<head>

<!-- inne elementy head -->

  <!-- MathJax v3 -->
  <script>
    window.MathJax = {
      tex: {
        inlineMath: [['$', '$'], ['\\(', '\\)']],
        displayMath: [['$$', '$$'], ['\\[', '\\]']],
        processEscapes: true
      },
      options: {
        skipHtmlTags: ['script', 'noscript', 'style', 'textarea', 'pre', 'code']
      }
    };
  </script>
  <script defer src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js"></script>
</head>
```

Pozostaje tylko znaleźć właściwy plik, do którego należy wstawić ten kod.

### Gdzie wstawić ten kod

Sprawdziłem w `_config.yml` pole `theme`:

```markdown
theme: jekyll-theme-chirpy
```

Oznacza to, że używam motywu `jekyll-theme-chirpy`, który nie ma lokalnego katalogu `_layouts`, bo layouty są dostarczane przez gem (bibliotekę) motywu.

Chirpy pozwala nadpisywać fragmenty layoutu przez katalog `_includes`.

W katalogu projektu tworzę plik `_includes/head.html`:

```bash
mkdir -p _includes
touch _includes/head.html
```

Kopiuję oryginalny `head.html` z Chirpy do mojego projektu. Najpierw sprawdzam, gdzie jest zainstalowany gem:

```bash
bundle info jekyll-theme-chirpy
```

Dostaję ścieżkę, na przykład:

```bash
E:\Ruby34-x64\lib\ruby\gems\3.4.0\gems\jekyll-theme-chirpy-7.4.1
```

Podstawiam tę ścieżkę i kopiuję plik:

```bash
copy "E:\Ruby34-x64\lib\ruby\gems\3.4.0\gems\jekyll-theme-chirpy-7.4.1\_includes\head.html" "_includes\head.html"
```
Na koniec dodaję kod MathJax do `_includes/head.html`, w sekcji `<head></head>`, na przykład tuż przed `</head>`.

Mogę teraz używać wzorów LaTeX.

## Użycie LaTeX w plikach Markdown

### Wzory w tekście (inline math)

Wzór w tekście: $e^{i x} = \cos{x} + i\sin{x}$.

Kod:

```markdown
$e^{i x} = \cos{x} + i\sin{x}$
```

### Wzory wyodrębnione (display math)

Wzór:

$$
\int_0^\infty e^{-x^2}\,dx = \frac{\sqrt{\pi}}{2}
$$

Kod:

```markdown
$$
\int_0^\infty e^{-x^2}\,dx = \frac{\sqrt{\pi}}{2}
$$
```

Wzór:

$$
\left\{\begin{align}
a^2 + b^2 &= c^2 \\
e^{i\pi} + 1 &= 0
\end{align}\right.
$$

Kod:

```markdown
$$
\left\{\begin{align}
a^2 + b^2 &= c^2 \\
e^{i\pi} + 1 &= 0
\end{align}\right.
$$
```

Robię → działa → jest fajnie.