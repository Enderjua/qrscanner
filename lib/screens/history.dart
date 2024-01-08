// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scannerqrcode/main.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scannerqrcode/screens/homepage.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  Barcode? result;
  bool scanner = false;
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
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
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
                    "QR Kod Geçmişi",
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
                      'Daha önce okuttuğunuz QR Kodlar, telefonunuzun local sisteminde NoSQL olarak depolanır ve burada karşınıza çıkar. Bu geçmiş online olarak hiçbir yerde depolanmaz, hiçbir yere gönderilmez veya saklanmaz. NoSQL teknolojisi ile yalnızca local bağlantı kurulur ve siz vermediğiniz sürece kimsenin eline geçemez!',
                      style: GoogleFonts.ptSans(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFA0A0A0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.blue,
                ),
                SizedBox(
                  height: height / 32,
                ),
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(height: height / 10),
                          Flexible(
                            flex: 1,
                            child: Container(),
                          ),
                          Center(
                            child: Text(
                              "QR Kod Geçmişi",
                              style: GoogleFonts.ptSans(
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E1E1E),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 12.0),
                            child: Center(
                              child: Text(
                                'Daha önce okuttuğunuz QR Kodlar, telefonunuzun local sisteminde NoSQL olarak depolanır ve burada karşınıza çıkar. Bu geçmiş online olarak hiçbir yerde depolanmaz, hiçbir yere gönderilmez veya saklanmaz. NoSQL teknolojisi ile yalnızca local bağlantı kurulur ve siz vermediğiniz sürece kimsenin eline geçemez!',
                                style: GoogleFonts.ptSans(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFA0A0A0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Divider(
                            thickness: 2,
                            color: Colors.blue,
                          ),
                          SizedBox(height: height / 32),
                          FutureBuilder<List<ScannerHistory>>(
                            future: getRecords(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                List<ScannerHistory> records =
                                    snapshot.data ?? [];
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      records.length < 1 ? 2 : records.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var record = records[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15.0, top: 8.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(15.0),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 12.0),
                                              child: Image(
                                                  image: AssetImage(
                                                      'assets/img/log.png')),
                                            ),
                                            // Diğer widget'lar buraya eklenmeli
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                          Flexible(
                            flex: 5,
                            child: Container(),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(height: height / 16),
                          const Divider(color: Colors.grey, thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                color: Colors.blue,
                                icon: const FaIcon(FontAwesomeIcons.history),
                                onPressed: () {},
                              ),
                              const SizedBox(width: 20),
                              IconButton(
                                color: Colors.grey,
                                icon: const FaIcon(FontAwesomeIcons.qrcode),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Flexible(
                  flex: 5,
                  child: Container(),
                ),
                const SizedBox(
                  height: 5,
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
                      color: Colors.blue,
                      icon: const FaIcon(FontAwesomeIcons.history),
                      onPressed: () {},
                    ),
                    const SizedBox(
                        width: 20), // İkona aralık eklemek için SizedBox
                    IconButton(
                      color: Colors.grey,
                      icon: const FaIcon(FontAwesomeIcons.qrcode),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      },
                    ),
                  ],
                ),
              ],
            )),
      ]),
    );
  }
}

Future<List<ScannerHistory>> getRecords() async {
  await Hive.openBox<ScannerHistory>('history');

  final box = Hive.box<ScannerHistory>('history');
  final List<ScannerHistory> posts = box.values.toList();
  return posts;
}

String formatDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDate =
      "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";

  return formattedDate;
}
