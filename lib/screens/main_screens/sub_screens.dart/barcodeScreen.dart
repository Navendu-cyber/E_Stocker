import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';

class BarcodeScannerScreen extends StatefulWidget {
  final Function(String) onScanned;
  const BarcodeScannerScreen({super.key, required this.onScanned});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool isFlashOn = false;

  void toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
    });
    cameraController.toggleTorch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (barcodeCapture) {
              final barcodes = barcodeCapture.barcodes;
              if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                widget.onScanned(barcodes.first.rawValue!);
              }
            },
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(
                isFlashOn ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
                size: 30,
              ),
              onPressed: toggleFlash,
            ),
          ),
          Positioned(
            bottom: 150,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Align the barcode within the box",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close, color: Colors.white),
                label: Text("Close", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
