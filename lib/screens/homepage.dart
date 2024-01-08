// ignore_for_file: deprecated_member_use

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scannerqrcode/main.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scannerqrcode/screens/history.dart';
import 'package:scannerqrcode/screens/qrscanner.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  Barcode? result;
  bool scanner = false;
  bool isQRCodeScanned = false;
  var adding;
  Future<void> checkPermissionStatus() async {
    const permissionCamera = Permission.camera;
    const permissionGalery = Permission.manageExternalStorage;

    var statusCam = await permissionCamera.status;
    var statusGal = await permissionGalery.status;
    if (!statusCam.isGranted && !statusGal.isGranted) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const FirstPage()));
    } else {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermissionStatus();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: height / 10,
          ),
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Center(
            child: Text(
              "QR Kodu Okut",
              style: GoogleFonts.ptSans(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E1E1E),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Center(
              child: Text(
                'Lütfen kamera seçeneğini mi yoksa galeri seçeneğini mi kullanacağınıza karar verin. Daha sonrasında QR kodu okutun!',
                style: GoogleFonts.ptSans(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFA0A0A0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height / 7,
          ),
          scanner == true
              ? Flexible(
                  flex: 50,
                  child: _buildQrView(context),
                )
              : const Center(
                  child: Image(
                    image: AssetImage('assets/giphy/qrcode.gif'),
                  ),
                ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              'QR Kodu Okutun!',
              style: GoogleFonts.ptSans(
                fontSize: 17.0,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFA0A0A0),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Flexible(
            flex: 5,
            child: Container(),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: width / 8, right: width / 8),
              child: InkWell(
                onTap: () {
                  if (!isQRCodeScanned) {
                    setState(() {
                      scanner = !scanner;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: const BoxDecoration(
                      color: Color(0xFF7387EC),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      )),
                  child: const Center(
                    child: Text(
                      'Kamera ile QR Kod Okut!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.photoFilm),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                      "Galeri aracılığı ile QR Okutmak şu anda mümkün değil."),
                  backgroundColor: const Color(0xFFFF7D54),
                  behavior: SnackBarBehavior.floating,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  elevation: 10,
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height - 100,
                    right: 20,
                    left: 20,
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: height / 16,
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.history),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryPage()));
                },
              ),
              const SizedBox(width: 20), // İkona aralık eklemek için SizedBox
              IconButton(
                color: Colors.blue,
                icon: const FaIcon(FontAwesomeIcons.qrcode),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      // Eğer QR kodu zaten tarandıysa, bir sonraki tarama sonucunu işleme alma
      if (!isQRCodeScanned) {
        // Eğer QR kodu "http" içeriyorsa web sitesi gibi davran
        if (scanData.code!.contains("http")) {
          try {
            var response = await http.get(Uri.parse(scanData.code!));

            if (response.statusCode == 200) {
              var document = parse(response.body);

              var titleElement = document.head!.querySelector('title');
              var title = titleElement?.text;

              setState(() {
                adding = addRecord(title.toString(), scanData.code!,
                    'İnternet Sitesi', DateTime.now().toString());
              });
            }
          } catch (e) {}
        }
      }

      // QR kodu zaten tarandı olarak işaretle
      isQRCodeScanned = true;

      // Navigator.push'ı addPostFrameCallback içine alıyoruz
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRResultPage(qrResult: scanData.code!),
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

@HiveType(typeId: 0)
class ScannerHistory extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String content;

  @HiveField(2)
  late String type;

  @HiveField(3)
  late String date;
}

// Adaptörü ekleyin
class ScannerHistoryAdapter extends TypeAdapter<ScannerHistory> {
  @override
  final int typeId = 0;

  @override
  ScannerHistory read(BinaryReader reader) {
    return ScannerHistory()
      ..title = reader.readString()
      ..content = reader.readString()
      ..type = reader.readString()
      ..date = reader.readString();
  }

  @override
  void write(BinaryWriter writer, ScannerHistory obj) {
    writer.writeString(obj.title);
    writer.writeString(obj.content);
    writer.writeString(obj.type);
    writer.writeString(obj.date);
  }
}

Future<Box<ScannerHistory>> addRecord(
    String title, String content, String type, String date) async {
  await Hive.openBox<ScannerHistory>('history');

  final box = Hive.box<ScannerHistory>('history');

  final post = ScannerHistory()
    ..title = title
    ..content = content
    ..type = type
    ..date = date;
  // ignore: unused_local_variable
  final postId = box.add(post);
  return box;
}
