# frozen_string_literal: true

# -----------------------------------------------------------------------------
# Proje: tcknvkn-ruby
# Dosya: tcknvkn.gemspec
# Açıklama: RubyGem paket tanımı ve metadata alanlarını içerir.
# Oluşturma Tarihi: 2026-04-24
# Lisans: MIT
# Site: https://www.tcknvkn.com
# -----------------------------------------------------------------------------
Gem::Specification.new do |spec|
  spec.name = "tcknvkn"
  spec.version = "1.0.0"
  spec.authors = ["TCKNVKN"]
  spec.email = ["239645710+tckn-vkn@users.noreply.github.com"]

  spec.summary = "Ruby kütüphanesi ile TCKN ve VKN doğrulama"
  spec.description = "Ruby projeleri için TCKN (TC Kimlik No) ve VKN (Vergi Kimlik No) doğrulama fonksiyonları sunar."
  spec.homepage = "https://www.tcknvkn.com/kutuphaneler/ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0"

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => "https://github.com/tcknvkn/tcknvkn-ruby",
    "changelog_uri" => "https://github.com/tcknvkn/tcknvkn-ruby/blob/release/CHANGELOG.md"
  }

  spec.files = Dir["lib/**/*.rb"] + Dir["examples/**/*.rb"] + %w[README.md CHANGELOG.md LICENSE]
  spec.require_paths = ["lib"]
end
