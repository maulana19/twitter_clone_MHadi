import 'package:flutter/material.dart';
import 'package:twitter_clone/common/rounded_small_button.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/widgets/auth_field.dart';
import 'package:twitter_clone/constants/ui_constants.dart';
import 'package:twitter_clone/features/auth/view/signup_view.dart';
import '../../../theme/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/loading_page.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});
  static route() => MaterialPageRoute(builder: (context) => const LoginView());

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appBar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin() {
    ref.read(AuthControllerProvider.notifier).login(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  Widget build(BuildContext context) {
    final isLoading = ref.watch(AuthControllerProvider);
    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? const Loader()
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      AuthField(controller: emailController, hintText: "Email"),
                      const SizedBox(height: 25.0),
                      AuthField(
                          controller: passwordController, hintText: "Password"),
                      const SizedBox(height: 25.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child:
                            RoundedSmallButton(onTap: onLogin, label: 'Login'),
                      ),
                      const SizedBox(height: 40.0),
                      RichText(
                          text: TextSpan(
                              text: "Tidak Punya Akun ? ",
                              style: const TextStyle(fontSize: 16),
                              children: [
                            TextSpan(
                                text: "Buat Dulu",
                                style: const TextStyle(
                                    color: Pallete.blueColor, fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(context, SignUpView.route());
                                  })
                          ]))
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
