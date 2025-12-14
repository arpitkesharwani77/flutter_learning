import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

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
                  "Create Account ✨",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Signup to get started",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 30),

                /// NAME
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                /// EMAIL
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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

                /// PASSWORD
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
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

                /// SIGNUP BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            setState(() {
                              isLoading = true;
                            });

                            await auth.signup(
                              nameController.text.trim(),
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );

                            setState(() {
                              isLoading = false;
                            });

                            Navigator.pop(context); // back to login
                          },
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Create Account"),
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
