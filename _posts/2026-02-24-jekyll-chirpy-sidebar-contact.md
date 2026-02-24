---
title: "Blog Jekyll: Stopka sidebaru w motywie Chirpy – CSS"
description: "Jak w motywie Chirpy dodać stopkę w sidebarze."
date: 2026-02-24 07:00:00 +0100
categories: [Blog Jekyll]
tags: [jekyll, chirpy, css, html, config]
---

Spodobał mi się element u dołu sidebaru z motywu motywu [Flexible Jekyll](https://github.com/artemsheludko/flexible-jekyll), więc go dodałem do mojego Chirpy. Wymagało to modyfikacji `_includes/sidebar.html` i dodania kilku klas i reguł CSS do `assets/css/custom.css`.


![Stopka w sidebarze](/assets/posts/jekyll-chirpy-sidebar-contact/sidebar-contact-pl.png)
***Rys. 1.** Stopka w sidebarze.*

Stopka w sidebarze składa się z trzech elementów:

1.  Nagłówka **KONTAKT** z liniami po bokach
2.  Istniejących ikon (bez modyfikacji logiki motywu)
3.  Informacji o copyright pod ikonami

## Modyfikacja _includes/sidebar.html

Wstawiam nagłówek przed blokiem z ikonami, a copyright dodaję wewnątrz `.sidebar-bottom` (pod pętlą z ikonami).

``` html
  <!-- MPS: CONTACT title -->
  <div class="mps-sidebar-contact-title w-100">
    <span class="line"></span>
    <span class="text">KONTAKT</span>
    <span class="line"></span>
  </div>

  <!-- MPS: Chirpy icons (unchanged, CONTACT copyright added) -->
  <!-- replace: 
      <div class="sidebar-bottom d-flex flex-wrap align-items-center w-100">
      with:
      <div class="sidebar-bottom mps-contact-bottom d-flex flex-wrap align-items-center w-100">
  -->
 <div class="sidebar-bottom mps-contact-bottom d-flex flex-wrap align-items-center w-100">

  {% for entry in site.data.contact %}
    <!-- original theme loop without changes -->
  {% endfor %}

    <!-- MPS: CONTACT copyright -->
    <div class="mps-sidebar-contact-copyright">
      © 2026 Marcin Szewczyk
    </div> 

</div>
```

## Dodanie CSS do `assets/css/custom.css`

Dodaję na końcu pliku:

``` css
/* ==========================================================================
   MPS: Sidebar – CONTACT (title + icons + copyright)
   ========================================================================== */

/* Title */
#sidebar .mps-sidebar-contact-title {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.6rem;
  margin-bottom: 0.5rem;
  font-weight: 600;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  font-size: 0.9rem;
  color: var(--sidebar-muted-color);
}

/* Title decorative lines */
#sidebar .mps-sidebar-contact-title .line {
  flex: 1;
  height: 2px;
  background: currentColor;
  opacity: 0.45;
  max-width: 60px;
}

/* Center this specific sidebar-bottom block */
#sidebar .mps-contact-bottom {
  justify-content: center !important;
  padding-left: 0 !important;
  padding-right: 0 !important;
}

/* Copyright in this block */
#sidebar .mps-contact-bottom .mps-sidebar-contact-copyright {
  flex: 0 0 100% !important;
  width: 100% !important;
  text-align: center !important;
  margin-top: 0.2rem;
  font-size: 0.9rem;
  opacity: 0.75;
  color: var(--sidebar-muted-color);
}
```

Przyjmuję konwencję, że wszystkie moje klasy w `custom.css` zaczynają się od `mps-`. W ten sposób minimalizuję ryzyko konfliktu z przyszłymi aktualizacjami motywu.

## Podsumowanie

Robię → działa → jest fajnie.