


# Jekyll (Chirpy): Modyfikacja sidebara -- sekcja „KONTAKT"

## Cel

Dodanie w sidebarze trzech elementów:

1.  Nagłówka **KONTAKT** z liniami po bokach\
2.  Istniejących ikon (bez modyfikacji logiki motywu)\
3.  Informacji o copyright pod ikonami

Rozwiązanie jest: - proste, - odporne na aktualizacje motywu, - nie
ingeruje w wewnętrzną logikę `.sidebar-bottom`.

------------------------------------------------------------------------

## 1. Modyfikacja `_includes/sidebar.html`

Wstaw nagłówek przed blokiem z ikonami oraz copyright wewnątrz
`.sidebar-bottom` (pod pętlą z ikonami).

### Fragment końcowy:

``` html
  <!-- MPS: CONTACT title -->
  <div class="mps-sidebar-contact-title w-100">
    <span class="line"></span>
    <span class="text">KONTAKT</span>
    <span class="line"></span>
  </div>

<!-- Chirpy icons (unchanged, CONTACT copyright added) -->
  <!-- zastępuję: <div class="sidebar-bottom d-flex flex-wrap  align-items-center w-100"> -->
  <!-- przez: <div class="sidebar-bottom mps-contact-bottom d-flex flex-wrap align-items-center w-100"> -->
<div class="sidebar-bottom d-flex flex-wrap align-items-center w-100">

  {% for entry in site.data.contact %}
    <!-- oryginalna pętla motywu bez zmian -->
  {% endfor %}

    <!-- MPS: CONTACT copyright -->
    <div class="mps-sidebar-contact-copyright"> <!-- w-100 -->
      © 2026 Marcin Szewczyk
    </div> 

</div>
```

Kluczowe założenia: - Nie zmieniamy logiki ikon. - Nie dodajemy
dodatkowych wrapperów. - Nie modyfikujemy struktury flex motywu.

------------------------------------------------------------------------

## 2. CSS (`assets/css/custom.css`)

Dodaj na końcu pliku:

``` css
/* ==========================================================================
   MPS: Sidebar – CONTACT section (simple & resilient)
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
  color: inherit;
}

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
  color: inherit;
}
```

Przyjmuję konwencję, że wprowadzane przeze mnie klasy do pliku custom.css zaczynają się od mps.

------------------------------------------------------------------------

## Dlaczego to rozwiązanie jest stabilne

-   Nie nadpisuje globalnie `.sidebar-bottom`
-   Nie zmienia `flex-direction`
-   Nie używa `gap`
-   Steruje odstępami wyłącznie przez `margin`
-   Działa poprawnie w trybie jasnym i ciemnym (`color: inherit`)

------------------------------------------------------------------------

## Regulacja wyglądu

### Skrócenie linii:

``` css
max-width: 50px;
```

### Zmniejszenie odstępu od ikon:

``` css
margin-top: 0.15rem;
```

### Zwiększenie odstępu od ikon:

``` css
margin-top: 0.3rem;
```

------------------------------------------------------------------------

## Podsumowanie

To podejście minimalizuje ingerencję w motyw Chirpy i jest odporne na
przyszłe aktualizacje.\
Sekcja „KONTAKT" jest czytelna, estetyczna i łatwa do dalszej
modyfikacji.
