# frozen_string_literal: true

# -----------------------------------------------------------------------------
# Proje: tcknvkn-ruby
# Dosya: tests/test_tcknvkn.rb
# Açıklama: TCKN ve VKN doğrulama fonksiyonları için varyasyonlu birim testleri içerir.
# Oluşturma Tarihi: 2026-04-24
# Lisans: MIT
# Site: https://www.tcknvkn.com
# -----------------------------------------------------------------------------
require "minitest/autorun"
require_relative "../lib/tcknvkn"

class TcknVknTest < Minitest::Test
  # Geçerli ve geçersiz TCKN senaryolarını doğrular.
  def test_validate_tckn_with_valid_and_invalid_variants
    valid = TcknVkn.validate_tckn("10000000146")
    assert_equal true, valid[:valid]
    assert_equal "10000000146", valid[:value]
    assert_equal [], valid[:errors]

    normalized = TcknVkn.validate_tckn("100-000 00146")
    assert_equal true, normalized[:valid]
    assert_equal "10000000146", normalized[:value]

    wrong_length = TcknVkn.validate_tckn("12345")
    assert_equal false, wrong_length[:valid]
    assert_includes wrong_length[:errors], "11 haneli olmalıdır."

    leading_zero = TcknVkn.validate_tckn("01234567890")
    assert_equal false, leading_zero[:valid]
    assert_includes leading_zero[:errors], "İlk hane 0 olamaz."

    wrong_digit_10 = TcknVkn.validate_tckn("10000000156")
    assert_equal false, wrong_digit_10[:valid]
    assert_includes wrong_digit_10[:errors], "10. hane kontrol hanesi hatalı."

    wrong_digit_11 = TcknVkn.validate_tckn("10000000145")
    assert_equal false, wrong_digit_11[:valid]
    assert_includes wrong_digit_11[:errors], "11. hane kontrol hanesi hatalı."

    same_pattern = TcknVkn.validate_tckn("11111111111")
    assert_equal false, same_pattern[:valid]
    assert_includes same_pattern[:errors], "Geçersiz örüntü: tüm haneler aynı."
  end

  # Geçerli ve geçersiz VKN senaryolarını doğrular.
  def test_validate_vkn_with_valid_and_invalid_variants
    valid = TcknVkn.validate_vkn("1000036109")
    assert_equal true, valid[:valid]
    assert_equal "1000036109", valid[:value]
    assert_equal [], valid[:errors]

    normalized = TcknVkn.validate_vkn("100-003-6109")
    assert_equal true, normalized[:valid]
    assert_equal "1000036109", normalized[:value]

    wrong_length = TcknVkn.validate_vkn("1234")
    assert_equal false, wrong_length[:valid]
    assert_equal ["10 haneli olmalıdır."], wrong_length[:errors]

    wrong_checksum = TcknVkn.validate_vkn("1000036108")
    assert_equal false, wrong_checksum[:valid]
    assert_includes wrong_checksum[:errors], "Son hane kontrol hanesi hatalı."

    same_pattern = TcknVkn.validate_vkn("1111111111")
    assert_equal false, same_pattern[:valid]
    assert_includes same_pattern[:errors], "Geçersiz örüntü: tüm haneler aynı."
  end

  # Kısa ve sıfırla başlayan TCKN girdisinde çoklu hata döndüğünü doğrular.
  def test_validate_tckn_multiple_errors
    result = TcknVkn.validate_tckn("0")
    assert_equal false, result[:valid]
    assert_includes result[:errors], "11 haneli olmalıdır."
    assert_includes result[:errors], "İlk hane 0 olamaz."
  end

  # Toplu TCKN doğrulamasında sıra ve sonuç bütünlüğünü doğrular.
  def test_validate_multiple_tckn_preserves_order
    results = TcknVkn.validate_multiple_tckn(["10000000146", "10000000145", "11111111111"])
    assert_equal 3, results.length
    assert_equal true, results[0][:valid]
    assert_equal false, results[1][:valid]
    assert_equal false, results[2][:valid]
  end

  # Toplu VKN doğrulamasında sıra ve sonuç bütünlüğünü doğrular.
  def test_validate_multiple_vkn_preserves_order
    results = TcknVkn.validate_multiple_vkn(["1000036109", "1000036108", "1111111111"])
    assert_equal 3, results.length
    assert_equal true, results[0][:valid]
    assert_equal false, results[1][:valid]
    assert_equal false, results[2][:valid]
  end

  # Toplu doğrulamada boş liste ve nil girdisi davranışını doğrular.
  def test_validate_multiple_accepts_nil_and_empty
    assert_equal [], TcknVkn.validate_multiple_tckn([])
    assert_equal [], TcknVkn.validate_multiple_tckn(nil)
    assert_equal [], TcknVkn.validate_multiple_vkn([])
    assert_equal [], TcknVkn.validate_multiple_vkn(nil)
  end
end
