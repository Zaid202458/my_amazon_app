import 'package:flutter/material.dart';
import 'package:my_amazon_app/shared/widgets/custom_textfields.dart';
import 'package:my_amazon_app/shared/widgets/custom_buttons.dart';
import 'package:my_amazon_app/core/constants/global_var.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController addressController;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final VoidCallback onSignUp;

  const SignUpForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.addressController,
    required this.formKey,
    required this.isLoading,
    required this.onSignUp,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: widget.nameController,
            hintText: l10n.fullName,
            prefixIcon: Icons.person_outline,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: widget.emailController,
            hintText: l10n.emailAddress,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: widget.addressController,
            hintText: l10n.address,
            prefixIcon: Icons.location_on_outlined,
            maxLines: 2,
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
          const SizedBox(height: 15),
          MyCustomeButton(
            txt: l10n.createAccount,
            onClick: widget.isLoading ? null : widget.onSignUp,
            backgroundColor: GlobalVar.secondaryColor,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }
}
