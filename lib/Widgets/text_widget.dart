import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextView extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double? fontSize;
  final Color? fontColor;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const TextView({
    Key? key,
    required this.text,
    this.style,
    this.fontSize,
    this.fontColor,
    this.textAlign,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          TextStyle(
            fontSize: fontSize?.sp ?? 16.sp,
            color: fontColor ?? Colors.black,
            fontFamily: GoogleFonts.poppins()
                .fontFamily,
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
