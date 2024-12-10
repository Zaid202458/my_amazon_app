import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_amazon_app/shared/providers/language_provider.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        textAlign: Provider.of<LanguageProvider>(context, listen: false).isArabic 
            ? TextAlign.right 
            : TextAlign.left,
      ),
    ),
  );
}
