import 'package:flutter/material.dart';
import 'package:my_amazon_app/core/constants/global_var.dart';

class AccountButtons extends StatelessWidget {
  final String txt;
  final VoidCallback onClick;
  const AccountButtons({super.key, required this.txt, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: GlobalVar.secondaryColor.withOpacity(0.5),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: OutlinedButton(
        onPressed: onClick,
        style: OutlinedButton.styleFrom(
          foregroundColor: GlobalVar.secondaryColor,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          txt,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
