import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.onPressed,
      required this.label,
      this.loadingText = '',
      this.isLoading = false,
      this.backgroundColor = const Color.fromARGB(255, 188, 71, 221),
      this.foregroundColor = Colors.white,
      this.borderColor = const Color.fromARGB(255, 188, 71, 221),
      this.icon,
      this.height,
      this.width,
      this.fontSize,
      this.borderRadius,
      this.borderWidth,
      this.loadingLabel,
      this.loadingSize});

  final void Function()? onPressed;
  final String label;
  final bool isLoading;
  final String loadingText;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final Widget? icon;
  final double? height;
  final double? width;
  final double? fontSize;
  final BorderRadiusGeometry? borderRadius;
  final double? borderWidth;
  final double? loadingSize;
  final String? loadingLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: height ?? 58,
          maxWidth: width ??
              (MediaQuery.of(context).size.width > 500
                  ? MediaQuery.of(context).size.width / 2
                  : 500)),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            disabledBackgroundColor: Colors.grey.withOpacity(0.3),
            disabledForegroundColor: backgroundColor.withOpacity(0.5),
            minimumSize: const Size(double.maxFinite, 55),
            shape: RoundedRectangleBorder(
                side: onPressed != null
                    ? BorderSide(width: borderWidth ?? 2, color: borderColor)
                    : BorderSide.none,
                borderRadius: borderRadius ?? BorderRadius.circular(32))),
        child: isLoading
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (loadingLabel != null)
                    Text(loadingLabel!,
                        style: GoogleFonts.nunito(
                            color: foregroundColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: loadingSize ?? 25,
                      width: loadingSize ?? 25,
                      child: const CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white)),
                  if (loadingText.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(loadingText,
                          style: GoogleFonts.nunito(
                              color: foregroundColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) icon!,
                  Expanded(
                    child: Text(label,
                        style: GoogleFonts.nunito(
                                fontSize: fontSize,
                                fontWeight: FontWeight.w600,
                                height: 18 / 18)
                            .copyWith(
                                color: onPressed != null
                                    ? foregroundColor
                                    : backgroundColor.withOpacity(0.5)),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
      ),
    );
  }
}
