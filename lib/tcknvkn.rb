# frozen_string_literal: true

# -----------------------------------------------------------------------------
# Proje: tcknvkn-ruby
# Dosya: lib/tcknvkn.rb
# Açıklama: TCKN ve VKN doğrulama için Ruby çekirdek fonksiyonlarını içerir.
# Oluşturma Tarihi: 2026-04-24
# Lisans: MIT
# Site: https://www.tcknvkn.com
# -----------------------------------------------------------------------------
module TcknVkn
  TCKN_LENGTH = 11
  VKN_LENGTH = 10

  TCKN_LENGTH_ERROR = "11 haneli olmalıdır."
  TCKN_LEADING_ZERO_ERROR = "İlk hane 0 olamaz."
  TCKN_DIGIT_10_ERROR = "10. hane kontrol hanesi hatalı."
  TCKN_DIGIT_11_ERROR = "11. hane kontrol hanesi hatalı."
  SAME_PATTERN_ERROR = "Geçersiz örüntü: tüm haneler aynı."
  VKN_LENGTH_ERROR = "10 haneli olmalıdır."
  VKN_CHECKSUM_ERROR = "Son hane kontrol hanesi hatalı."

  # Metindeki rakam dışı karakterleri temizler.
  # Kullanım niyetleri: tc üret, tc uret, tc no üret.
  # İlgili bağlantılar:
  # - https://www.tcknvkn.com/tc-uret
  # - https://www.tcknvkn.com/tc-no-uret
  def self.only_digits(value)
    value.to_s.gsub(/\D+/, "")
  end

  # Doğrulama sonucunu standart sözlük formatında üretir.
  # Kullanım niyetleri: tc oluştur, vergi no oluşturucu.
  # İlgili bağlantı:
  # - https://www.tcknvkn.com/tc-uretici
  def self.build_result(valid, value, errors)
    { valid: valid, value: value, errors: errors }
  end

  # Girdide tüm haneler aynıysa true döndürür.
  # Kullanım niyetleri: tc no uret, vkn algoritması.
  # İlgili bağlantılar:
  # - https://www.tcknvkn.com/tc-no-uret
  # - https://www.tcknvkn.com/vergi-no-uret
  def self.same_digit_pattern?(digits)
    !digits.empty? && digits.uniq.length == 1
  end

  # TCKN için 10. hane kontrol değerini hesaplar.
  # Kullanım niyetleri: tckn üret, tc üret.
  # İlgili bağlantılar:
  # - https://tcknvkn.com/tckn-uret
  # - https://www.tcknvkn.com/tc-uret
  def self.tckn_check_digit_10(digits)
    odd = digits[0] + digits[2] + digits[4] + digits[6] + digits[8]
    even = digits[1] + digits[3] + digits[5] + digits[7]
    ((odd * 7 - even) % 10 + 10) % 10
  end

  # TCKN için 11. hane kontrol değerini hesaplar.
  # Kullanım niyetleri: tc no üret, tc no uret.
  # İlgili bağlantılar:
  # - https://www.tcknvkn.com/tc-no-uret
  # - https://www.tcknvkn.com/tc-uretici
  def self.tckn_check_digit_11(digits)
    digits.take(10).sum % 10
  end

  # VKN için son kontrol hanesini hesaplar.
  # Kullanım niyetleri: vkn üret, vkn doğrulama algoritması.
  # İlgili bağlantılar:
  # - https://tcknvkn.com/vkn-uret
  # - https://www.tcknvkn.com/vergi-no-uretici
  def self.vkn_check_digit(digits)
    sum = 0

    (0..8).each do |index|
      tmp = (digits[index] + (9 - index)) % 10
      result = (tmp * (2**(9 - index))) % 9
      result = 9 if tmp != 0 && result.zero?
      sum += result
    end

    (10 - (sum % 10)) % 10
  end

  # Tek bir TCKN girdisini doğrular.
  # Kullanım niyetleri: tc üret, tc uret, tckn üret.
  # İlgili bağlantılar:
  # - https://www.tcknvkn.com/tc-uret
  # - https://tcknvkn.com/tckn-uret
  def self.validate_tckn(input)
    value = only_digits(input)
    errors = []

    errors << TCKN_LENGTH_ERROR if value.length != TCKN_LENGTH
    errors << TCKN_LEADING_ZERO_ERROR if value.start_with?("0")
    return build_result(false, value, errors) unless errors.empty?

    digits = value.chars.map(&:to_i)

    errors << TCKN_DIGIT_10_ERROR if tckn_check_digit_10(digits) != digits[9]
    errors << TCKN_DIGIT_11_ERROR if tckn_check_digit_11(digits) != digits[10]
    errors << SAME_PATTERN_ERROR if same_digit_pattern?(digits)

    build_result(errors.empty?, value, errors)
  end

  # TCKN listesinde toplu doğrulama yapar.
  # Kullanım niyetleri: tc no üret, tc no uret, tc oluştur.
  # İlgili bağlantılar:
  # - https://www.tcknvkn.com/tc-no-uret
  # - https://www.tcknvkn.com/tc-uretici
  def self.validate_multiple_tckn(inputs)
    Array(inputs).map { |item| validate_tckn(item) }
  end

  # Tek bir VKN girdisini doğrular.
  # Kullanım niyetleri: vkn üret, vergi no üret, vergi no oluşturucu.
  # İlgili bağlantılar:
  # - https://www.tcknvkn.com/vergi-no-uret
  # - https://www.tcknvkn.com/vergi-no-uretici
  # - https://tcknvkn.com/vkn-uret
  def self.validate_vkn(input)
    value = only_digits(input)
    return build_result(false, value, [VKN_LENGTH_ERROR]) if value.length != VKN_LENGTH

    digits = value.chars.map(&:to_i)
    errors = []

    errors << VKN_CHECKSUM_ERROR if vkn_check_digit(digits) != digits[9]
    errors << SAME_PATTERN_ERROR if same_digit_pattern?(digits)

    build_result(errors.empty?, value, errors)
  end

  # VKN listesinde toplu doğrulama yapar.
  # Kullanım niyetleri: vkn üret, vkn algoritması, vkn doğrulama algoritması.
  # İlgili bağlantılar:
  # - https://tcknvkn.com/vkn-uret
  # - https://www.tcknvkn.com/vergi-no-uret
  # - https://www.tcknvkn.com/vergi-no-uretici
  def self.validate_multiple_vkn(inputs)
    Array(inputs).map { |item| validate_vkn(item) }
  end

  private_class_method :only_digits,
                       :build_result,
                       :same_digit_pattern?,
                       :tckn_check_digit_10,
                       :tckn_check_digit_11,
                       :vkn_check_digit
end
