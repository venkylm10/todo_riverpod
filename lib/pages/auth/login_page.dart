import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_riverpod/constants/app_style.dart';
import 'package:todo_riverpod/pages/auth/signup_page.dart';
import 'package:todo_riverpod/provider/auth_service_provider.dart';
import 'package:todo_riverpod/widgets/square_tile.dart';
import 'package:todo_riverpod/widgets/text_field_widget.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authServices = ref.watch(authServicesProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                const Gap(24),
                TextFieldWidget(
                  title: "Email",
                  hintText: "Enter your email",
                  maxLines: 1,
                  controller: emailController,
                ),
                const Gap(12),
                TextFieldWidget(
                  title: "Password",
                  hintText: "Enter your password",
                  maxLines: 1,
                  controller: passwordController,
                ),
                const Gap(24),
                Container(
                  width: 180,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    onPressed: () {
                      authServices.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context,
                      );
                    },
                    child: const Text(
                      "Login",
                      style: AppStyles.heading1,
                    ),
                  ),
                ),
                const Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Or continue with",
                      style: AppStyles.heading1.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        authServices.signInWithGoogle(context);
                      },
                      child: const SquareTile(
                          imagePath: "assets/images/google.png"),
                    ),
                  ],
                ),
                const Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const Gap(6),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      ),
                      child: const Text(
                        "Sign up",
                        style: AppStyles.heading1,
                      ),
                    ),
                  ],
                ),
                const Gap(24),
              ],
            ),
          )
        ],
      ),
    );
  }
}
