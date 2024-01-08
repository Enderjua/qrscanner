import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:scannerqrcode/screens/homepage.dart';
import 'package:url_launcher/url_launcher.dart';

class QRResultPage extends StatelessWidget {
  final String qrResult;

  late final Uri _url;

  QRResultPage({Key? key, required this.qrResult}) : super(key: key) {
    _url = Uri.parse(qrResult);
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // AppBar'ı beyaz yapar
        elevation: 0, // AppBar'ın gölgesini kaldırır
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black), // Geri ok
          onPressed: () {
            Navigator.pop(context); // Geriye git
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(),
            flex: 1,
          ),
          Padding(
            padding: EdgeInsets.only(right: width / 2 + 12),
            child: Text(
              "Sonuç",
              style: TextStyle(fontSize: 40.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: width / 5, right: width / 4, top: height / 10),
            child: Image(image: AssetImage('assets/img/internet.png')),
          ),
          SizedBox(
            height: height / 7,
          ),
          Padding(
            padding: EdgeInsets.only(right: width / 2),
            child: Text(
              "İnternet Sitesi",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: height / 15,
          ),
          Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: Text(
              qrResult,
            ),
          ),
          Flexible(
            child: Container(),
            flex: 25,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            child: InkWell(
              onTap: _launchUrl,
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    "İnternet sitesine git",
                    style: TextStyle(
                      color: Color(0xFF5A5A5A),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            child: InkWell(
              onTap: () async {
                var records = await getRecords();
                for (var record in records) {
                  print(record.title +
                      ' ' +
                      record.content +
                      ' ' +
                      record.type +
                      ' ' +
                      record.date);
                }
              },
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Yazdır.",
                    style: TextStyle(
                      color: Color(0xFF5A5A5A),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<ScannerHistory>> getRecords() async {
  await Hive.openBox<ScannerHistory>('history');

  final box = Hive.box<ScannerHistory>('history');
  final List<ScannerHistory> posts = box.values.toList();
  return posts;
}
