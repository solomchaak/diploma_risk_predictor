import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({super.key, required this.label, this.isFirst = false});

  final String label;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: isFirst ? 0 : 16, bottom: 8),
        alignment: Alignment.centerLeft,
        child: Text(label,
            style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600)));
  }
}
