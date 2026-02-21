---
title: "Blog Jekyll: Statystyki bloga w motywie Chirpy – Liquid"
description: "Dodanie panelu statystyk w motywie Chirpy: liczba wpisów, kategorie, tagi oraz łączny czas czytania generowany statycznie przez Jekylla z użyciem Liquid."
date: 2026-02-24 07:00:00 +0100
categories: [Blog Jekyll]
tags: [jekyll, chirpy, liquid, config]
---

Na końcowym etapie tworzenia bloga pojawia się pytanie: co by tu jeszcze dodać.

Dobrze jest nie dodawać za dużo. Tyle, ile w sam raz.

Pomyślałem, że dodam w prawej kolumnie panel ze statystykami bloga:

-   liczba wpisów,
-   liczba kategorii,
-   liczba tagów,
-   łączny czas czytania wszystkich wpisów.

Efekt końcowy wygląda tak:

![Statystyki bloga](/assets/posts/jekyll-chirpy-blog-statistics/jekyll-chirpy-blog-statistics-pl.png)
***Fig. 1.** Statystyki bloga.*

Dodatkowo w jednym z wpisów umieściłem dynamiczną informację:

{% raw %}
```html
Ten blog ma już **{{ count }} {{ suffix }}**.
```
{% endraw %}

{% assign count = site.posts | size %}
{% assign mod100 = count | modulo: 100 %}
{% assign mod10 = count | modulo: 10 %}

{% if count == 1 %}
  {% assign suffix = "wpis" %}
{% elsif mod100 >= 12 and mod100 <= 14 %}
  {% assign suffix = "wpisów" %}
{% elsif mod10 >= 2 and mod10 <= 4 %}
  {% assign suffix = "wpisy" %}
{% else %}
  {% assign suffix = "wpisów" %}
{% endif %}

Wyświetla się tak: Ten blog ma już **{{ count }} {{ suffix }}**.

---

## Gdzie i jaki kod dodać

Plik:

``` text
_includes/update-list.html
```

Kod należy wkleić **nad** sekcją `<section id="access-lastmod">`:

{% raw %}
``` html
  <!-- MPS: Blog stats panel -->
  <section id="access-stats">
    <h2 class="panel-heading">Statystyki bloga</h2>

    {% assign posts_count = site.posts | size %}
    {% assign tags_count = site.tags | size %}
    {% assign categories_count = site.categories | size %}

    {% assign total_words = 0 %}
    {% for post in site.posts %}
      {% assign words = post.content | number_of_words %}
      {% assign total_words = total_words | plus: words %}
    {% endfor %}
    {% assign total_minutes = total_words | divided_by: 200 %}

    <ul class="content list-unstyled ps-0 pb-1 ms-1 mt-2">
      <li class="lh-lg d-flex justify-content-between">
        <span>Wpisy</span>
        <span><strong>{{ posts_count }}</strong></span>
      </li>

      <li class="lh-lg d-flex justify-content-between">
        <span>Kategorie</span>
        <span><strong>{{ categories_count }}</strong></span>
      </li>

      <li class="lh-lg d-flex justify-content-between">
        <span>Tagi</span>
        <span><strong>{{ tags_count }}</strong></span>
      </li>

      <li class="lh-lg d-flex justify-content-between">
        <span>Czas czytania (min)</span>
        <span><strong>{{ total_minutes }}</strong></span>
      </li>
    </ul>
  </section>
```
{% endraw %}

Łączny czas czytania obliczany jest na podstawie całkowitej liczby słów we wszystkich wpisach (`number_of_words`) przy założeniu średniej prędkości czytania 200 słów/min (Liquid: {% raw %}`{% assign total_minutes = total_words | divided_by: 200 %}`{% endraw %}).

Wersje językowe można zrealizować albo poprzez wykorzystanie danych z plików, np. `data/locales/pl.yml` i `data/locales/en.yml`, albo -- prościej (jak w moim przypadku) -- przez zakodowanie tych kilku etykiet bezpośrednio w plikach `_includes/update-list.html` w odpowiednich repozytoriach (`blog-pl` i `blog-en`).

---

## Kilka szczegółów technicznych

To rozwiązanie jest w pełni statyczne, więc nie ma wpływu na szybkość otwierania strony w przeglądarce:

-   obliczenia wykonywane są przez skrypty Liquid podczas builda (`jekyll serve` lub GitHub Pages),
-   wynik trafia do wygenerowanego HTML jako zwykły tekst,
-   użytkownik otrzymuje stronę statyczną.

To dla mnie jedna z największych zalet Jekylla: **wszystko generowane jest statycznie**.

Nie ma zapytań do bazy danych (np. `MySQL`), nie ma dynamicznych obliczeń po stronie użytkownika (choć można dodawać pluginy `JavaScript`).

A jak to wpływa na czas generacji strony przez generator Jekyll? 

Panel generowany jest podczas budowy strony przez Jekylla poprzez wykonanie kodu Liquid (`{% raw %}{% ... %}{% endraw %}`), więc blog pozostaje w pełni statyczny i nie wpływa to na szybkość jego działania.

---

## Podsumowanie

Rozwiązanie jest proste, czyste i w pełni zgodne z filozofią statycznego generatora stron.

To jest po prostu proste. I to jest super.
