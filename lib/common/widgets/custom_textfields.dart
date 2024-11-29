import 'package:flutter/material.dart';
import 'package:my_amazon_app/constants/global_var.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),

        // Prefix Icon
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: GlobalVar.secondaryColor,
              )
            : null,

        // Suffix Icon
        suffixIcon: suffixIcon,

        // Border Styles
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey[400]!,
            width: 1,
          ),
        ),

        // Focused Border
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: GlobalVar.secondaryColor,
            width: 2,
          ),
        ),

        // Error Border
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),

        // Focused Error Border
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),

        // Filled Background
        filled: true,
        fillColor: Colors.grey[100],

        // Content Padding
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      // Validation
      validator: validator ??
          (val) {
            if (val == null || val.isEmpty) {
              return 'This field cannot be empty';
            }

            // Add specific validations based on hint text
            if (hintText.toLowerCase().contains('email')) {
              // Basic email validation
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(val)) {
                return 'Please enter a valid email address';
              }
            }

            if (hintText.toLowerCase().contains('password')) {
              // Basic password strength validation
              if (val.length < 6) {
                return 'Password must be at least 6 characters long';
              }
            }

            return null;
          },
    );
  }
}
