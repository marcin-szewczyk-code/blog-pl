---
title: "Środowisko (2/N): Linux pod Windows – MSYS2, MinGW i gcc"
date: 2026-02-13 07:00:00 +0100
categories: [Environment]
tags: [linux, environment, setup, msys2]
---

Pierwsze co warto zrobić w Windowsie, to zainstalować w nim Linuxa. Poniżej opisuję minimalną konfigurację opartą o MSYS2.

MSYS2 to środowisko z narzędziami linuxowymi na Windowsie. Nazwa pochodzi od „Minimal SYStem”, generacja 2.

MSYS2 jest oparte o MinGW, czyli zestaw narzędzi GNU dla Windowsa. Nazwa MinGW oznacza „Minimalist GNU for Windows”.

GNU to projekt dostarczający wolne narzędzia systemowe używane w systemach linuxowych, w tym kompilator gcc dla języka C.

MSYS2 używam jako źródła podstawowych narzędzi linuxowych na Windowsie. Chodzi głównie o linuxowy terminal z powłoką `bash` oraz kompilator `gcc`, a przy okazji edytor `nano` i inne narzędzia linuxowe, jak `ImageMagick`.

W ten sposób mam mini-Linux pod Windows: środowisko MSYS2, narzędzia MinGW i kompilator gcc. Do instalacji pakietów w MSYS2 korzystam z menedżera pakietów `pacman`.

### Instalacja i konfiguracja MSYS2

Instaluję go stąd: [https://www.msys2.org/](https://www.msys2.org/)

Po zainstalowaniu pojawiają się trzy elementy (rys. 1).

Plik: [hello.c](/assets/posts/work-environment-linux-msys2/hello.c).

![MSYS2 po instalacji](/assets/posts/work-environment-linux-msys2/MSYS2_01.png)
***Rys. 1.** Wynik instalacji MSYS2: MSYS, MINGW64, UCRT64.*

MSYS służy głównie do zarządzania pakietami. MINGW64 i UCRT64 pozwalają budować natywne pliki `.exe` dla Windowsa. Korzystam z MINGW64, bo jest prostsze od UCRT64 i wystarczające.

### Instalacja kompilatora gcc

Uruchamiamy MSYS2 MINGW64 i doinstalowuję kompilator:

```bash
pacman -S --needed mingw-w64-x86_64-gcc
```

Sprawdzam wynik instalacji:

```bash
gcc --version
```

Do zabawy dużymi liczbami potrzebuję jeszcze bibliotekę GMP. Instaluję ją w MSYS2 MINGW64:

```bash
pacman -S --needed mingw-w64-x86_64-gmp
```

GMP to GNU Multiple Precision Arithmetic Library, czyli biblioteka C do obliczeń na liczbach o dowolnej precyzji, większych niż pozwalają na to standardowe typy w C.

Testuję. Tworzę katalog `c:/code`. W terminalu MINGW64 przechodzę do tego katalogu, tworzę plik `hello.c`, kompiluję i uruchamiam:


```bash
cd /c/code
nano hello.c
```

```c
#include <stdio.h>

int main(void)
{
    printf("Hello, world!\n");
    return 0;
}
```

```bash
gcc hello.c -o hello
./hello
```

Plik: [hello.c](/assets/posts/work-environment-linux-msys2/hello.c).

### Instalacja ImageMagick

Instalacja [ImageMagick](https://imagemagick.org/) w środowisku **MSYS2 MINGW64**.

Aktualizacja pakietów (jeśli dawno nie była wykonywana):

```bash
pacman -Syu
```
Instalacja pakietu:

```bash
pacman -S mingw-w64-x86_64-imagemagick
```

Sprawdzenie instalacji:

```bash
magick -version
```

Przykładowe użycie:

```bash
magick input.png -gravity center -crop 1:1 -resize 512x512 output.png
```

Przykład jak zrobić screenshota do umieszczenia w dokumentacji README.md na GitHubie:

1) Otwórz stronę w Chrome, następnie:
- F12 → DevTools
- `Ctrl+Shift+P` (Command Menu)
- Wpisz: `screenshot`
- Wybierz: **Capture full size screenshot**

Chrome wygeneruje PNG z pełną wysokością strony.

2) Użyj magicka do zrobienia obramowania i cienia:

```bash
magick screenshot-raw.png   -resize 500x   -bordercolor white -border 10   -alpha set   \( +clone -background black -shadow 40x3+0+2 \)   +swap -background none -compose over -composite   -strip -quality 92   screenshot.png
```

## Podsumowanie

Minimalne środowisko z narzędziami unixowymi do pracy pod Windows:
- MSYS2 (powłoka `bash` + manager pakietów `pacman`)
- zestaw narzędzi (toolchain) MinGW64
- kompilator `gcc`
- edytor `nano`
- biblioteka GMP
- ImageMagick

Na początek to wystarczy.