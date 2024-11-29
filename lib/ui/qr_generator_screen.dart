import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  String? qrLink;
  String? qrName;
  bool isGenerated = false;
  final ScreenshotController _screenshotController = ScreenshotController();

  // QR Shape Option
  String _qrShape = "Round";

  // Fungsi untuk membagikan QR Code
  void _shareQRCode() async {
    if (qrLink != null && qrName != null) {
      final Uint8List? imageBytes =
          await _screenshotController.captureFromWidget(
        PrettyQr(
          data: qrLink!,
          size: 200,
          roundEdges: _qrShape == "Round",
          elementColor: const Color(0xFF2B61E3),
        ),
      );

      if (imageBytes != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = '${directory.path}/qr_code.png';
        final imageFile = File(imagePath)..writeAsBytesSync(imageBytes);

        final xFile = XFile(imageFile.path);

        await Share.shareXFiles(
          [xFile],
          text: "Here is my QR code: $qrName",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate QR Code"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField for entering the URL
            TextField(
              decoration: InputDecoration(
                labelText: "Link to generate",
                hintText: "Enter the URL",
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 3, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: const Color(0xFFE5EDFF),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                prefixIcon: const Icon(Icons.link),
              ),
              onChanged: (value) {
                qrLink = value;
              },
            ),
            const SizedBox(height: 24),
            // TextField for QR Code Name
            TextField(
              decoration: InputDecoration(
                labelText: "Name your QR Code",
                hintText: "Enter QR code name",
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 3, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: const Color(0xFFE5EDFF),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                prefixIcon: const Icon(Icons.text_fields),
              ),
              onChanged: (value) {
                qrName = value;
              },
            ),
            const SizedBox(height: 24),
            // Button to Generate QR
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B61E3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Generate QR",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  if (qrLink != null &&
                      qrLink!.isNotEmpty &&
                      qrName != null &&
                      qrName!.isNotEmpty) {
                    setState(() {
                      isGenerated = true;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please enter a valid link and name!")),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 32),
            // Area to display QR Code
            if (isGenerated) ...[
              Text(
                "Select QR Style:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              // Custom Dropdown style using DropdownButtonFormField
              DropdownButtonFormField<String>(
                value: _qrShape,
                decoration: InputDecoration(
                  labelText: "QR Shape",
                  filled: true,
                  fillColor: const Color(0xFFE5EDFF),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Round",
                    child: Text("Round"),
                  ),
                  DropdownMenuItem(
                    value: "Square",
                    child: Text("Square"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _qrShape = value!;
                  });
                },
              ),

              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Screenshot(
                        controller: _screenshotController,
                        child: PrettyQr(
                          data: qrLink!,
                          size: 200,
                          roundEdges: _qrShape == "Round",
                          elementColor: const Color(0xFF2B61E3),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: _shareQRCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2B61E3),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Icon(
                          Icons.share,
                          color: Colors.white,
                          size: 24,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
