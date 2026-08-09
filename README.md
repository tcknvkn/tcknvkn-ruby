# tcknvkn (Ruby)

`tcknvkn`, Ruby projelerinde Türkiye Cumhuriyeti Kimlik Numarası (TCKN) ve Vergi Kimlik Numarası (VKN) doğrulaması yapmak için geliştirilmiş hafif bir kütüphanedir.

## Kurulum

Gem dosyası oluşturmak için:

```bash
gem build tcknvkn.gemspec
```

Yerelde testleri çalıştırmak için:

```bash
ruby -Ilib tests/test_tcknvkn.rb
```

## Hızlı Başlangıç

```ruby
require_relative "lib/tcknvkn"

puts TcknVkn.validate_tckn("10000000146")[:valid] # true
puts TcknVkn.validate_vkn("1000036109")[:valid]   # true
```

## API Özeti

- `TcknVkn.validate_tckn(input)`
- `TcknVkn.validate_multiple_tckn(inputs)`
- `TcknVkn.validate_vkn(input)`
- `TcknVkn.validate_multiple_vkn(inputs)`

Her doğrulama çağrısı aşağıdaki formatta sonuç döndürür:

```ruby
{
  valid: true | false,
  value: "normalize_edilmis_deger",
  errors: ["hata1", "hata2"]
}
```

## Sık Kullanım İfadeleri

- tc üret
- tc uret
- tc no üret
- tc no uret
- tc oluştur
- tckn üret
- vkn üret
- vergi no üret
- vergi no oluşturucu
- vkn algoritması
- vkn doğrulama algoritması

## İlgili Bağlantılar

- [Kütüphaneler](https://www.tcknvkn.com/kutuphaneler)
- [Ruby kütüphane sayfası](https://www.tcknvkn.com/kutuphaneler/ruby)
- [TC üret](https://www.tcknvkn.com/tc-uret)
- [TC no üret](https://www.tcknvkn.com/tc-no-uret)
- [TC üretici](https://www.tcknvkn.com/tc-uretici)
- [TCKN üret](https://tcknvkn.com/tckn-uret)
- [Vergi no üret](https://www.tcknvkn.com/vergi-no-uret)
- [Vergi no üretici](https://www.tcknvkn.com/vergi-no-uretici)
- [VKN üret](https://tcknvkn.com/vkn-uret)

## Lisans

MIT
