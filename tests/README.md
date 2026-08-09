# Test Çalıştırma

```bash
ruby -Ilib tests/test_tcknvkn.rb
```

Bu testler aşağıdaki varyasyonları doğrular:

- Geçerli ve geçersiz TCKN senaryoları
- Geçerli ve geçersiz VKN senaryoları
- Çoklu hata üretimi ve normalize giriş davranışı
- Toplu doğrulamada sıra ve sonuç bütünlüğü
- Boş liste ve nil giriş davranışı
