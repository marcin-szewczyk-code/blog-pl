---
title: "Blog Jekyll: Google Analytics i modyfikacja stopki"
description: "Podłączenie Google Analytics 4 (GA4) w blogu Jekyll z motywem Chirpy: ustawienia _config.yml, strona z polityką prywatności oraz modyfikacja stopki."
date: 2026-02-10 07:00:00 +0100
categories: [Blog Jekyll]
tags: [blog, jekyll, google-analytics, rss, setup]
---

Na koniec warto podpiąć **Google Analytics (GA4)**, żeby wiedzieć, czy ten blog czyta też ktoś inny niż autor.

W Jekyllu z motywem Chirpy robi się to w trzech krokach:
1. konfiguracja **Google Analytics (GA4)**
2. powiązanie **GA4** z **Jekyllem** przez plik `_config.yml`
3. dodanie informacji w stopce (`_includes/footer.html`, link do polityki prywatności)

## Konfiguracja GA4 w panelu Google

Kroki w panelu Google:
- wchodzę na stronę [https://analytics.google.com/](https://analytics.google.com/) i loguję się kontem Google
- tworzę nowe Property, o nazwie np. `blog.marcinszewczyk.net`, strefa czasowa *Polska*, waluta *PLN*
- jako platformę wybieram *Web*, URL strony: `https://blog.marcinszewczyk.net`
- nadaję nazwę strumieniowi danych, np. *Blog*
- kopiuję **Measurement ID**, w formacie: `G-XXXXXXXXXX`

Identyfikator **G-XXXXXXXXXX** jest jedyną informacją z Google Analytics 4 wymaganą przez motyw Chirpy.

## Konfiguracja GA4 w Jekyll + Chirpy

### Konfiguracja pliku  `_config.yml`

W pliku `_config.yml` dodaję:

```yml
# Web Analytics Settings
analytics:
  google: 
    id: "G-XXXXXXXXXX" # fill in your Google Analytics ID
```

To wszystko. Motyw **Chirpy** sam generuje odpowiedni kod dla GA4.

### Strona z polityką prywatności

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

### Konfiguracja plików _data/locales/pl.yml i _data/locales/en.yml

Potrzebna jest konfiguracja plików językowych `_data/locales/pl.yml` i `_data/locales/en.yml` w celu umieszczenia w nich danych które zostaną użyte w stopcje.

W pliku `_data/locales/pl.yml` zmieniam pole `meta`:

```yml
meta: "Generator: :PLATFORM · Motyw: :THEME · Licencja: :COPYRIGHT · Analityka: :PRIVACY"
```

W pliku `_data/locales/en.yml` zmieniam pole `meta`:

```yml
meta: "Generator: :PLATFORM · Theme: :THEME · License: :COPYRIGHT · Analytics: :PRIVACY"
```

### Konfiguracja stopki _includes/footer.html

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
  | replace: ':COPYRIGHT', _license
  | replace: ':PRIVACY', _privacy
}}
```
{% endraw %}

Powyżej tego kodu dodaję definicję zmiennych `_privacy` i `_license`:

{% raw %}
```markdown
{%- capture _privacy -%}
  <a href="{{ '/privacy/' | relative_url }}">GA4</a>
{%- endcapture -%}

{%- capture _license -%}
  <a href="{{ '/legal/' | relative_url }}">Copyright</a>
{%- endcapture -%}
```
{% endraw %}

Efektem jest zmodyfikowana stopka bloga:
  
<!--
![Stopka bloga w języku polskim](/assets/posts/jekyll-google-analytics/footer-pl.png)
***Rys. 1.** Stopka bloga w języku polskim.*

![Stopka bloga w języku angielskim](/assets/posts/jekyll-google-analytics/footer-en.png)
***Rys. 2.** Stopka bloga w języku angielskim.*
-->

## Test zbierania danych

Na koniec testuję w panelu Google Analytics (Reports → Realtime).

## Podsumowanie

Na tym etapie blog:
- zbiera statystyki (GA4)
- udostępnia feed RSS
- pozostaje w pełni statyczny

Czyli jest fajnie.