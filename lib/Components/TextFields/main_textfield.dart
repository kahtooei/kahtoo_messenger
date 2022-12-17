import 'package:flutter/material.dart';
import 'package:kahtoo_messenger/Constants/Styles.dart';

class MainTextField extends StatelessWidget {
  final String? hint;
  final Function(String)? onChanged;
  final bool? isPassword;
  const MainTextField({
    super.key,
    this.hint,
    this.onChanged,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        onChanged:
            onChanged != null ? (newValue) => onChanged!(newValue) : null,
        style: StylesRepo.getStyle(style_name: "mainTextField"),
        obscureText: isPassword ?? false,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hint ?? '',
          hintStyle: StylesRepo.getStyle(style_name: "hintMainTextField"),
        ),
      ),
    );
  }
}
