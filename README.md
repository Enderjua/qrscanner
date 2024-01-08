# QR Kod Okuyucu

Bu Flutter projesi, QR kodlarını tarayabilen bir mobil uygulamayı içermektedir. Ayrıca taranan QR kodları geçmişte saklanabilir ve görüntülenebilir.

## Kurulum

Projenin kullanılabilmesi için Flutter'ın yüklü olması gerekmektedir. Flutter yüklü değilse [Flutter Kurulum Sayfası](https://flutter.dev/docs/get-started/install) adresinden kurulum adımlarını takip edebilirsiniz.

1. Repoyu bilgisayarınıza klonlayın:

```bash
git clone https://github.com/kullaniciadi/projeadi.git
```
    Proje dizinine gidin:

```bash

cd projeadi
```
    Bağımlılıkları yükleyin:

```bash

flutter pub get
```
    Uygulamayı çalıştırın:

```bash

flutter run
```
Kullanım

Uygulamayı başlattığınızda, kamera ve galeri izinlerini kontrol eder. Eğer izinler yoksa, kullanıcıya izinleri vermesi için bir uyarı gösterir. İzinler verildiğinde, ana sayfa görüntülenir.

Ana sayfada kullanıcı, kamerayı kullanarak QR kodları tarayabilir. Ayrıca, galeriden QR kodu okutmak şu anda mümkün değildir. Taranan QR kodları geçmişte saklanır ve geçmiş sayfasında görüntülenebilir.
Ekran Görüntüleri

Ekran görüntülerini screenshots klasöründe bulabilirsiniz.
Kütüphaneler

Proje, aşağıdaki ana kütüphaneleri kullanmaktadır:

    Hive: Hafif bir veritabanı paketi.
    qr_code_scanner: QR kodu tarayıcı bileşeni.
    permission_handler: İzinleri yöneten paket.

Katkıda Bulunma

Eğer projeye katkıda bulunmak istiyorsanız, lütfen bir çekme isteği oluşturun. Katkılarınızı bekliyoruz!
Lisans

Bu proje tamamen özgür yazılım prensiplerine uygun olarak geliştirilmiştir

(description created with ai)
