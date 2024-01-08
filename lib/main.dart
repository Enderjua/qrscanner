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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Kod Okutucu',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const FirstPage());
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Future<void> checkPermissionStatus() async {
    const permissionCamera = Permission.camera;
    const permissionGalery = Permission.manageExternalStorage;

    var statusCam = await permissionCamera.status;
    var statusGal = await permissionGalery.status;
    if (statusCam.isGranted && statusGal.isGranted) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      print("izin yok");
    }
  }

  Future<void> checkPermanentlyDenied() async {
    const permissionCamera = Permission.camera;
    const permissionGalery = Permission.manageExternalStorage;

    var statusCam = await permissionCamera.status.isPermanentlyDenied;
    var statusGal = await permissionGalery.status.isPermanentlyDenied;
    if (statusCam && statusGal) {
      // SnackBar mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              "Kamera ve Galeri izni istenemiyor. Lütfen ayarlardan bu izni etkinleştirin."),
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
    } else if (statusCam) {
      // SnackBar mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              "Kamera izni istenemiyor. Lütfen ayarlardan bu izni etkinleştirin."),
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
    } else if (statusGal) {
      // SnackBar mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              "Galeri izni istenemiyor. Lütfen ayarlardan bu izni etkinleştirin."),
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
    } else {
      print("izin engeli yok");
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermissionStatus();
    checkPermanentlyDenied();
  }

  Future<void> requestPermission() async {
    const permissionCamera = Permission.camera;
    const permissionGalery = Permission.manageExternalStorage;

    var statusCam = await permissionCamera.status;
    var statusGal = await permissionGalery.status;

    if (await statusCam.isDenied) {
      var one = await permissionCamera.request();
      if (one.isGranted) {
        var two = await permissionGalery.request();
        if (two.isGranted) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          // SnackBar mesajı göster
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  const Text("Galeri izni verilmedi. Lütfen tekrar deneyin."),
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
        }
      } else {
        // SnackBar mesajı göster
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                const Text("Kamera izni verilmedi. Lütfen tekrar deneyin."),
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
      }
    } else if (await statusGal.isDenied) {
      var three = await permissionGalery.request();
      if (three.isGranted) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        // SnackBar mesajı göster
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                const Text("Galeri izni verilmedi. Lütfen tekrar deneyin."),
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 6,
            child: Container(),
          ),
          const Center(
            child: Image(
              image: AssetImage('assets/img/loginasset.png'),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(),
          ),
          Center(
            child: Text(
              "QR Kod Okutucuya Hoşgeldiniz",
              style: GoogleFonts.ptSans(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E1E1E),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Center(
              child: Text(
                'Lütfen uygulamanın istediği kamera, galeri, kontrol ayarları gibi isteklere izin veriniz. Bu QR Kod okuma esnasında uygulamanın ihtiyaç duyduğu şeylerdidr',
                style: GoogleFonts.ptSans(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFA0A0A0),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: const BoxDecoration(
                    color: Color(0xFFFF7D54),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Center(
                  child: Text(
                    'İzin Ver!',
                    style: GoogleFonts.ptSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
