# Registriert die Sass-Quellen des "bootstrap"-Gems als zusätzlichen
# Load-Path für Jekylls Sass-Konverter, damit `@import "bootstrap/..."`
# in _sass/ funktioniert, ohne die Bootstrap-Dateien ins Repo zu kopieren.
require "bootstrap"

Jekyll::Hooks.register :site, :after_init do |site|
  sass_config = (site.config["sass"] ||= {})
  load_paths = (sass_config["load_paths"] ||= [])
  load_paths << Bootstrap.stylesheets_path unless load_paths.include?(Bootstrap.stylesheets_path)
end
