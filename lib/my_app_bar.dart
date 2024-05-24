import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar(
      {super.key,
      required this.content,
      this.hasPadding = true,
      this.topPadding,
      this.color,
      this.gradient,
      this.borderRadius,
      this.backgroundImage});

  final Widget? content;
  final bool hasPadding;
  final double? topPadding;
  final Color? color;
  final double? borderRadius;
  final Gradient? gradient;
  final ImageProvider? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: topPadding ?? MediaQuery.paddingOf(context).top,
          left: hasPadding ? 24 : 0,
          right: hasPadding ? 24 : 0),
      decoration: BoxDecoration(
          color: color ?? Colors.purple.withOpacity(0.03),
          image: backgroundImage != null
              ? DecorationImage(
                  image: backgroundImage!,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.purple.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                )
              : null,
          gradient: gradient,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(borderRadius ?? 15),
              bottomRight: Radius.circular(borderRadius ?? 15))),
      child: content,
    );
  }
}
