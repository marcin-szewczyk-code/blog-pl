---
title: "Blog Jekyll (1/6): Jak zbudować blog Jekyll na GitHub Pages"
date: 2026-02-06 07:00:00 +0100
categories: [Blog]
tags: [blog, jekyll, setup]
---

Zrobiłem bloga, więc powstała kwestia, co napisać, żeby blog miał jakiś wpis.
Naturalny pomysł to opisać, jak zrobić bloga. Poniżej opisuję, jak to można zrobić.

## Repozytorium na GitHubie i folder lokalny

### Repo na GitHubie

Blog zbudowany jest na Jekyll, z motywem Chirpy (można potem zmienić), opublikowany na GitHub Pages.

Czego potrzebujemy na początek i jak to wygląda u mnie:
- **GitHub login**: `marcin-szewczyk-code` (konto na GitHubie)
- **Repo name**: `marcin-szewczyk-code.github.io` (repo na GitHubie)
- **Local directory**: `marcin-szewczyk-code.github.io` (folder na lokalnym komputerze)
- **GitHub repo URL**: [https://github.com/marcin-szewczyk-code/marcin-szewczyk-code.github.io](https://github.com/marcin-szewczyk-code/marcin-szewczyk-code.github.io)
- **URL techniczny (GitHub Pages)**: [https://marcin-szewczyk-code.github.io/](https://marcin-szewczyk-code.github.io/)
- **Site URL (custom domain, ustawiony w DNS u operatora domeny)**: [https://blog.marcinszewczyk.net/](https://blog.marcinszewczyk.net/)
- **Pages type**: user page (GitHub Actions dla repo na GitHubie)

Mając konto na GitHubie tworzymy tam repo `marcin-szewczyk-code.github.io`, potem wgrywamy do niego szablon startowy `Chirpy`.

Jak to zrobić:
- na GitHubie tworzymy repo `marcin-szewczyk-code.github.io`
- otwieramy repo szablonu Chirpy Starter: [https://github.com/cotes2020/chirpy-starter](https://github.com/cotes2020/chirpy-starter)
- klikamy `Use this template` → `Create a new repository`
- ustawiamy `Owner: marcin-szewczyk-code`, `Repository name: marcin-szewczyk-code.github.io`, `Public` → `Create repository`

Wchodzimy następnie w ustawienia repo `marcin-szewczyk-code.github.io` i ustawiamy: `Settings repo → Pages → Build and deployment: GitHub Actions`.

Mamy teraz repo `marcin-szewczyk-code.github.io` na GitHubie, a w nim zawartość `chirpy-starter`. Repo jest tutaj: [https://github.com/marcin-szewczyk-code/marcin-szewczyk-code.github.io](https://github.com/marcin-szewczyk-code/marcin-szewczyk-code.github.io), a gotowy blog jest tutaj: [https://blog.marcinszewczyk.net/](https://blog.marcinszewczyk.net/) (technicznie też pod adresem [https://marcin-szewczyk-code.github.io/](https://marcin-szewczyk-code.github.io)). Gotowy blog to wynik tego, co GitHub Pages buduje i publikuje na podstawie zawartości repo.

### Folder lokalny

Ściągamy (klonujemy) repo do lokalnego folderu `marcin-szewczyk-code.github.io` i pracujemy dalej lokalnie w tym folderze:

```bash
git clone https://github.com/marcin-szewczyk-code/marcin-szewczyk-code.github.io.git marcin-szewczyk-code.github.io
cd marcin-szewczyk-code.github.io
```

Pozostaje konfiguracja szablonu Chirpy, stworzenie pierwszego wpisu i wypchnięcie na Gita.

## Podstawowa konfiguracja i pierwszy wpis

### Podstawowa konfiguracja Jekylla

Podstawowa konfiguracja zapisana jest w pliku `_config.yml`.

Na początek ustawiamy podstawowe rzeczy, potem możemy zrobić resztę:
- `url: "https://blog.marcinszewczyk.net"` - docelowy adres bloga (custom domain w GitHub Pages dla konta `marcin-szewczyk-code` na GitHubie + DNS u operatora domeny).
- `baseurl: ""` - blog jest w root.
- `timezone: "Europe/Warsaw"` - wiadomo.
- `lang: "pl"` - żeby Chirpy brał język interfejsu tam, gdzie ma tłumaczenia, resztę zrobimy ręcznie.

### Tworzenie pierwszego wpisu

Bazujemy na markdownie, więc wpis jest plikiem `.md`. Hello world Jekylla opiszę w osobnym wpisie. Co ciekawe, jest to ten sam markdown co w dokumentacji na GitHubie i w Jupyterze.

## Serwer lokalny i wypchnięcie na Gita

### Uruchomienie serwera lokalnego (local build & preview)

Jekyll jest napisany w Ruby, tak jak cały GitHub. Potrzebuje więc Ruby i gemów.

Instaluję zależności:

```bash
bundle install
```
Uruchamiam Jekylla:

```bash
bundle exec jekyll serve
```

Blog działa teraz lokalnie pod adresem: [http://127.0.0.1:4000/](http://127.0.0.1:4000/).

Zmiany w plikach są widoczne na bieżąco. Nie wszystkich, ale kluczowych, tj. wpisów (zmiana `_config.yml` wymaga restartu Jekylla).

### Wypchnięcie na Gita (commit & push)

Pozostaje `commit` i wypchnięcie `push` na GitHuba:

```bash
git status
git add .
git commit -m "Initial Chirpy blog setup"
git push
```

W jednej, wygodnej linii:

```bash
git add . && git commit -m "Update local changes" && git push
```

### Dodatkowe automatyzacje workflow

Czyszczenie cache i restart Jekylla (polecenie dla Windows / PowerShell):

```bash
Ctrl-C
rmdir /s /q .jekyll-cache & rmdir /s /q _site & bundle exec jekyll serve
```

## Podsumowanie

Całość sprowadza się do workflow:
repo + lokalnie → config + post → serwer lokalny + commit&push (GitHub) → build&deploy (GitHub Pages),
gdzie commit&push do repozytorium uruchamiają automatyczny build&deploy w GitHub Pages.

Robię → działa → jest fajnie.


<!--
>```python
#print("Hello world")
#```
-->

<!--
EN:

I made a blog, so the question came up what to write so the blog has a post.
A natural idea is to describe how to make a blog.

This blog was created when I went to lunch with an IT guy and an automation engineer joined us. It was a nice conversation. I learned that there is something called Jekyll and that it is great. I set it up, added the Chairy theme and some automation in Python.

I bought a domain, created a repo on GitHub and published everything.
And that’s how it was created. The blog is built from markdown, pushed to git from VS Code. It is static and that is great. I make a commit and push and it works great. I will be able to change the theme if I like another one, because all the content is written in markdown. I wonder if I will post here in my free time. Below I describe how to run it.
-->