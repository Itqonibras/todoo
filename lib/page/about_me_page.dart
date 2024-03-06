import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/input_decoration_theme.dart';

class AboutMePage extends StatelessWidget {
  static const routeName = '/aboutme';

  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 24,
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF5038BC),
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Text(
          'todoo.',
          style: GoogleFonts.varela(fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'About Me',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://i.ibb.co/hDx5ZvM/buatristek.jpg',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Task title
              const Text(
                'Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextField(
                readOnly: true,
                enabled: false,
                decoration: commonInputDecoration.copyWith(
                  hintText: 'Nibras Itqon Ihsani',
                  hintStyle: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 8),
              // Task title
              const Text(
                'Date of Birth',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextField(
                readOnly: true,
                enabled: false,
                decoration: commonInputDecoration.copyWith(
                  hintText: '07/06/2004',
                  hintStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.date_range_sharp),
                  prefixIconColor: const Color(0xFF5038BC),
                ),
              ),
              const SizedBox(height: 8),
              // Task title
              const Text(
                'Instagram',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextField(
                readOnly: true,
                enabled: false,
                decoration: commonInputDecoration.copyWith(
                  hintText: '@itqonibras',
                  hintStyle: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
