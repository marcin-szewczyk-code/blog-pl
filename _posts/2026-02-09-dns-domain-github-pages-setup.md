---
title: "Blog Jekyll (4/6): Konfiguracja domeny i GitHub Pages – DNS, HTTPS i przekierowania"
date: 2026-02-09 07:00:00 +0100
categories: [Blog]
tags: [blog, jekyll, setup]
---

Kolejny etap budowy bloga to konfiguracja domeny u operatora oraz GitHub Pages po stronie repozytorium. Dzięki temu blog jest dostępny pod własnym adresem, z poprawnymi przekierowaniami i HTTPS.

## Założenia

Przyjmuję taką konfigurację:

- domena główna: [https://marcinszewczyk.net/](https://marcinszewczyk.net/)
- domena główna przekierowuje (HTTP 301) na adres bloga: [https://blog.marcinszewczyk.net/](https://blog.marcinszewczyk.net/)
- blog technicznie jest serwowany przez GitHub Pages pod adresem: [https://marcin-szewczyk-code.github.io/](https://marcin-szewczyk-code.github.io/)
- docelowo jedynym adresem bloga ma być [https://blog.marcinszewczyk.net/](https://blog.marcinszewczyk.net/)

## Przekierowanie domeny głównej

W panelu operatora domeny przechodzimy do ustawień: Domains → marcinszewczyk.net → Redirection.

Konfigurujemy przekierowanie typu *Permanent (301, visible)*.

Przekierowanie domeny głównej:
- Source: [https://marcinszewczyk.net/](https://marcinszewczyk.net/)
- Redirection type: Permanent visible redirection (301)
- HTTP code: Permanent (301)
- Target URL: [https://blog.marcinszewczyk.net/](https://blog.marcinszewczyk.net/)

Analogiczne przekierowanie konfigurujemy dla subdomeny www: [https://www.marcinszewczyk.net/](https://www.marcinszewczyk.net/).

Te przekierowania powodują, że wejście na [https://marcinszewczyk.net/](https://marcinszewczyk.net/) lub [https://www.marcinszewczyk.net/](https://www.marcinszewczyk.net/) zmienia adres w pasku przeglądarki na [https://blog.marcinszewczyk.net/](https://blog.marcinszewczyk.net/).

Czas propagacji: kilka do kilkudziesięciu minut (czasem dłużej).

![konfiguracja przekierowań w panelu operatora domeny](/assets/posts/dns-github-pages/domain-redirections.png)
***Rys. 1.** Ekran konfiguracji przekierowań w panelu operatora domeny.*

## Konfiguracja DNS dla subdomeny blog

Po ustawieniu przekierowań przechodzimy w panelu dostawcy domeny do: Domains → marcinszewczyk.net → DNS Zone.

Dodajemy rekord DNS typu CNAME:
- Subdomain: blog
- Type: CNAME
- TTL: 300
- Target: marcin-szewczyk-code.github.io. (uwaga: końcowa kropka jest poprawna)

Rekord `CNAME` oznacza, że: `blog.marcinszewczyk.net` jest aliasem wskazującym bezpośrednio na adres GitHub Pages: `https://marcin-szewczyk-code.github.io/`.

Od tej chwili DNS kieruje ruch z `blog.marcinszewczyk.net` bezpośrednio do GitHub Pages.

Końcowa kropka w nazwie docelowej jest poprawna.

![Konfiguracja DNS w panelu operatora domeny](/assets/posts/dns-github-pages/domain-dns.png)
***Rys. 2.** Ekran konfiguracji DNS w panelu operatora domeny.*

## Ustawienia GitHub Pages

Po stronie GitHuba trzeba poinformować GitHub Pages, że blog ma być serwowany pod **własną domeną**: [https://blog.marcinszewczyk.net/](https://blog.marcinszewczyk.net/).

Wchodzimy do repozytorium: [https://github.com/marcin-szewczyk-code/marcin-szewczyk-code.github.io](https://github.com/marcin-szewczyk-code/marcin-szewczyk-code.github.io).

Następnie: Settings → Pages.

Ustawiamy:
- Custom domain: `blog.marcinszewczyk.net`
- zaznaczamy: **Enforce HTTPS**

Po zapisaniu:
- GitHub automatycznie tworzy plik `CNAME` w repozytorium,
- wystawia certyfikat HTTPS (Let’s Encrypt),
- zaczyna serwować stronę pod nową domeną.

Po poprawnej konfiguracji w zakładce Pages widzimy komunikat: Your site is live at [https://blog.marcinszewczyk.net/](https://blog.marcinszewczyk.net/).

GitHub Pages serwuje treść bloga pod tym adresem.

![Konfiguracja GitHub Pages z podpiętą domeną i HTTPS](/assets/posts/dns-github-pages/github-pages-setup.png)
***Rys. 3.** Ekran konfiguracji GitHub Pages z podpiętą domeną i HTTPS.*

## Sprawdzenie konfiguracji

Po zapisaniu zmian:
- Otwieramy w przeglądarce: [https://marcinszewczyk.net/](https://marcinszewczyk.net/) → adres powinien automatycznie zmienić się na: [https://blog.marcinszewczyk.net/](https://blog.marcinszewczyk.net/)
- Otwieramy w przeglądarce: https://blog.marcinszewczyk.net → blog z adresu [https://marcin-szewczyk-code.github.io/](https://marcin-szewczyk-code.github.io/) powinien się załadować

Jeśli oba punkty działają poprawnie, konfiguracja domeny i GitHub Pages jest zakończona.


