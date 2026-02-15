---
layout: page
title: Subskrybuj RSS
permalink: /rss/
post_id: rss
---

Ten blog ma kanał **RSS (Atom)**, który możesz dodać do czytnika (np. Feedly, Inoreader).

W ten sposób możesz otrzymywać informacje o nowych wpisach na tym blogu:

- Adres kanału: {{ '/feed.xml' | relative_url }}
- Możesz też po prostu otworzyć feed: [Otwórz feed.xml]({{ '/feed.xml' | relative_url }})

> Po otwarciu zobaczysz plik XML – to normalne. Kanał jest przeznaczony dla czytników RSS, a nie do bezpośredniego czytania w przeglądarce.

## Jak korzystać z kanału RSS

Kanał możesz dodać do aplikacji takich jak:
- Feedly (czytnik działający w przeglądarce)
- NetNewsWire (popularny na macOS / iOS)
- Mozilla Thunderbird (klient poczty z obsługą RSS)
- rozszerzenia RSS dla Chrome lub Edge
- dowolne inne aplikacje obsługujące kanały Atom/RSS

**RSS** (*Really Simple Syndication*) to standardowy format umożliwiający śledzenie aktualizacji stron internetowych w specjalnych czytnikach. Nowe wpisy pojawiają się w nich automatycznie po publikacji.

Rozwiązanie to jest szczególnie przydatne w przypadku mniejszych, niezależnych stron internetowych, które nie korzystają z wbudowanych systemów subskrypcji (np. newslettera czy powiadomień e-mail).

## Jak to wygląda w aplikacji RSS

Poniżej przykład, jak wygląda kanał RSS tego bloga w aplikacji RSS na iPhone:

![Widok kanału RSS bloga w czytniku na iPhone]({{ 'assets/pages/' | append: page.post_id | append: '/rss-feed-in-app.jpg' }})
***Rys. 1.** Widok kanału RSS bloga w czytniku na iPhone.*
