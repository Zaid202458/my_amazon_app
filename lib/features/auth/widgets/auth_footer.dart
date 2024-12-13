import 'package:flutter/material.dart';
import 'package:my_amazon_app/core/constants/global_var.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthFooter extends StatelessWidget {
  final bool isSignIn;
  final VoidCallback onToggleAuth;

  const AuthFooter({
    super.key,
    required this.isSignIn,
    required this.onToggleAuth,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isSignIn ? l10n.dontHaveAccount : l10n.alreadyHaveAccount,
              style: const TextStyle(fontSize: 14),
            ),
            TextButton(
              onPressed: onToggleAuth,
              child: Text(
                isSignIn ? l10n.createAccount : l10n.signIn,
                style: const TextStyle(
                  color: GlobalVar.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 20),
        Text(
          'By continuing, you agree to Amazon\'s Conditions of Use and Privacy Notice.',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
