import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/custom_buttons.dart';
import 'package:my_amazon_app/common/widgets/custom_textfields.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/features/auth/services/auth_service.dart';

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
  Auth _auth = Auth.signup;
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
    return Scaffold(
      backgroundColor: GlobalVar.backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              GlobalVar.backgroundColor,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Updated Logo and Title
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const FlutterLogo(size: 80),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Welcome to My Amazon App",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: GlobalVar.secondaryColor,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Sign in to continue",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Updated Card Style
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          // Sign Up Option
                          _buildAuthOptionTile(
                            title: "Create Account",
                            value: Auth.signup,
                            context: context,
                          ),

                          // Sign Up Form
                          if (_auth == Auth.signup)
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Form(
                                key: _signUpFormKey,
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      controller: _nameController,
                                      hintText: "Full Name",
                                      prefixIcon: Icons.person_outline,
                                    ),
                                    const SizedBox(height: 16),
                                    CustomTextField(
                                      controller: _emailController,
                                      hintText: "Email Address",
                                      prefixIcon: Icons.email_outlined,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 16),
                                    CustomTextField(
                                      controller: _passwordController,
                                      hintText: "Password",
                                      prefixIcon: Icons.lock_outline,
                                      obscureText: !_isPasswordVisible,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordVisible =
                                                !_isPasswordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    MyCustomeButton(
                                      txt: "Sign Up",
                                      onClick:
                                          _isLoading ? null : _performSignUp,
                                      backgroundColor: GlobalVar.secondaryColor,
                                      isLoading: _isLoading,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          // Sign In Option
                          _buildAuthOptionTile(
                            title: "Sign In",
                            value: Auth.signin,
                            context: context,
                          ),

                          // Sign In Form
                          if (_auth == Auth.signin)
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Form(
                                key: _signInFormKey,
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      controller: _emailController,
                                      hintText: "Email Address",
                                      prefixIcon: Icons.email_outlined,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 16),
                                    CustomTextField(
                                      controller: _passwordController,
                                      hintText: "Password",
                                      prefixIcon: Icons.lock_outline,
                                      obscureText: !_isPasswordVisible,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordVisible =
                                                !_isPasswordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {
                                          // Implement forgot password
                                        },
                                        child: const Text(
                                          "Forgot Password?",
                                          style: TextStyle(
                                            color: GlobalVar.secondaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    MyCustomeButton(
                                      txt: "Sign In",
                                      onClick:
                                          _isLoading ? null : _performSignUp,
                                      backgroundColor: GlobalVar.secondaryColor,
                                      isLoading: _isLoading,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // Updated Social Login Style
                  const SizedBox(height: 32),
                  _buildSocialLoginOptions(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Update the auth option tile style
  Widget _buildAuthOptionTile({
    required String title,
    required Auth value,
    required BuildContext context,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: _auth == value
            ? GlobalVar.secondaryColor.withOpacity(0.1)
            : Colors.transparent,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _auth == value ? GlobalVar.secondaryColor : Colors.black54,
          ),
        ),
        leading: Radio<Auth>(
          activeColor: GlobalVar.secondaryColor,
          value: value,
          groupValue: _auth,
          onChanged: (Auth? val) {
            setState(() {
              _auth = val!;
            });
          },
        ),
      ),
    );
  }

  // Update social login button style
  Widget _buildSocialLoginButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 32,
            color: GlobalVar.secondaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginOptions() {
    return Column(
      children: [
        Text(
          "or continue with",
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialLoginButton(
              icon: Icons.g_mobiledata,
              onTap: () {
                // Implement Google Sign-In
              },
            ),
            const SizedBox(width: 16),
            _buildSocialLoginButton(
              icon: Icons.facebook,
              onTap: () {
                // Implement Facebook Sign-In
              },
            ),
            const SizedBox(width: 16),
            _buildSocialLoginButton(
              icon: Icons.apple,
              onTap: () {
                // Implement Apple Sign-In
              },
            ),
          ],
        ),
      ],
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

  // void _performSignIn() async {
  //   if (_signInFormKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     await authService.signInUser(
  //       context: context,
  //       email: _emailController.text,
  //       password: _passwordController.text,
  //     );

  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
}
