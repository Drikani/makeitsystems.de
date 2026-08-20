# Registriert die Sass-Quellen des "font-awesome-sass"-Gems als zusätzlichen
# Load-Path (analog zu bootstrap_sass.rb) und kopiert die Solid-Schriftdateien
# aus dem Gem nach fonts/font-awesome/ im Build-Output – ohne die Font-
# Awesome-Dateien ins Repo zu vendoren. Nur der Solid-Stil wird eingebunden,
# da die Seite ausschließlich fa-solid-Icons verwendet (siehe css/main.scss).
require "font-awesome-sass"

Jekyll::Hooks.register :site, :after_init do |site|
  sass_config = (site.config["sass"] ||= {})
  load_paths = (sass_config["load_paths"] ||= [])
  path = FontAwesome::Sass.stylesheets_path
  load_paths << path unless load_paths.include?(path)
end

class FontAwesomeFontFile < Jekyll::StaticFile
  def initialize(site, source_dir, dest_dir, name)
    super(site, site.source, dest_dir, name)
    @source_dir = source_dir
  end

  # Liest die Datei aus dem Gem statt aus site.source (Standardverhalten).
  def path
    File.join(@source_dir, @name)
  end
end

Jekyll::Hooks.register :site, :post_read do |site|
  source_dir = File.join(FontAwesome::Sass.fonts_path, "font-awesome")
  %w[fa-solid-900.woff2 fa-solid-900.ttf].each do |name|
    site.static_files << FontAwesomeFontFile.new(site, source_dir, "fonts/font-awesome", name)
  end
end
