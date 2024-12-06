import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/custom_buttons.dart';
import 'package:my_amazon_app/common/widgets/custom_textfields.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/features/auth/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:my_amazon_app/providers/language_provider.dart';

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

  final AuthService authService = AuthService();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
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
              // Amazon Logo
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset(
                  'assets/images/amazon-logo.png',
                  height: 50,
                ),
              ),
              const SizedBox(height: 20),
              
              // Auth Card
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title
                    Text(
                      _auth == Auth.signin ? l10n.signIn : l10n.createAccount,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 20),

                    // Sign Up Form
                    if (_auth == Auth.signup)
                      Form(
                        key: _signUpFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _nameController,
                              hintText: l10n.fullName,
                              prefixIcon: Icons.person_outline,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: _emailController,
                              hintText: l10n.emailAddress,
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: _passwordController,
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
                              onClick: _isLoading ? null : _performSignUp,
                              backgroundColor: GlobalVar.secondaryColor,
                              isLoading: _isLoading,
                            ),
                          ],
                        ),
                      ),

                    // Sign In Form
                    if (_auth == Auth.signin)
                      Form(
                        key: _signInFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _emailController,
                              hintText: l10n.emailAddress,
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: _passwordController,
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
                              alignment: isArabic ? Alignment.centerLeft : Alignment.centerRight,
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
                              onClick: _isLoading ? null : _performSignIn,
                              backgroundColor: GlobalVar.secondaryColor,
                              isLoading: _isLoading,
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 20),
                    
                    // Switch Auth Mode
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _auth == Auth.signin
                              ? l10n.dontHaveAccount
                              : l10n.alreadyHaveAccount,
                          style: const TextStyle(fontSize: 14),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _auth = _auth == Auth.signin ? Auth.signup : Auth.signin;
                            });
                          },
                          child: Text(
                            _auth == Auth.signin ? l10n.createAccount : l10n.signIn,
                            style: const TextStyle(
                              color: GlobalVar.secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 20),

                    // Terms and Conditions
                    Text(
                      'By continuing, you agree to Amazon\'s Conditions of Use and Privacy Notice.',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
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
