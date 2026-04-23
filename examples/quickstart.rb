# frozen_string_literal: true

# -----------------------------------------------------------------------------
# Proje: tcknvkn-ruby
# Dosya: examples/quickstart.rb
# Açıklama: TCKN ve VKN doğrulama fonksiyonlarının kısa kullanım örneğini içerir.
# Oluşturma Tarihi: 2026-04-24
# Lisans: MIT
# Site: https://www.tcknvkn.com
# -----------------------------------------------------------------------------
require_relative "../lib/tcknvkn"

puts "TCKN doğrulama: #{TcknVkn.validate_tckn('10000000146')}"
puts "VKN doğrulama: #{TcknVkn.validate_vkn('1000036109')}"
puts "Toplu TCKN: #{TcknVkn.validate_multiple_tckn(['10000000146', '10000000145'])}"
puts "Toplu VKN: #{TcknVkn.validate_multiple_vkn(['1000036109', '1000036108'])}"
