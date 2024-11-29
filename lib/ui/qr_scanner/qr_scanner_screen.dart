import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:share_plus/share_plus.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  bool _flashOn = false; // Status flash, defaultnya mati
  late MobileScannerController _scannerController;

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      returnImage: true,
    );
  }

  // Toggle flash status
  void _toggleFlash() {
    setState(() {
      _flashOn = !_flashOn;
      _scannerController.toggleTorch(); // Aktifkan/matikan flash
    });
  }

  // Menampilkan bottom sheet dengan data QR dan gambar
  void showCustomBottomSheet(
      BuildContext context, String? barcodeData, Uint8List image) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.6,
          minChildSize: 0.4,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  // Animasi untuk teks
                  AnimatedOpacity(
                    opacity: barcodeData == null ? 0.0 : 1.0,
                    duration: const Duration(seconds: 1),
                    child: Text(
                      barcodeData ?? "No reference found from this QR",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Animasi untuk gambar QR
                  AnimatedScale(
                    scale: barcodeData == null ? 0.0 : 1.0,
                    duration: const Duration(seconds: 1),
                    child: Center(
                      child: Image.memory(
                        image,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tombol Share untuk membagikan QR Code
                  ElevatedButton.icon(
                    onPressed: () {
                      if (barcodeData != null) {
                        // Membagikan rawValue QR Code
                        Share.share(barcodeData);
                      }
                    },
                    icon: const Icon(Icons.share),
                    label: const Text("Share QR Code"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/generator");
            },
            icon: const Icon(Icons.qr_code),
          )
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text deskripsi
                const Text(
                  'Scan the QR Code to process your payment',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 5),
                IconButton(
                  onPressed: _toggleFlash,
                  icon: Icon(
                    _flashOn ? Icons.flash_off_rounded : Icons.flash_on_rounded,
                  ),
                  color: Color(0xFF2B61E3),
                  iconSize: 40,
                ),
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 330,
                    width: 330,
                    child: MobileScanner(
                      controller: _scannerController,
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        final Uint8List? image = capture.image;

                        for (final barcode in barcodes) {
                          print(
                              'Barcode is valid! Here is the source ${barcode.rawValue}');
                        }

                        if (image != null) {
                          showCustomBottomSheet(
                              context, barcodes.first.rawValue, image);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Text info tentang QR Code
                Container(
                  width: 327,
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFCFDDFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'The QR Code will be automatically detected when you position it between the guide lines',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF2B61E3),
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 16,
            right: 16,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tombol pertama
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/scanner');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2B61E3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: const Text(
                          "Scan Code",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Tombol kedua
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/generator');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE5EDFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: const Text(
                          "Enter Code",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
