import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class AppTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Widget? suffixWidget;
  final Widget? prefixIcon;
  final int? maxLines;
  final String? Function(String?)? validator;

  const AppTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.suffixWidget,
    this.maxLines,
    this.prefixIcon,
    this.validator,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  String? _errorText;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validate);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validate);
    super.dispose();
  }

  void _validate() {
    final error = widget.validator?.call(widget.controller.text);
    if (error != _errorText) {
      setState(() {
        _errorText = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: widget.maxLines ?? 1,
      obscureText: widget.obscureText,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(),
        suffixIcon: widget.suffixWidget,
        prefixIcon: widget.prefixIcon,
        errorText: _errorText, // Display the error text
      ),
      onChanged: (value) {
        _validate();
      },
    );
  }
}