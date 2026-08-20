# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

This is the source for makeitSYSTEMS, a static Jekyll site (German-language personal/company page with "Über mich", "Lebenslauf", and "Impressum" pages). It was migrated from GitLab (see README pipeline badge, which still points at the old GitLab repo).

## Commands

```bash
bundle install       # install Jekyll 4.4 and dependencies (Ruby >= 3.1 per Gemfile)
bundle exec jekyll serve   # run local dev server with live rebuild
bundle exec jekyll build   # build the static site into _site/
```

There are no tests, linters, or CI config in this repo.

## Architecture

Standard Jekyll layout/include structure with three real top-level pages (not anchor tabs — that was the old Materialize-era structure; it was split apart when the tabs were rebuilt as real navigation):

- [_layouts/default.html](_layouts/default.html) is the only layout. It assembles `head`, `header`, `nav`, page `content`, and `footer` includes, then loads jQuery/salvattore/cookiepopup JS at the bottom of `<body>`.
- Three top-level pages, each `{% include %}`-ing one section: [index.html](index.html) (`/`, "Über mich") → [_includes/me.html](_includes/me.html), [lebenslauf.html](lebenslauf.html) (`/lebenslauf.html`) → [_includes/resume.html](_includes/resume.html), [impressum.html](impressum.html) (`/impressum.html`) → [_includes/imprint.html](_includes/imprint.html). Each sets `title:` in its front matter, used by `head.html` for the `<title>` tag.
- [_includes/nav.html](_includes/nav.html) defines the tab bar (Bootstrap `nav nav-tabs nav-fill`) as real links to those three pages; each link's `active` class is set server-side via `{% if page.url == '...' %}`, not JS — there's no client-side tab-toggle script anymore.
- [_includes/resume/](_includes/resume) and [_includes/imprint/](_includes/imprint) hold sub-includes for each section (e.g. `hardskills.html`, `softskills.html`, `timeline.html`; `imprint.html`, `SSL.html`, `cookies.html`, `disclaimer.html`, `rights.html`, `logs.html`, `ads.html`, `twitter.html`, `linkedin.html`, `source.html`) — pulled in by the corresponding top-level include.
- Styling is Bootstrap 5 (via the `bootstrap` gem, see below) plus a small custom layer in [_sass/](_sass) (`_custom.scss`/`_custom-dark.scss`/`_main-variables.scss`/`cookiepopup.scss`/`_roboto.scss`/`_salvattore.scss`/`_color-variables.scss`), compiled from [css/main.scss](css/main.scss) into `css/main.css`; `_config.yml` sets `sass_dir: _sass`, `style: compact`, and `quiet_deps: true`.
  - **Bootstrap comes from the `bootstrap` gem, not vendored files.** [_plugins/bootstrap_sass.rb](_plugins/bootstrap_sass.rb) adds `Bootstrap.stylesheets_path` to Jekyll's Sass `load_paths` at `:site, :after_init`, so `@import "bootstrap/..."` in `css/main.scss` resolves into the installed gem. Custom plugins don't run under GitHub Pages' restricted build — irrelevant here since this site isn't deployed there, but worth knowing if that ever changes.
  - `quiet_deps: true` isn't cosmetic: without it, Bootstrap's large volume of internal Sass deprecation warnings crashes the `sass-embedded` compiler outright during a real Jekyll build (reproduces even on a trivial file — a `sass-embedded`/dart-sass issue, not a config mistake).
  - **Don't name a custom `_sass/` partial the same basename as `css/main.scss`.** `_sass/main.scss` (imported as `@import "main"`) reliably broke the whole build with a garbled `expected "{"` error blamed on an unrelated line — a real dart-sass import-resolution bug triggered by the entry file and an imported partial sharing a basename. That's why the custom layer is `_custom.scss`/`_custom-dark.scss`, not `main.scss`/`main-dark.scss`.
  - `_main-variables.scss` overrides Bootstrap variables (`$font-family-sans-serif`, `$h1-font-size`..`$h6-font-size`, etc.) to match this site's pre-Bootstrap look (self-hosted Roboto, Materialize-era heading scale) — read its comments before assuming a "default" Bootstrap value.
  - `_color-variables.scss` is Materialize's old Material Design color palette (map + a `color()` lookup function), kept only because `_custom.scss`/`_custom-dark.scss`/`_main-variables.scss` still reference it. Its internal map variables are prefixed `mz-` (`$mz-blue`, `$mz-red`, …) specifically because they'd otherwise collide with Bootstrap's own `$blue`/`$red`/etc. primitives in the shared legacy `@import` namespace and silently corrupt Bootstrap's color system.
- Static assets (images) live in [assets/](assets); vendored/plain JS (jQuery 4.0.0, Salvattore, cookie popup, color-scheme detection) lives in [js/](js) and is included directly via `<script>` tags, not bundled — there's no package.json, and no Bootstrap JS is loaded (nothing on the page needs it).
- `_site/` is the Jekyll build output, gitignored (standard Jekyll setup) — regenerate it locally with `bundle exec jekyll build`.

When editing page content, edit the relevant include under `_includes/` (or its `resume/`/`imprint/` subfolder) rather than the top-level page (`index.html`/`lebenslauf.html`/`impressum.html`), which only wires layout + one include together. If you add a fourth page, update [_includes/nav.html](_includes/nav.html)'s links/active-checks too — nothing generates that list automatically.

`js/cookiepopup.js` (vendored) is initialized with an explicit `'cookiePolicyUrl': '/impressum.html'` override near the bottom of the file — keep that in sync if the imprint page's URL ever changes.


## Options
- Always do a commit after a change so that the repo is not filled with large commit
- always name files and comments in german