# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

This is the source for makeitSYSTEMS, a static single-page Jekyll site (German-language personal/company page with an "Über mich", "Lebenslauf", and "Impressum" tab). It was migrated from GitLab (see README pipeline badge, which still points at the old GitLab repo).

## Commands

```bash
bundle install       # install Jekyll 4.x and dependencies (Ruby ~> 2.4 per Gemfile)
bundle exec jekyll serve   # run local dev server with live rebuild
bundle exec jekyll build   # build the static site into _site/
```

There are no tests, linters, or CI config in this repo.

## Architecture

Standard Jekyll layout/include structure, but the entire site is a single page ([index.html](index.html)) using in-page anchor tabs rather than multiple routed pages:

- [_layouts/default.html](_layouts/default.html) is the only layout. It assembles `head`, `header`, `nav`, page `content`, and `footer` includes, then loads jQuery/Materialize/salvattore/cookiepopup JS at the bottom of `<body>`.
- [index.html](index.html) uses `default` layout and renders three stacked sections via includes, each with an anchor id matched by the nav tabs: `#me` → [_includes/me.html](_includes/me.html), `#resume` → [_includes/resume.html](_includes/resume.html), `#imprint` → [_includes/imprint.html](_includes/imprint.html).
- [_includes/nav.html](_includes/nav.html) defines the tab bar (Materialize `ul.tabs`) linking to those three anchors; `default.html` initializes `$('ul.tabs').tabs()` to drive the tab UI.
- [_includes/resume/](_includes/resume) and [_includes/imprint/](_includes/imprint) hold sub-includes for each section (e.g. `hardskills.html`, `softskills.html`, `timeline.html`; `imprint.html`, `SSL.html`, `cookies.html`, `disclaimer.html`, `rights.html`, `logs.html`, `ads.html`, `twitter.html`, `linkedin.html`, `source.html`) — pulled in by the corresponding top-level include.
- Styling is Sass under [_sass/](_sass) (a bundled/customized Materialize CSS build) compiled from [css/materialize.scss](css/materialize.scss); `_config.yml` sets `sass_dir: _sass` and `style: compact`.
- Static assets (images) live in [assets/](assets); vendored/plain JS (jQuery, Materialize, salvattore, cookie popup, color-scheme detection) lives in [js/](js) and is included directly via `<script>` tags, not bundled.
- `_site/` is the Jekyll build output and is not tracked in git.

When editing page content, edit the relevant include under `_includes/` (or its `resume/`/`imprint/` subfolder) rather than `index.html`, which only wires the three sections together.


## Options
- Always do a commit after a change so that the repo is not filled with large commit
- always name files and comments in german