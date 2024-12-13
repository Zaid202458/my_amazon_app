// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_amazon_app/shared/widgets/bottom_bar.dart';
import 'package:my_amazon_app/core/constants/global_var.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_amazon_app/core/constants/error_handling.dart';
import 'package:my_amazon_app/core/utils/utils.dart';
import 'package:my_amazon_app/shared/models/user.dart';
import 'package:my_amazon_app/shared/providers/user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthService {
  // sign up user
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String address,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: address,
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse("$uri/api/signup"),
        body: jsonEncode(user.toMap()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final l10n = AppLocalizations.of(context)!;
          showSnackBar(
            context,
            l10n.accountCreatedMessage,
          );
        },
      );
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      print('Sign-up error: $e'); // Log the specific error
      if (e is SocketException) {
        showSnackBar(context, '${l10n.errorSomethingWentWrong}: Network error');
      } else if (e is FormatException) {
        showSnackBar(
            context, '${l10n.errorSomethingWentWrong}: Invalid data format');
      } else {
        showSnackBar(context, '${l10n.errorSomethingWentWrong}: $e');
      }
    }
  }

  // sign in user
  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final l10n = AppLocalizations.of(context)!;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          showSnackBar(context, l10n.loginSuccessMessage);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      print('Sign-in error: $e'); // Log the specific error
      if (e is SocketException) {
        showSnackBar(context, '${l10n.errorSomethingWentWrong}: Network error');
      } else if (e is FormatException) {
        showSnackBar(
            context, '${l10n.errorSomethingWentWrong}: Invalid data format');
      } else {
        showSnackBar(context, '${l10n.errorSomethingWentWrong}: $e');
      }
    }
  }

  // get user data
  Future<void> getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
        return;
      }

      http.Response tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        var userData = jsonDecode(userRes.body);
        var user = User(
          id: userData['_id'] ?? '',
          name: userData['name'] ?? '',
          email: userData['email'] ?? '',
          password: userData['password'] ?? '',
          address: userData['address'] ?? '',
          type: userData['type'] ?? '',
          token: token,
        );
        userProvider.setUser(jsonEncode(user.toMap()));
      }
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      print('Get user data error: $e');
      if (e is SocketException) {
        showSnackBar(context, '${l10n.errorSomethingWentWrong}: Network error');
      } else if (e is FormatException) {
        showSnackBar(
            context, '${l10n.errorSomethingWentWrong}: Invalid data format');
      } else {
        showSnackBar(context, '${l10n.errorSomethingWentWrong}: $e');
      }
    }
  }

  Future<void> logOut(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/auth_screen',
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
