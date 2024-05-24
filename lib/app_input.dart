import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInput extends StatefulWidget {
  const TextInput(
      {super.key,
      this.onChanged,
      required this.label,
      this.errorText,
      this.keyboardType,
      this.focusNode,
      this.controller,
      this.autofillHints,
      this.prefixIcon,
      this.suffixIcon,
      this.textInputAction,
      this.onSubmitted,
      this.isMultiline = false});

  final void Function(String)? onChanged;
  final String label;
  final String? errorText;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final List<String>? autofillHints;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final bool isMultiline;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        textInputAction: widget.textInputAction,
        onSubmitted: widget.onSubmitted,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        focusNode: widget.focusNode,
        autofillHints: widget.autofillHints,
        keyboardType: widget.keyboardType,
        autocorrect: false,
        minLines: widget.isMultiline ? 5 : 1,
        maxLines: widget.isMultiline ? 10 : 1,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 16, vertical: widget.isMultiline ? 10 : 0),
            hintText: widget.label,
            constraints: BoxConstraints(
                minHeight: 52,
                maxHeight: widget.isMultiline ? 125 : 75,
                minWidth: 300,
                maxWidth: double.maxFinite),
            hintStyle: GoogleFonts.nunito(
                fontSize: 16, fontWeight: FontWeight.w600, height: 16 / 16),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            errorText: widget.errorText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFFEEEEEE),
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFFEEEEEE),
                )),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.red,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFFEEEEEE),
                ))));
  }
}
