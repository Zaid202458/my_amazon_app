import 'package:flutter/material.dart';

class MyCustomeButton extends StatelessWidget {
  final String txt;
  final VoidCallback? onClick;
  final Color backgroundColor;
  final bool isLoading;

  const MyCustomeButton({
    Key? key,
    required this.txt,
    required this.onClick,
    required this.backgroundColor,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onClick,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              txt,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
    );
  }
}
