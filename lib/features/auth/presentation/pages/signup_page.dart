import 'package:blog_app/core/theme/colors.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_fields.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  static route() {
    return MaterialPageRoute(
      builder: (context) => const SignupPage(),
    );
  }

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              AuthFields(
                hintText: "Name",
                controller: nameController,
              ),
              const SizedBox(height: 15),
              AuthFields(
                hintText: "Email",
                controller: emailController,
              ),
              const SizedBox(height: 15),
              AuthFields(
                hintText: "Password",
                isPass: true,
                controller: passwordController,
              ),
              const SizedBox(height: 20),
              AppGradientButton(
                buttonText: "Sign up",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          AuthSignup(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                  }
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, LoginPage.route());
                },
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: "Sign in",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
