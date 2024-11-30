import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_amazon_app/constants/global_var.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_amazon_app/constants/error_handling.dart';
import 'package:my_amazon_app/constants/utils.dart';
import 'package:my_amazon_app/models/user.dart';
import 'package:my_amazon_app/providers/user_provider.dart';

class AuthService {
  // sign up user
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
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
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
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
          SharedPreferences prefs = await SharedPreferences.getInstance();

          // Create user from response
          User user = User.fromJson(res.body);

          // Update provider
          Provider.of<UserProvider>(context, listen: false)
              .setUserFromModel(user);

          // Save token
          await prefs.setString('x-auth-token', user.token);

          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
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
        userProvider.setUserFromModel(User.fromJson(userRes.body));
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
