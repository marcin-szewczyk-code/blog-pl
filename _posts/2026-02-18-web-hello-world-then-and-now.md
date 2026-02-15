---
title: "Web (1/N): Pięć modeli generowania HTML – Hello World dawniej i dziś"
date: 2026-02-18 07:00:00 +0100
categories: [Web]
tags: [web, html, php, css, js, hello-world]
---

Uciąłem pogawędkę z Chatem o tym, jak wyglądało programowanie stron webowych 25+ lat temu i co się od tego czasu zmieniło. Wtedy używałem HTML, CSS, PHP i JavaScript, a także programów C++ uruchamianych na serwerze przez CGI. Byłem ciekawy, jak to wygląda dziś.

Mówi się, że w IT zmienia się dużo, szybko i często. Zaskakująco dużo jednak zostaje. Niezależnie od narzędzi, architektury, bibliotek, frameworków czy platform hostingowych, strona internetowa wciąż jest HTML-em wysłanym do przeglądarki.

W tym wpisie pokazuję przykład „Hello World” w pięciu modelach generowania strony:
1. Statyczny HTML – najprostszy model
2. Renderowanie PHP po stronie serwera: Server-Side Rendering (SSR) – podejście klasyczne
3. SSR z separacją warstw – podejście aplikacyjne
4. Renderowanie w przeglądarce z wykorzystaniem API: Client-Side Rendering (CSR) + API
5. Generowanie strony w czasie budowania projektu: Static Site Generation (SSG)

Pierwsze dwa z tych podejść – statyczny HTML i klasyczne SSR – stosowałem 25+ lat temu.

Ten blog działa w ostatnim modelu – statycznym SSG – i jest w dużym stopniu zautomatyzowany.

Do konfiguracji tego bloga potrzebne okazało się rozumienie tych samych podstaw, z których korzystałem 25+ lat temu.

Fundament jest więc wciąż ten sam.

## Model 1: Statyczny HTML – najprostszy model

Tak to robiłem 25+ lat temu.

To najprostsza możliwa forma strony internetowej. Serwer nie wykonuje żadnego kodu, jedynie serwuje statyczny kod HTML. Przeglądarka pobiera gotowy plik HTML i wyświetla go.

Schemat: Browser → Serwer (plik HTML) → Browser.

Struktura:

```bash
index.html
```

Kod:

```html
<!DOCTYPE html>
<html>
<body>
<h1>Hello World</h1>
</body>
</html>
```

HTML jest zapisany w pliku i nie zmienia się przy kolejnych żądaniach. To najprostszy, ale wciąż używany model.

## Model 2: Server-Side Rendering (SSR) – podejście klasyczne

Tak to robiłem 20+ lat temu.

Przeglądarka wysyła żądanie do serwera. Serwer uruchamia kod (np. PHP, dawniej także programy CGI, np. w C++), generuje HTML i odsyła gotową stronę do przeglądarki.

Schemat: Browser → Serwer (PHP) → HTML → Browser.

Struktura:

```bash
index.php
```

Kod:

```php
<?php
$message = "Hello World";
?>
<!DOCTYPE html>
<html>
<body>
<h1><?php echo $message; ?></h1>
</body>
</html>
```
Logika i generowanie HTML są tu w jednym miejscu. Kod wykonuje się na serwerze przy każdym żądaniu.

To proste i działa. W małych projektach wciąż jest wystarczające.

## Model 3: SSR z separacją warstw – podejście aplikacyjne

HTML nadal renderowany jest po stronie serwera, ale z wyraźnym podziałem odpowiedzialności.

Logika aplikacji nie miesza się bezpośrednio z widokiem. Pojawia się podział na warstwy: model, kontroler, widok.

Schemat: Browser → Controller → Model → View → HTML → Browser.

Struktura:

```bash
index.php
views/home.php
```

Kod:

Controller (logika, PHP):

```php
<?php

function render($view, $data = [])
{
    extract($data);
    require "views/$view.php";
}

render("home", ["message" => "Hello World"]);
```

Widok (view.php):

```php
<!DOCTYPE html>
<html>
<body>
<h1><?php echo htmlspecialchars($message); ?></h1>
</body>
</html>
```

