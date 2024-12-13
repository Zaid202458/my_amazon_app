import 'package:flutter/material.dart';
import 'package:my_amazon_app/core/constants/global_var.dart';
import 'package:my_amazon_app/features/auth/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:my_amazon_app/shared/providers/language_provider.dart';
import 'package:my_amazon_app/features/auth/widgets/auth_header.dart';
import 'package:my_amazon_app/features/auth/widgets/sign_in_form.dart';
import 'package:my_amazon_app/features/auth/widgets/sign_up_form.dart';
import 'package:my_amazon_app/features/auth/widgets/auth_footer.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth_screen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signin;
  final _signInFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final AuthService authService = AuthService();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.isArabic;

    return Scaffold(
      backgroundColor: GlobalVar.greyBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuthHeader(
                      title: _auth == Auth.signin
                          ? l10n.signIn
                          : l10n.createAccount,
                    ),
                    const SizedBox(height: 20),
                    if (_auth == Auth.signup)
                      SignUpForm(
                        nameController: _nameController,
                        emailController: _emailController,
                        passwordController: _passwordController,
                        addressController: _addressController,
                        formKey: _signUpFormKey,
                        isLoading: _isLoading,
                        onSignUp: _performSignUp,
                      ),
                    if (_auth == Auth.signin)
                      SignInForm(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        formKey: _signInFormKey,
                        isLoading: _isLoading,
                        onSignIn: _performSignIn,
                        isArabic: isArabic,
                      ),
                    const SizedBox(height: 20),
                    AuthFooter(
                      isSignIn: _auth == Auth.signin,
                      onToggleAuth: () {
                        setState(() {
                          _auth =
                              _auth == Auth.signin ? Auth.signup : Auth.signin;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _performSignUp() async {
    if (_signUpFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        address: _addressController.text,
      );

      setState(() {
        _isLoading = false;
      });
    }
  }

  void _performSignIn() async {
    if (_signInFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });
    }
  }
}
