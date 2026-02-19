---
title: "Unix: Polecenia powłoki – Cheat Sheet (ściąga)"
description: "Cheat sheet najczęściej używanych poleceń Uniksa z przykładami pracy ze strumieniami i potokami."
date: 2026-02-23 07:00:00 +0100
categories: [Unix]
tags: [unix, shell, commands, cheat-sheet, pipes]
---


System Unix zbudowany jest z jądra (*kernel*) oraz przestrzeni użytkownika (*user space*). Jądro zarządza zasobami systemu (procesami, pamięcią, systemem plików i urządzeniami) oraz udostępnia programom interfejs wywołań systemowych (*system calls*). Za pomocą *system calls* programy żądają od jądra wykonania określonych operacji systemowych, takich jak `read()`, `write()`, `fork()` czy `exec()`.

W przestrzeni użytkownika działają powłoka (*shell*) oraz programy. Powłoka jest specjalnym programem – interpreterem poleceń: przyjmuje komendy użytkownika (z terminala lub z GUI) i na ich podstawie inicjuje w jądrze uruchamianie procesów poprzez odpowiednie system calls.

Programy, w tym powłoka, korzystają z usług jądra (*kernel services*).

Usługi jądra to funkcjonalności realizowane przez jądro, takie jak odczyt i zapis plików, tworzenie nowych procesów, przydzielanie pamięci, komunikacja z urządzeniami sprzętowymi oraz obsługa potoków i strumieni pomiędzy programami. Programy, w tym powłoka, nie mają bezpośredniego dostępu do sprzętu; zawsze pośredniczy w tym jądro.

Istnieje wiele jąder systemów typu Unix, jednym z nich jest Linux. Linux to wolne jądro typu Unix, stworzone w 1991 roku przez Linusa Torvaldsa, które umożliwiło uruchamianie systemów uniksowych na zwykłych komputerach osobistych.

W tym wpisie przedstawiam mój cheat sheet najczęściej używanych poleceń Uniksa.

---

## Filozofia Uniksa

Ważną zasadą projektową systemu Unix jest hasło:

> „Rób jedną rzecz i rób ją dobrze.”  
> *Make each program do one thing well.* [^1]

Zasada ta w praktyce tłumaczy obecność w Uniksie wielu małych, wyspecjalizowanych programów, które można łączyć potokami i strumieniami w większe operacje.

---

## Unix Cheat Sheet (PDF)

Cheat sheet to zwięzłe, techniczne zestawienie kluczowych informacji w formie skróconej dokumentacji, zebranej na jednej stronie. Jego celem jest ułatwienie bieżącej pracy poprzez szybki dostęp do najważniejszych informacji.

Poniżej znajduje się mój cheat sheet poleceń Uniksa.

📄 **Pobierz PDF**: [`unix-commands-cheat-sheet.pdf`](/assets/posts/unix-commands-cheat-sheet/unix-commands-cheat-sheet.pdf)

![Cheat Sheet poleceń Unix](/assets/posts/unix-commands-cheat-sheet/unix-commands-cheat-sheet-web.png)
***Rys. 1.** Cheat Sheet poleceń Unix.*

---

## Przykład

Jedną z kluczowych idei Uniksa są **strumienie danych** i ich łączenie
potokami.

Rozważmy jedno z podstawowych poleceń powłoki (realizowane przez program `ls`):

```text
ls
```

Wyświetla ono zawartość bieżącego katalogu. Większość poleceń Uniksa
przyjmuje opcje modyfikujące działanie programu.

Przykłady:

```text
ls -a
ls -l
ls -al
```

-   `-a` -- pokazuje także pliki ukryte\
-   `-l` -- format długi (uprawnienia, właściciel, rozmiar, data)
-   `-al = -a -l` (połączone krótkie opcje)

Informacje o dostępnych opcjach uzyskuje się przez:

```text
ls --help
man ls
```

---

## Przykłady pracy ze strumieniami

### 1. Zliczanie plików

```text
    ls *.c | wc -l
```

-   `ls *.c` --- lista plików z rozszerzeniem `.c`
-   `|` --- przekazanie strumienia wyjścia do kolejnego programu
-   `wc -l` --- zliczenie linii

Wynikiem jest liczba plików spełniających wzorzec.

---

### 2. Wyszukiwanie i sortowanie

```text
grep error log.txt | sort | uniq
```

-   `grep error log.txt` --- wybór linii zawierających „error"
-   `sort` --- uporządkowanie wyników
-   `uniq` --- usunięcie duplikatów (z sąsiadujących linii)

---

### 3. Analiza tekstu

```text
cat tekst.txt | tr ' ' '\n' | sort | uniq -c | sort -nr | head
```

Kolejne etapy przetwarzania:

-   zamiana spacji na znak nowej linii\
-   sortowanie\
-   zliczanie wystąpień (`uniq -c`)\
-   sortowanie malejąco (`-nr`)\
-   wyświetlenie pierwszych wyników (`head`)

To przykład łańcucha małych narzędzi realizujących bardziej złożoną operację.

---

### 4. Filtrowanie logów

```text
cat log.txt | grep error | sort | uniq -c
```

Wyszukanie błędów w logu, ich uporządkowanie i zliczenie wystąpień.

---

### 5. Przekierowanie wyjścia

```text
grep main *.c > results.txt
```

Standardowe wyjście zostaje zapisane do pliku tekstowego.

Błędy można przekierować osobno:

```text
grep main *.c 2> errors.txt
```

---

### 6. Praca w tle

```text
sleep 60 &
```

Program uruchamiany jest w tle, a powłoka pozostaje dostępna do dalszej
pracy.

---

## Podsumowanie

Unix oddziela jądro od przestrzeni użytkownika, w której działa rozbudowana powłoka oraz wiele małych, wyspecjalizowanych narzędzi przeznaczonych do łączenia w większe operacje.

Znajomość poleceń Uniksa oraz umiejętność łączenia ich potokami daje w tym systemie dużą swobodę działania.

---

## Literatura

[^1]: M. D. McIlroy, E. N. Pinson, and B. A. Tague, "UNIX Time-Sharing System," *The Bell System Technical Journal*, vol. 57, no. 6, pp. 1899–1904, 1978. [(PDF lokalny)](/assets/posts/unix-commands-cheat-sheet/references/mcilroy1978.pdf)
