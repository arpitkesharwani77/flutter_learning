import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool hidePassword = true; // 👁️ toggle ke liye
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                const Text(
                  "Welcome Back 👋",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Login to continue",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 30),

                /// EMAIL
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email required";
                    }
                    if (!value.contains('@')) {
                      return "Invalid email";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                /// PASSWORD WITH SHOW / HIDE ICON
                TextFormField(
                  controller: passwordController,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: const OutlineInputBorder(),

                    /// 👁️ EYE ICON
                    suffixIcon: IconButton(
                      icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password required";
                    }
                    if (value.length < 4) {
                      return "Password too short";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                /// LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (!_formKey.currentState!.validate()) return;

                            setState(() {
                              isLoading = true;
                              errorMessage = '';
                            });

                            final success = await auth.login(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );

                            setState(() => isLoading = false);

                            if (!success) {
                              setState(() {
                                errorMessage = "Invalid email or password";
                              });
                            }
                          },
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Login"),
                  ),
                ),

                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                const Spacer(),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    },
                    child: const Text("Don’t have an account? Sign up"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
