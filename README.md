# makeitSYSTEMS

[![Deploy to GitHub Pages](https://github.com/Drikani/makeitsystems.de/actions/workflows/pages.yml/badge.svg)](https://github.com/Drikani/makeitsystems.de/actions/workflows/pages.yml)

Quellcode der privaten Website von Mathias Kessler ([makeitSYSTEMS](https://drikani.github.io/makeitsystems.de/)) – "Über mich", Lebenslauf und Impressum.

## Tech-Stack

- [Jekyll](https://jekyllrb.com) 4.4 (Ruby, statischer Seitengenerator)
- [Bootstrap](https://getbootstrap.com) 5 als Ruby-Gem eingebunden (siehe [_plugins/bootstrap_sass.rb](_plugins/bootstrap_sass.rb)), keine vendorten Dateien
- Kein JavaScript – die Seite ist komplett statisches HTML/CSS

## Lokale Entwicklung

Voraussetzung: Ruby >= 3.1 und Bundler.

```bash
bundle install             # Gems installieren
bundle exec jekyll serve   # Dev-Server mit Live-Rebuild unter http://127.0.0.1:4000/makeitsystems.de/
bundle exec jekyll build   # Statische Seite nach _site/ bauen
```

Es gibt keine Tests oder Linter in diesem Repo.

## Struktur

- `index.html`, `lebenslauf.html`, `impressum.html` – die drei Seiten der Website, Inhalt jeweils direkt in der Datei
- `_layouts/`, `_includes/` – gemeinsames Seitengerüst (Header, Navigation, Footer)
- `_data/` – listenartiger Inhalt (Skills, Lebenslauf-Timeline, Quellen, Datenschutz-Abschnitte, Hobbies), wird per `{% for %}`-Schleife eingebunden
- `_sass/`, `css/main.scss` – Styling (Bootstrap + eigene Anpassungen)
- `_config.yml` – Site-Einstellungen inkl. Kontaktdaten (`contact.*`), die auf der Impressum-Seite eingebunden werden

Mehr Architektur-Details (inkl. einiger nicht offensichtlicher Stolperfallen) stehen in [CLAUDE.md](CLAUDE.md).

## Deployment

Die Website liegt auf [GitHub Pages](https://pages.github.com) als Projektseite unter `https://drikani.github.io/makeitsystems.de/` (kein eigenes Domain-Setup).

Workflow: Alle Änderungen laufen über den `develop`-Branch. Sobald `develop` nach `main` gemerged/gepusht wird, laufen automatisch zwei GitHub-Actions-Workflows:

- [`.github/workflows/pages.yml`](.github/workflows/pages.yml) baut die Seite und deployed sie auf GitHub Pages.
- [`.github/workflows/release.yml`](.github/workflows/release.yml) erstellt automatisch ein neues [Release](https://github.com/Drikani/makeitsystems.de/releases) mit einem Changelog aller Commits, die seit dem letzten Release auf `develop` dazugekommen sind.
