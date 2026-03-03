---
title: "Blog Jekyll: Newsletter – MailerLite"
description: "Implementacja newslettera w architekturze Static Frontend + SaaS Backend (Jekyll, Chirpy, MailerLite)."
date: 2026-03-04 07:00:00 +0100
categories: [Blog Jekyll]
tags: [newsletter, jekyll, chirpy, mailerlite]
---

Pomyślałem, żeby zrobić newsletter – więc tak zrobiłem.

Newsletter informuje o nowych wpisach na blogu – niezależnie od zewnętrznych platform społecznościowych.

---

## Koncepcja

### Założenia

Statyczny frontend + zewnętrzny backend do zapisu adresów i dystrybucji e-mail:

- Blog działa jako w pełni statyczny frontend.
- Obsługa zapisu i dystrybucja e-mail realizowana jest przez zewnętrzny backend (model SaaS).
- Adresy e-mail nie są przechowywane w repozytorium ani na serwerze bloga – tylko w systemie SaaS.

### Sposób działania

-   Powiadomienia wysyłane są każdorazowo po publikacji nowego wpisu.
-   Przy zapisie włączony jest mechanizm double opt-in (potwierdzenie zapisu mailem).
-   W każdej chwili można zrezygnować z subskrypcji, korzystając z linku w stopce wiadomości.
-   Strony potwierdzające znajdują się w mojej domenie.

### Wybór SaaS (Software as a Service)

Wybrałem MailerLite, ponieważ:

-   Darmowy plan do 500 subskrybentów i 12 000 maili miesięcznie.
-   Brak agresywnych elementów marketingowych.
-   Prosty model działania.
-   Możliwość eksportu bazy.

### Architektura

Statyczny frontend + zewnętrzny backend:

-   **Frontend:** Jekyll + motyw Chirpy (GitHub Pages)
-   **Backend:** MailerLite

---

## Implementacja

### Proces zapisu

Proces zapisu wygląda tak:

1.  W `_includes/topbar.html` znajduje się link do strony z formularzem
    zapisu: [https://blog.marcinszewczyk.net/newsletter/](https://blog.marcinszewczyk.net/newsletter/)

2.  Formularz na tej stronie połączony jest z backendem (MailerLite).

3.  Użytkownik wpisuje e-mail i wysyła formularz.
    Otrzymuje wiadomość z linkiem do potwierdzenia zapisu.
    Jednocześnie wyświetla się strona: [https://blog.marcinszewczyk.net/newsletter-confirmation/](https://blog.marcinszewczyk.net/newsletter-confirmation/)

4.  Użytkownik klika w link potwierdzający w mailu.
    Wyświetla się strona z potwierdzeniem zapisu: [https://blog.marcinszewczyk.net/newsletter-confirmed/](https://blog.marcinszewczyk.net/newsletter-confirmed/)

Zewnętrzny backend robi swoje, a blog pozostaje w pełni statyczny.

### Konfiguracja MailerLite

#### Ustawienia konta:

- Nadawca: Imię i nazwisko
- Adres: newsletter@marcinszewczyk.net

#### Domeny wysyłające:

Dodana domena wysyłająca wraz z rekordami uwierzytelniającymi (SPF/DKIM), dla poprawy dostarczalności.

#### Grupa subskrybentów:

Utworzona grupa: **Blog Newsletter**.

#### Formularze:

Utworzone dwa formularze:
- Form: PL
- Form: EN

W ustawieniach:

-   zaznaczona opcja „Własna strona sukcesu",
-   włączony double opt-in,
-   brak auto-confirm.

---

### Integracja we frontendzie (Jekyll-Chirpy)

#### 1. Skrypt

JavaScript dostarczony przez MailerLite, dodany w `_includes/head.html`:

```html
<!-- MailerLite Universal -->
<script>
    (function(w,d,e,u,f,l,n){w[f]=w[f]||function(){(w[f].q=w[f].q||[])
    .push(arguments);},l=d.createElement(e),l.async=1,l.src=u,
    n=d.getElementsByTagName(e)[0],n.parentNode.insertBefore(l,n);})
    (window,document,'script','https://assets.mailerlite.com/js/universal.js','ml');
    ml('account', '2151227');
</script>
<!-- End MailerLite Universal -->
```

Skrypt inicjalizuje globalny obiekt ```ml```, wymagany do osadzania formularzy.

#### 2. Strona newsletter w Jekyll-Chirpy

W pliku `_pages/newsletter.md` dodany formularz MailerLite:

```html
<div class="ml-embedded" data-form="cY1WRm"></div>
```

### Przepływ danych

1.  Użytkownik wpisuje e-mail.
2.  Formularz wysyła dane bezpośrednio do MailerLite.
3.  MailerLite:
    -   wysyła mail potwierdzający,
    -   zapisuje użytkownika w grupie,
    -   umożliwia wypisanie się.

Jekyll nie uczestniczy w przechowywaniu ani przetwarzaniu danych – blog pozostaje w pełni statyczny.

---

## Podsumowanie

Blog ma newsletter będący prostym mechanizmem powiadomień o nowych wpisach.

Bez marketingu.

Bez automatyzacji sprzedażowych.

Prosto. Tyle, ile trzeba.