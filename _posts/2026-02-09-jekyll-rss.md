---
title: "Blog Jekyll: Subskrypcja RSS i modyfikacja panelu bocznego oraz topbara"
description: "Konfiguracja RSS w Jekyll (Chirpy): własna strona /rss/, modyfikacja panelu bocznego i topbara."
date: 2026-02-09 07:00:00 +0100
categories: [Blog Jekyll]
tags: [blog, jekyll, google-analytics, rss, setup]
---

RSS (Really Simple Syndication) to standardowy format XML umożliwiający śledzenie aktualizacji stron internetowych w czytnikach RSS. Nowe wpisy pojawiają się w nich automatycznie po publikacji.

Rozwiązanie to jest szczególnie przydatne w przypadku mniejszych, niezależnych stron internetowych, które nie korzystają z wbudowanych systemów subskrypcji (np. newslettera czy powiadomień e-mail).

RSS jest przydatny, żeby czytelnicy (i agregatory treści) wiedzieli, że na blogu pojawił się nowy wpis.

## Konfiguracja RSS w Jekyll + Chirpy

Jekyll generuje kanał **RSS** automatycznie (za pomocą wtyczki `jekyll-feed`), a motyw Chirpy ma tę funkcjonalność włączoną domyślnie.

Kanał (feed) RSS bloga dostępny jest pod adresem:

👉 [https://blog.marcinszewczyk.net/feed.xml](https://blog.marcinszewczyk.net/feed.xml)

Po otwarciu widoczny jest kod pliku XML (to normalne). Kanał jest przeznaczony dla czytników RSS, a nie do bezpośredniego czytania w przeglądarce.

Jeśli blog jest publikowany przez GitHub Pages, nie jest wymagana dodatkowa konfiguracja (nie trzeba włączać wtyczki `jekyll-feed` w pliku `_config.yml`).

Każdy nowy wpis:
- pojawia się automatycznie w pliku `feed.xml`
- może zostać odczytany przez czytniki RSS
- umożliwia subskrypcję bloga bez newslettera

### Dodanie ikonki „Subskrybuj RSS”

Dodatkowo można umieścić ikonkę „Subskrybuj RSS” w różnych miejscach interfejsu.

U mnie umieściłem ją:

- w panelu bocznym bloga (sidebar), przez dodanie kodu HTML do pliku `_includes/sidebar.html`
- w górnym pasku nawigacyjnym (topbar), przez dodanie kodu HTML do pliku `_includes/topbar.html`

Pliki `_includes/sidebar.html` i `_includes/topbar.html` skopiowałem z gema standardową metodą.

Najpierw sprawdzenie ścieżki do gema:

```bash
bundle show jekyll-theme-chirpy
```

Następnie skopiowanie plików:

```bash
copy "E:\Ruby34-x64\lib\ruby\gems\3.4.0\gems\jekyll-theme-chirpy-7.4.1\_includes\sidebar.html" "_includes\sidebar.html"
copy "E:\Ruby34-x64\lib\ruby\gems\3.4.0\gems\jekyll-theme-chirpy-7.4.1\_includes\topbar.html" "_includes\topbar.html"
```

Od tego momentu lokalne wersje plików nadpisują wersje z gema i można je modyfikować.

### Kod w panelu bocznym (_includes/sidebar.html)

Dodałem:

```html
<a class="text-muted text-decoration-none"
  href="{{ '/rss/' | relative_url }}"
    aria-label="Subskrybuj RSS"
    title="Subskrybuj RSS">RSS
  <i class="fas fa-rss"></i>
</a>
```

### Kod w topbarze (`_includes/topbar.html`)

Dodałem:

```html
<span>
  <a class="text-muted text-decoration-none"
     href="{{ '/rss/' | relative_url }}"
     aria-label="Subskrybuj RSS"
     title="Subskrybuj RSS">
    <i class="fas fa-rss"></i> Subskrybuj RSS
  </a>
</span>
```

Przy czym ten ostatni fragment kodu wstawiłem w dwóch miejscach:

- po warunku:

{% raw %}
```liquid
{% if paths.size == 0 or page.layout == 'home' %}
```
{% endraw %}

- oraz po warunku:
 
{% raw %}
```liquid
{% if forloop.first %}
```
{% endraw %}

### Strona „Subskrybuj RSS”

Linki, które wstawiłem do plików `_includes/sidebar.html` i `_includes/topbar.html`, nie wskazują na surowy feed (dostępny domyślnie pod adresem [https://blog.marcinszewczyk.net/feed.xml](https://blog.marcinszewczyk.net/feed.xml)), tylko na stronę `_pages/rss.md`.

Stronę tę stworzyłem umieszczając plik `rss.md` w katalogu `_pages/`.

Treść tej strony:

```markdown
---
layout: page
title: Subskrybuj RSS
permalink: /rss/
---

Ten blog ma kanał **RSS (Atom)**, który możesz dodać do czytnika...

...
```

Efekt można zobaczyć tutaj:

👉 [https://blog.marcinszewczyk.net/rss/](https://blog.marcinszewczyk.net/rss/)

Poniżej przykład, jak wygląda kanał RSS tego bloga w aplikacji RSS na iPhone:

![Widok kanału RSS bloga w czytniku na iPhone](/assets/posts/jekyll-rss/rss-feed-in-app.jpg)
***Rys. 2.** Widok kanału RSS bloga w czytniku na iPhone.*

## Podsumowanie

Robię → działa → jest fajnie.
