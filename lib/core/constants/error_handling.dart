import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_amazon_app/core/utils/utils.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  final l10n = AppLocalizations.of(context)!;
  
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg'] ?? l10n.errorSomethingWentWrong);
      break;
    case 401:
      showSnackBar(context, l10n.errorUnauthorized);
      break;
    case 500:
      showSnackBar(context, l10n.errorSomethingWentWrong);
      break;
    default:
      showSnackBar(context, l10n.errorSomethingWentWrong);
  }
}

String? validateEmail(String? value, BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  if (value == null || value.isEmpty) {
    return l10n.errorEmptyField;
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return l10n.errorInvalidEmail;
  }
  return null;
}

String? validatePassword(String? value, BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  if (value == null || value.isEmpty) {
    return l10n.errorEmptyField;
  }
  if (value.length < 6) {
    return l10n.errorInvalidPassword;
  }
  return null;
}

String? validateConfirmPassword(String? value, String password, BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  if (value == null || value.isEmpty) {
    return l10n.errorEmptyField;
  }
  if (value != password) {
    return l10n.errorPasswordMismatch;
  }
  return null;
}
