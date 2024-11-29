// import 'package:flutter/material.dart';

// enum Auth {
//   signin,
//   signup,
// }

// class AuthScreen extends StatefulWidget {
//   static const String routeName = "/auth_screen";
//   const AuthScreen({super.key});

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();

//   @override
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _nameController.dispose();
//     _passwordController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 50),
//               const Text(
//                 'Sign in to your Account',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Sign in to your Account',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 50),
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   suffixIcon: const Icon(Icons.visibility_off),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () {
//                     // Add functionality for forgot password
//                   },
//                   child: const Text(
//                     'Forgot Password?',
//                     style: TextStyle(color: Colors.green),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Add login functionality
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//                 child: const Text(
//                   'Login',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Center(
//                 child: Text(
//                   'Or login with',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       // Add Google login functionality
//                     },
//                     icon: Image.asset(
//                         'assets/google.png'), // Add Google icon asset
//                     iconSize: 40,
//                   ),
//                   const SizedBox(width: 20),
//                   IconButton(
//                     onPressed: () {
//                       // Add Facebook login functionality
//                     },
//                     icon: Image.asset(
//                         'assets/facebook.png'), // Add Facebook icon asset
//                     iconSize: 40,
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Don\'t have an account? '),
//                   TextButton(
//                     onPressed: () {
//                       // Add register functionality
//                     },
//                     child: const Text(
//                       'Register',
//                       style: TextStyle(color: Colors.green),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
