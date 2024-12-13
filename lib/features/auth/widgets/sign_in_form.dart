import 'package:flutter/material.dart';
import 'package:my_amazon_app/shared/widgets/custom_textfields.dart';
import 'package:my_amazon_app/shared/widgets/custom_buttons.dart';
import 'package:my_amazon_app/core/constants/global_var.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final VoidCallback onSignIn;
  final bool isArabic;

  const SignInForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.isLoading,
    required this.onSignIn,
    required this.isArabic,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: widget.emailController,
            hintText: l10n.emailAddress,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: widget.passwordController,
            hintText: l10n.password,
            prefixIcon: Icons.lock_outline,
            obscureText: !_isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          Align(
            alignment:
                widget.isArabic ? Alignment.centerLeft : Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Implement forgot password
              },
              child: Text(
                l10n.forgotPassword,
                style: const TextStyle(
                  color: GlobalVar.secondaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          MyCustomeButton(
            txt: l10n.signIn,
            onClick: widget.isLoading ? null : widget.onSignIn,
            backgroundColor: GlobalVar.secondaryColor,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }
}
