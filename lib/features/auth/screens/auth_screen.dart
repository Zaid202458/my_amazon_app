import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/custom_buttons.dart';
import 'package:my_amazon_app/common/widgets/custom_textfields.dart';
import 'package:my_amazon_app/constants/global_var.dart';

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

  bool _isPasswordVisible = false;

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo and Title
                const Center(
                  child: Column(
                    children: [
                      FlutterLogo(size: 100),
                      SizedBox(height: 16),
                      Text(
                        "Welcome to My Amazon App",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: GlobalVar.secondaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Authentication Type Selection
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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
                                  onClick: _performSignUp,
                                  backgroundColor: GlobalVar.secondaryColor,
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
                                  onClick: _performSignIn,
                                  backgroundColor: GlobalVar.secondaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Social Login or Alternative Options
                const SizedBox(height: 24),
                _buildSocialLoginOptions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthOptionTile({
    required String title,
    required Auth value,
    required BuildContext context,
  }) {
    return ListTile(
      tileColor: _auth == value
          ? GlobalVar.backgroundColor.withOpacity(0.1)
          : Colors.transparent,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
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

  Widget _buildSocialLoginButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          size: 36,
          color: Colors.black54,
        ),
      ),
    );
  }

  void _performSignUp() {
    if (_signUpFormKey.currentState!.validate()) {
      // Implement sign-up logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign Up Attempted')),
      );
    }
  }

  void _performSignIn() {
    if (_signInFormKey.currentState!.validate()) {
      // Implement sign-in logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign In Attempted')),
      );
    }
  }
}
