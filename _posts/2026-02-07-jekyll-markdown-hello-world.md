---
title: "Blog Jekyll (2/6): Jak robić wpisy na blogu – Markdown „Hello World” w Jekyllu"
date: 2026-02-07 07:00:00 +0100
categories: [Blog]
tags: [blog, jekyll, hello-world]
---

W Jekyllu jest parę fajnych rzeczy, a pierwsza to, że blog jest statyczny i budowany z wpisów robionych w języku Markdown. Pokażę tutaj przykład wpisu "Hello World", czyli kilka elementów, których najbardziej używam.

Treść bloga budowana jest przez Jekylla jako strona statyczna wystawiana przez GitHuba. To, co edytuję, to zwykłe pliki tekstowe w Markdown, z prostą składnią. Poniżej pokazuję podstawowe elementy, których używam: nagłówki, listy, kody i linki. Tyle wystarczy, żeby napisać i opublikować wpis. Do tego dochodzą metadane z tytułem, datą, kategorią i tagami.

Jekyll dba o to, żeby wpisy pojawiały się dopiero wtedy, gdy nadejdzie ich data. Dzięki temu można łatwo planować publikację wpisów z zaplanowanym rytmem.

Wpisy zapisuję w lokalnym folderze `_posts`, w plikach o super wygodnym formacie nazwy, czyli data `yyyy-mm-dd`, potem nazwa i rozszerzenie `.md`. Na przykład: `2026-02-07-jekyll-markdown-hello-world.md`.

Gdy dokładam w lokalnym folderze `_posts` kolejne pliki `.md`, to są one widoczne od razu lokalnie na `127.0.0.1:4000`, a na blogu po zrobieniu `commit` i `push`.

Czyli tworzę plik `.md`, zapisuję go lokalnie w `_posts`, robię `commit` i `push` - a wpis wypychany jest do repo i pojawia się zgodnie z datą.

## Wpis "Hello World" w Markdown

### Metadane (front matter / head)

Na początku jest front matter (nagłówek), który zawiera metadane rozpoznawane przez Jekylla.

```yaml
---                                      # Początek front matter
title: "Hello-world markdown for Jekyll" # Wyświetlany jako nagłówek strony
post_id: jekyll-markdown-hello-world     # Własny identyfikator wpisu (niestandardowe pole, używam do rysunków)
date: 2026-02-06 08:00:00 +0100          # Data i godzina publikacji wpisu; Jekyll używa jej do sortowania i publikacji
categories: [Blog]                       # Kategoria wpisu (lub lista kategorii)
tags: [blog, jekyll]                     # Lista tagów do oznaczania tematów wpisu i późniejszego filtrowania
---                                      # koniec front matter
```

### Konwencja struktury katalogów

Wpisy umieszczam w katalogu "specjalnym" Jekylla `_posts`, nazwa pliku to np. `2026-02-07-jekyll-markdown-hello-world.md`.

W każdym wpisie używam pola `post_id`, np.:

```yaml
post_id: jekyll-markdown-hello-world
```

Wszystkie materiały powiązane z danym wpisem trzymam w osobnym katalogu:

```text
assets/
└── posts/
    └── jekyll-markdown-hello-world/
        ├── cauchy.png
        ├── wykres.svg
        ├── dane.csv
        └── cauchy.pdf
```

W tym katalogu umieszczam wszystkie pliki dotyczące wpisu: grafiki, pliki PDF, dane pomocnicze itp.

W treści wpisu odwołuję się do nich przez ścieżkę budowaną z użyciem `post-id`, np. (bez "!"):

{% raw %}
```markdown
[Podpis](/assets/posts/jekyll-markdown-hello-world/cauchy.png)
```
{% endraw %}

### Treść wpisu (content / body)

Treść wpisu zaczyna się bezpośrednio po Metadanych.

Tekst to zwykły tekst, np. "Zrobiłem bloga, więc powstała kwestia, co napisać, żeby blog miał jakiś wpis" .

Formatowanie tekstu: **pogrubienie**, *pochylenie (kursywa)*,
***pogrubienie i pochylenie***, ***pogrubienie** i pochylenie*.

````markdown
Formatowanie tekstu: **pogrubienie**, *pochylenie (kursywa)*,
***pogrubienie i pochylenie***, ***pogrubienie** i pochylenie*.
````

### Linki

Tak robi się [taki link](https://marcinszewczyk.net/):

```markdown
[taki link](https://marcinszewczyk.net/)
```

### Nagłówki

Są używane do spisu treści, kotwic i SEO (*Search Engine Optimization*):

```markdown
# Nagłówek poziomu 1
## Nagłówek poziomu 2
### Nagłówek poziomu 3
```

### Rysunki

Taki rysunek:

![Twierdzenie Cauchy’ego](/assets/posts/jekyll-markdown-hello-world/cauchy.png)
***Rys. 1.** Interpretacja geometryczna twierdzenia Cauchy’ego.*

Taki kod:

{% raw %}
```markdown
<!-- uwaga na brak pustej linii pomiędzy rysunkiem a podpisem! -->
![Twierdzenie Cauchy’ego](/assets/posts/jekyll-markdown-hello-world/cauchy.png)
***Rys. 1.** Interpretacja geometryczna twierdzenia Cauchy’ego.*
```
{% endraw %}

Link do plików: analogicznie, tylko bez "!".

### Listy

Lista punktowana:
- element listy
- **tekst** - pogrubienie
- `tekst` - kod inline

```markdown
- element listy
- **tekst** - pogrubienie
- `tekst` - kod inline
```

Lista numerowana:
1. element listy
2. **tekst** - pogrubienie
3. `tekst` - kod inline


```markdown
1. element listy
2. **tekst** - pogrubienie
3. `tekst` - kod inline
```

### Kod

Można wpisywać *inline code*:

```markdown
`inline code`
```

Można też wstawiać bloki kodu.

Kod *bash*:

````markdown
```bash
git clone https://github.com/...
```
````

Wynik:

```bash
git clone https://github.com/...
```

Kod *markdown*:

````markdown
```markdown
title: "Hello-world markdown for Jekyll"
...
```
````

Wynik:

```markdown
title: "Hello-world markdown for Jekyll"
...
```

Kod Python:

````markdown
```python
print("Hello, world!")
...
```
````

Wynik:

```python
print("Hello, world!")
...
```

Kod C:

```c
#include <stdio.h>

int main(void) {
    printf("Hello, world!\n");
    return 0;
}
```
Kod LaTeX:

```latex
\documentclass{article}

\begin{document}

Hello, world!

\end{document}
```
