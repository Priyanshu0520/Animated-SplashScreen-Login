// login_widget.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:healtcare_ai/feature/onboarding/screen/onboarding_screen.dart';
import 'package:healtcare_ai/feature/splashscreen/widgets/button.dart';
import 'package:healtcare_ai/feature/splashscreen/widgets/custom_text_field.dart';
import 'package:healtcare_ai/feature/splashscreen/widgets/label_text.dart';
import 'package:healtcare_ai/feature/utils/string_config.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = StringConfig.instance;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LabelText(text: config.emailLabel),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: config.enterEmailHint,
          ),
          const SizedBox(height: 16),
          LabelText(text: config.passwordLabel),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: config.enterPasswordHint,
            controller: _passwordController,
            obscureText: _obscureText,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey.shade400,
              ),
              onPressed: _toggleVisibility,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 240.0),
            child: Text(
              config.forgotPassword,
              style: const TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 157, 206, 249),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Button(
            text: config.loginButton,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OnboardingScreen()),
              );
            },
          ),
          const SizedBox(height: 24),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 80, 99, 110),
              ),
              children: [
                TextSpan(text: config.signUpPrompt),
                TextSpan(
                  text: config.signUp,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
