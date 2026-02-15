---
title: "Blog Jekyll (5/6): Google Analytics i RSS"
date: 2026-02-10 07:00:00 +0100
categories: [Blog]
tags: [blog, jekyll, google-analytics, rss, setup]
---

Na koniec warto podpiąć **Google Analytics (GA4)**, żeby wiedzieć, czy ten blog czyta też ktoś inny niż autor.

A także RSS, żeby czytelnicy (i agregatory treści) wiedzieli, że pojawił się nowy wpis.

## Konfiguracja Google Analytics 4 (GA4)

W Jekyllu z motywem Chirpy robi się to w trzech krokach:
1. konfiguracja **Google Analytics (GA4)**
2. powiązanie **GA4** z **Jekyllem** przez plik `_config.yml`
3. dodanie informacji w stopce (`_includes/footer.html`, link do polityki prywatności)

### Konfiguracja GA4 w panelu Google

Kroki w panelu Google:
- wchodzę na stronę [https://analytics.google.com/](https://analytics.google.com/) i loguję się kontem Google
- tworzę nowe Property, o nazwie np. `blog.marcinszewczyk.net`, strefa czasowa *Polska*, waluta *PLN*
- jako platformę wybieram *Web*, URL strony: `https://blog.marcinszewczyk.net`
- nadaję nazwę strumieniowi danych, np. *Blog*
- kopiuję **Measurement ID**, w formacie: `G-XXXXXXXXXX`

Identyfikator **G-XXXXXXXXXX** jest jedyną informacją z Google Analytics 4 wymaganą przez motyw Chirpy.

### Konfiguracja GA4 w Jekyll + Chirpy

#### Konfiguracja pliku  `_config.yml`

W pliku `_config.yml` dodaję:

```yml
# Web Analytics Settings
analytics:
  google: 
    id: "G-XXXXXXXXXX" # fill in your Google Analytics ID
```

To wszystko. Motyw **Chirpy** sam generuje odpowiedni kod dla GA4.

#### Strona z polityką prywatności

Po podpięciu Google Analytics do Jekylla dodaję stronę z informacją o przetwarzaniu danych.

Tworzę stronę `_pages/privacy.md` o przykładowej treści:

```markdown
---
title: Polityka prywatności
layout: page
permalink: /privacy/
---

Strona wykorzystuje Google Analytics (GA4) w celu statystycznym
(zliczanie odsłon i ogólne informacje o korzystaniu).

Dane zbierane przez Google Analytics są przetwarzane zgodnie z polityką
Google: [https://policies.google.com/privacy](https://policies.google.com/privacy).

Strona nie wykorzystuje danych do profilowania ani celów marketingowych.
```

Dodaję ją do pliku `_config.yml`, dopisując poniżej sekcji `tabs`:

```yml
# tabs and pages collections (Chirpy)
collections:
  tabs:
    output: true
    sort_by: order
  pages:
    output: true
    permalink: /:path/
```

### Konfiguracja pliku _data/locales/pl.yml

W pliku `_data/locales/pl.yml` zmieniam pole `meta`:

```yml
meta: "Powered by :PLATFORM · Motyw: :THEME · :PRIVACY"
```

#### Konfiguracja stopki _includes/footer.html

Chirpy pozwala dostosować stopkę poprzez skopiowanie pliku `footer.html` z motywu do lokalnego projektu.

Najpierw sprawdzam lokalną ścieżkę do motywu Chirpy:

```bash
bundle info jekyll-theme-chirpy
```

Następnie kopiuję plik stopki `_includes/footer.html` z motywu do projektu:

```bash
copy ^
"E:\Ruby34-x64\lib\ruby\gems\3.4.0\gems\jekyll-theme-chirpy-7.4.1\_includes\footer.html" ^
"_includes\footer.html"
```

W pliku `_includes/footer.html` zakomentowuję (`<!-- ... -->`) linię:

{% raw %}
```markdown
{{ site.data.locales[include.lang].meta
  | replace: ':PLATFORM', _platform
  | replace: ':THEME', _theme
}}
```
{% endraw %}

i zastępuję ją wersją rozszerzoną:

{% raw %}
```markdown
{{ site.data.locales[include.lang].meta
    | replace: ':PLATFORM', _platform
    | replace: ':THEME', _theme
    | replace: ':PRIVACY', _privacy
}}
```
{% endraw %}

Powyżej tego kodu dodaję definicję zmiennej `_privacy`:

{% raw %}
```markdown
{%- capture _privacy -%}
  Prywatność: <a href="{{ '/privacy/' | relative_url }}">Google Analytics</a>
{%- endcapture -%}
```
{% endraw %}

Efektem jest zmodyfikowana stopka bloga:
  
![Stopka bloga](/assets/posts/jekyll-google-analytics-and-rss/footer.png)
***Rys. 1.** Stopka bloga.*

### Test zbierania danych

Na koniec testuję w panelu Google Analytics (Reports → Realtime).

Robię → działa → jest fajnie.

## Konfiguracja RSS w Jekyll + Chirpy

Jekyll generuje kanał **RSS** automatycznie (za pomocą wtyczki `jekyll-feed`), a motyw Chirpy ma tę funkcjonalność włączoną domyślnie.

Kanał (feed) RSS tego bloga dostępny jest pod adresem:

👉 [https://blog.marcinszewczyk.net/feed.xml](https://blog.marcinszewczyk.net/feed.xml)

Jeśli blog jest publikowany przez GitHub Pages, nie jest wymagana dodatkowa konfiguracja (nie trzeba włączać wtyczki `jekyll-feed` w pliku `_config.yml`).

Każdy nowy wpis:
- pojawia się automatycznie w pliku `feed.xml`
- może zostać odczytany przez czytniki RSS
- umożliwia subskrypcję bloga bez newslettera

### Dodanie ikonki „Subskrybuj RSS”

Dodatkowo można umieścić ikonkę „Subskrybuj RSS” w różnych miejscach interfejsu.

U mnie umieściłem ją:

- w stopce bloga (footer), przez dodanie kodu HTML do pliku `_includes/footer.html`
- w górnym pasku nawigacyjnym (topbar), przez dodanie kodu HTML do pliku `_includes/topbar.html`

Plik `_includes/footer.html` miałem już wcześniej skopiowany z gema przy okazji modyfikowania stopki.

Plik `_includes/topbar.html` skopiowałem z gema standardową metodą.

Najpierw sprawdzenie ścieżki do gema:

```bash
bundle show jekyll-theme-chirpy
```

Następnie skopiowanie pliku:

```bash
copy "E:\Ruby34-x64\lib\ruby\gems\3.4.0\gems\jekyll-theme-chirpy-7.4.1\_includes\topbar.html" "_includes\topbar.html"
```

Od tego momentu lokalne wersje plików nadpisują wersje z gema i można je modyfikować.

### Kod w stopce (`_includes/footer.html`)

Dodałem:

```html
<span class="ms-3">
  <a href="/rss/">
    <i class="fas fa-rss"></i> Subskrybuj RSS
  </a>
</span>
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

Linki, które wstawiłem do plików `_includes/footer.html` i `_includes/topbar.html`, nie wskazują na surowy feed (dostępny domyślnie pod adresem [https://blog.marcinszewczyk.net/feed.xml](https://blog.marcinszewczyk.net/feed.xml)), tylko na stronę `_pages/rss.md`.

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

![Widok kanału RSS bloga w czytniku na iPhone](/assets/posts/jekyll-google-analytics-and-rss/rss-feed-in-app.jpg)
***Rys. 2.** Widok kanału RSS bloga w czytniku na iPhone.*

Robię → działa → jest fajnie.

## Podsumowanie

Na tym etapie blog:
- zbiera statystyki (GA4)
- udostępnia feed RSS
- pozostaje w pełni statyczny

Czyli jest fajnie.