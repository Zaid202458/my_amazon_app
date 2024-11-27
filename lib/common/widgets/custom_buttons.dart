import 'package:flutter/material.dart';

class MyCustomeButton extends StatelessWidget {
  final String txt;
  final VoidCallback onClick;

  const MyCustomeButton({super.key, required this.txt, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(txt),
    );
  }
}