HTML nadal powstaje na serwerze, ale kod jest uporządkowany. To podejście dobrze skaluje się w większych projektach.

## Model 4: Client-Side Rendering (CSR) + API

Tu zmienia się miejsce generowania HTML. W tym modelu serwer przestaje generować HTML. Zamiast tego serwer dostarcza dane (backend), zwykle w formacie JSON. HTML budowany jest po stronie klienta, czyli w przeglądarce przez JavaScript (frontend).

Schemat: Browser → API → JSON → JavaScript → HTML (DOM).

Proces:
- Ładuje się statyczny HTML.
- JavaScript wysyła żądanie do API.
- Serwer (backend) zwraca dane (np. JSON).
- JavaScript aktualizuje widok (frontend).

Struktura:

```bash
api.php
index.html
```

Kod:

Backend (PHP) – prosty endpoint API zwracający dane w formacie JSON:

```bash
api.php
```

```php
<?php
header("Content-Type: application/json");
echo json_encode(["message" => "Hello World"]);
```

Frontend (JavaScript):

```bash
index.html
```

```html
<!DOCTYPE html>
<html>
<body>

<h1 id="app">Loading...</h1>

<script>
fetch("api.php")
  .then(response => response.json())
  .then(data => {
    document.getElementById("app").innerText = data.message;
  });
</script>

</body>
</html>
```

## Model 5: Static Site Generation (SSG)

Ten blog działa w tym modelu.

Tu dochodzi trzeci moment generowania HTML – build & deploy.

W tym modelu HTML generowany jest w czasie budowania projektu, a nie przy każdym żądaniu użytkownika.

Podczas budowania projektu generator (w tym blogu Jekyll uruchamiany przez GitHub Pages) tworzy statyczny plik HTML, który następnie publikowany jest na platformie hostingowej. Serwer nie wykonuje już żadnej logiki – jedynie wysyła gotowy plik (serwuje) na żądanie przeglądarki (klient), która go wyświetla.

Schemat: Build & deploy → HTML → Serwer (statyczny) → Browser.

Proces:
- Markdown (treść)
- Generator (Jekyll)
- Build (Jekyll generuje statyczne pliki HTML)
- Hosting (GitHub Pages)
- Przeglądarka

Plik Markdown:

```markdown
# Hello World
```

Kod (efekt końcowy wygenerowany statycznie na etapie budowania projektu):

```html
<!DOCTYPE html>
<html>
<body>
<h1>Hello World</h1>
</body>
</html>
```

To model, w którym działa ten blog.

## Porównanie modeli

| Model              | Kiedy powstaje HTML?        | Czy backend generuje HTML przy żądaniu |
|--------------------|-----------------------------|-----------------------------------------|
| Statyczny HTML     | przed wdrożeniem            | nie                                     |
| SSR klasyczne      | przy każdym żądaniu         | tak                                     |
| SSR warstwowe      | przy każdym żądaniu         | tak                                     |
| CSR + API          | po stronie przeglądarki     | nie                                     |
| SSG                | podczas budowania projektu  | nie                                     |

Różnica między modelami polega na tym, kiedy i gdzie jest generowany plik HTML.

## Podsumowanie

Strona internetowa jest HTML-em wysłanym do przeglądarki.

Różne modele odpowiadają na różne potrzeby:
- statyczny HTML jest najprostszy z możliwych
- klasyczne SSR jest proste i wciąż działa,
- podejście aplikacyjne porządkuje większe projekty,
- CSR oddziela dane od interfejsu,
- SSG upraszcza infrastrukturę i przyspiesza działanie.

Mój blog działa w modelu SSG. Automatyzacja jest duża, ale fundament pozostaje ten sam – HTML, CSS i JavaScript. Różni się sposób generowania HTML. Zmieniły się niuanse tych języków w stosunku do 25+ lat temu, ale ich idea pozostała ta sama.

Ciekawe jest też to, że w tym blogu technologia zatoczyła koło – od statycznego HTML do zautomatyzowanego statycznego modelu SSG opartego na Jekyllu i GitHubie.
