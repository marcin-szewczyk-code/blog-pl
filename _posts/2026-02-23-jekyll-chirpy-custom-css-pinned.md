---
title: "Blog Jekyll: Modyfikacja stylu CSS w motywie Chirpy na przykładzie przypiętych wpisów"
description: "Jak w motywie Chirpy dodać własny plik custom.css i wyróżnić przypięte wpisy bez modyfikowania plików motywu."
date: 2026-02-23 07:00:00 +0100
categories: [Blog Jekyll-Chirpy]
tags: [jekyll, chirpy, css, config]
---

Wygląd bloga można modyfikować przez dodanie własnego pliku CSS (np. `assets/css/custom.css`) i załadowanie go w `_includes/head.html` po 
CSS motywu, aby nadpisać jego style.

Kluczowe jest ustalenie, jaki selektor należy zmodyfikować.

W przypadku pinned posts, w motywie Chirpy przypięte wpisy nie zawsze mają klasę
`.pinned`. W mojej konfiguracji pinned jest oznaczony ikoną pinezki z Font Awesome:

``` html
<i class="fas fa-thumbtack fa-fw"></i>
```

**Jak znaleźć właściwy selektor.** Najprościej skorzystać z narzędzi deweloperskich przeglądarki: kliknij PPM (prawy przycisk myszy) na ikonę pinezki przy pinned post i  wybierz Zbadaj / Inspect. Następnie w panelu Elements sprawdź klasę ikony (np. `.fa-thumbtack`) oraz element nadrzędny (np. `a.post-preview`).

Następnie należy utworzyć i podłączyć własny plik CSS.

---

## Krok 1: modyfikacja _includes/head.html

W pliku:

``` text
_includes/head.html
```

znajdź sekcję:

``` html
<!-- Theme style -->
<link rel="stylesheet" href="{{ '/assets/css/:THEME.css' | replace: ':THEME', site.theme | relative_url }}">
```

Bezpośrednio pod nią dodaj:

``` html
<!-- Custom overrides -->
<link rel="stylesheet" href="{{ '/assets/css/custom.css' | relative_url }}">
```

Ważne: plik musi być ładowany **po** CSS motywu, aby nadpisania działały.

---

## Co jeśli nie masz _includes/head.html?

Jeśli korzystasz z wersji gem-based Chirpy, pliki `_includes` pochodzą z
motywu i nie są widoczne w repozytorium.

Jekyll nadpisuje pliki motywu plikami o tej samej ścieżce w projekcie.

W takim przypadku:

1.  Otwórz repozytorium motywu (GitHub: chirpy-starter lub jekyll-theme-chirpy).
2.  Skopiuj plik `_includes/head.html` z motywu.
3.  Wklej go do swojego projektu w katalogu:

```html
    _includes/head.html
```

Jekyll automatycznie nadpisze wersję z motywu lokalną kopią.

## Krok 2: plik assets/css/custom.css

Utwórz plik z własnym CSS:

``` text
assets/css/custom.css
```

Zawartość:

``` css
/* =========================================
   Custom CSS overrides for Chirpy
   ========================================= */

/* Pinned post — wykrycie przez ikonę pinezki */
a.post-preview:has(i.fa-thumbtack) {
  border-left: 3px solid #2563eb;
  padding-left: 1rem;
}

/* Dark mode */
[data-mode="dark"] a.post-preview:has(i.fa-thumbtack) {
  border-left-color: #9ca3af;
}
```

Selektor `:has()` pozwala stylować kartę posta na podstawie tego, że
**zawiera** ikonę `.fa-thumbtack`.

---

## Uwaga o cache

Przeglądarka często trzyma poprzednią wersję CSS. Po deployu wykonaj twarde odświeżenie strony (Ctrl + Shift + R).

W rzadkich przypadkach konieczne może być dodatkowo wyłączenie cache w DevTools (włącza się ponownie po zamknięciu DevTools):

-   DevTools (F12) → Network → Disable cache
-   Ctrl + Shift + R

---

## Podsumowanie

Najczystsza architektura modyfikacji stylów w Chirpy:

1.  Dodać własny plik `assets/css/custom.css`
2.  Załadować go w `_includes/head.html` **po** CSS motywu

Są to tylko nadpisania -- bez ingerencji w strukturę motywu.

To rozwiązanie jest minimalne, stabilne i odporne na przyszłe aktualizacje motywu.
