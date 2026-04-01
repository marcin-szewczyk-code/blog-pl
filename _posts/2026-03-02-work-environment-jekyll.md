---
title: "Środowisko: Jekyll – konfiguracja narzędzi (VS Code, Git, SSH, Ruby)"
description: "Konfiguracja środowiska pracy dla bloga Jekyll: VS Code, Git, SSH, Ruby (DevKit) oraz lokalne uruchamianie serwera."
date: 2026-03-02 07:00:00 +0100
categories: [Środowisko]
tags: [jekyll, git, github, ssh, ruby]
---

Wpis dokumentuje konfigurację środowiska pracy dla bloga opartego na **Jekyll**, hostowanego w GitHub Pages.

---

## 1. Visual Studio Code

Visual Studio Code (VS Code, VSC) to dla mnie podstawowy edytor do wszystkiego.

Służy do edycji plików źródłowych (Markdown, YAML, HTML, CSS) oraz do pracy terminalowej.

Instalacja: [https://code.visualstudio.com/](https://code.visualstudio.com/)

---

## 2. Git

Git jest systemem kontroli wersji (SCM – Source Code Management). Umożliwia śledzenie zmian, pracę na gałęziach oraz synchronizację repozytorium z GitHub.

Instalacja: [https://git-scm.com/](https://git-scm.com/)

Podczas instalacji wybrałem:

- ✔ **Use Visual Studio Code as Git's default editor**
- ✔ **Override the default branch name: main**
- ✔ **Git from the command line and also from 3rd-party software**
- ✔ **Use bundled OpenSSH**
- ✔ **Use the native Windows Secure Channel library**
- ✔ **Checkout Windows-style, commit Unix-style line endings**
- ✔ **Use the native Windows Secure Channel library (Schannel)**
- ✔ **Checkout Windows-style, commit Unix-style line endings**
- ✔ **Use MinTTY (the default terminal of MSYS2)**
- ✔ **Fast-forward or merge**
- ✔ **Git Credential Manager**
- ✔ **Enable file system caching** ❌ **Enable symbolic links**

Po instalacji konfiguracja tożsamości:

``` bash
git config --global user.name "Moje Imię Nazwisko"
git config --global user.email "moj_adres_na_githubie@gmail.com"
```

Sprawdzenie:

``` bash
git config --global --list
```

Dostęp do repozytorium realizowany jest przez SSH (alternatywnie możliwy jest HTTPS z użyciem tokena).

---

## 3. Konfiguracja SSH z GitHub

### Generowanie klucza

Generuję parę kluczy kryptograficznych w celu uwierzytelniania połączeń z GitHub bez użycia hasła:

``` bash
ssh-keygen -t ed25519 -C "moj_adres_na_githubie@gmail.com"
```

Wyświetlenie klucza publicznego:

``` bash
type %USERPROFILE%\.ssh\id_ed25519.pub
```

gdzie ```%USERPROFILE%``` oznacza katalog domowy bieżącego użytkownika (home directory), w którym przechowywany jest katalog ```.ssh``` z kluczami SSH.

### Dodanie klucza do GitHub

1.  GitHub → Settings
2.  SSH and GPG keys
3.  New SSH key
4.  Title: np. `Lenovo-X250-2026`
5.  Wklejenie klucza prywatnego (zawartość `%USERPROFILE%\.ssh\id_ed25519.pub`)
6.  Add SSH key

Test połączenia (potwierdzenie przez `yes`, następnie podaj hasło, jeśli będzie wymagane):

``` bash
ssh -T git@github.com
```

Oczekiwany wynik:

``` text
Hi marcin-szewczyk-code! You've successfully authenticated, but GitHub does not provide shell access.
```

---

## 4. Ruby (wymagane przez Jekyll)

Jekyll jest aplikacją (generatorem stron statycznych) napisaną w języku Ruby. Dlatego lokalne uruchamianie bloga wymaga zainstalowanego interpretera Ruby oraz menedżera pakietów.

Przy okazji, Ruby ma ciekawie sformułowaną filozofię: „designed to make programmers happy” (Y. Matsumoto)[^1].

[^1]: Y. Matsumoto, *The Philosophy of Ruby*, Artima Developer, 2003.  
      [https://www.artima.com/articles/the-philosophy-of-ruby](https://www.artima.com/articles/the-philosophy-of-ruby)
      
      „For me the purpose of life is partly to have joy. Programmers often feel joy when they can concentrate on the creative side of programming. So Ruby is designed to make programmers happy.”

Instalacja: [https://rubyinstaller.org/](https://rubyinstaller.org/)

Wybrana wersja: **Ruby+Devkit 3.3.x**

Po instalacji uruchomiłem:

``` bash
ridk install
```

![Instalacja Ruby pod Windows](/assets/posts/work-environment-jekyll/ruby-installer.png)
***Rys. 1.** Instalacja Ruby pod Windows.*

Narzędzie ```ridk install``` instaluje więc środowisko MSYS2 oraz toolchain (gcc, make), wymagane do kompilacji gemów z rozszerzeniami natywnymi.

Sprawdzenie:

``` bash
ruby -v
```

---

## 5. Instalacja zależności projektu (blog-pl)

Instalację wykonuję osobno dla każdego repozytorium:

``` bash
cd "C:/Git/repositories/blog-pl"
gem install bundler
bundle install
cd "../blog-en"
gem install bundler
bundle install
```

To instaluje:

- Bundler
- wszystkie gemy z `Gemfile`
- w tym Jekyll i używany motyw (np. Chirpy)

Pakiety (biblioteki) w Ruby dystrybuowane są jako gems (klejnoty).

---

## 6. Uruchomienie lokalne

Dla blog-pl:

``` bash
bundle exec jekyll s
```

Domyślny port Jekylla to 4000.

Podgląd: [http://127.0.0.1:4000/](http://127.0.0.1:4000/)

Dla blog-en (na innym porcie):

``` bash
bundle exec jekyll s -P 4001
```

Podgląd: [http://127.0.0.1:4001/](http://127.0.0.1:4001/)

Uruchamia to lokalne serwery deweloperskie Jekyll (tryb development).

---

## Podsumowanie

Efekt końcowy konfiguracji:

-   VS Code zainstalowany
-   Git zainstalowany i działa z GitHubem przez SSH
-   Repozytoria zsynchronizowane
-   Ruby + DevKit kompilują zależności
-   Jekyll (Chirpy) uruchamia się lokalnie na portach 4000 i 4001

Robię → działa → jest fajnie.