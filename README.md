# QR Kod Okuyucu

Bu Flutter projesi, QR kodlarını tarayabilen bir mobil uygulamayı içermektedir. Ayrıca taranan QR kodları geçmişte saklanabilir ve görüntülenebilir.

## Kurulum

Projenin kullanılabilmesi için Flutter'ın yüklü olması gerekmektedir. Flutter yüklü değilse [Flutter Kurulum Sayfası](https://flutter.dev/docs/get-started/install) adresinden kurulum adımlarını takip edebilirsiniz.

1. Repoyu bilgisayarınıza klonlayın:

```bash
git clone https://github.com/enderjua/qrscanner.git
```
Proje dizinine gidin:

```bash

cd qrscanner
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

## Kütüphaneler

Proje, aşağıdaki ana kütüphaneleri kullanmaktadır:

- [Hive](https://pub.dev/packages/hive): Hafif bir veritabanı paketi.
- [qr_code_scanner](https://pub.dev/packages/qr_code_scanner): QR kodu tarayıcı bileşeni.
- [permission_handler](https://pub.dev/packages/permission_handler): İzinleri yöneten paket.

## Katkıda Bulunma

Eğer projeye katkıda bulunmak istiyorsanız, lütfen bir çekme isteği oluşturun. Katkılarınızı bekliyoruz!

## Örnek Kod

Projenin ana dosyasında yer alan kod bloğu:

```dart
// Projenin ana dosyasında yer alan kod bloğu
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scannerqrcode/screens/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ScannerHistoryAdapter());

  runApp(const MyApp());
}

// ... Diğer kodlar ...

// Ana sayfa kodu
class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  // ... Diğer kodlar ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... Diğer widget'lar ...
    );
  }
}

// ... Diğer kodlar ...

// QR kod tarayıcı sayfa kodu
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ... Diğer kodlar ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... Diğer widget'lar ...
    );
  }
}

Bu örnekler, projedeki iki ana sayfa olan FirstPage ve HomePage widget'larını içermektedir. Bu widget'lar, uygulamanın başlangıç noktalarını ve QR kod tarayıcı sayfasını temsil etmektedir.
```

Katkıda Bulunma

Eğer projeye katkıda bulunmak istiyorsanız, lütfen bir çekme isteği oluşturun. Katkılarınızı bekliyoruz!


Bu proje tamamen özgür yazılım prensiplerine uygun olarak geliştirilmiştir

(description created with ai)
