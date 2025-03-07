import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class Aboutapp extends StatelessWidget {
  const Aboutapp({super.key});

  void _shareApp() {
    const String appLink = "";
    Share.share(
        "Check out E-Stocker! 🚀 Manage your inventory effortlessly. Download now: $appLink");
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _shareApp();
              },
              icon: Icon(Icons.share_rounded))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ' E-Stocker - Smart Inventory Management',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "E-Stocker is a simple yet powerful inventory management solution designed to help businesses track stock, manage sales, and monitor growth effectively. With a minimalist black-and-white theme, it ensures a distraction-free experience while keeping your business operations smooth.",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              Text(
                '✨ Key Features:',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              _buildFeature(" Easy Product & Stock Management"),
              _buildFeature(" Sales Tracking & Growth Analysis"),
              _buildFeature(" Low Stock Notifications"),
              _buildFeature(" Quick & Efficient Order Processing"),
              _buildFeature(" Dark & Light Mode Support"),
              _buildFeature(" Easy Product Add Using Barcode "),
              const SizedBox(height: 20),
              Text(
                "With E-Stocker, you’ll never have to worry about managing inventory manually again. Stay ahead, stay stocked! 🚀",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 80,
              ),
              Text('Version 0.0.1')
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create a feature row
  Widget _buildFeature(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
