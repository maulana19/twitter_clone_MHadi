import 'package:flutter/material.dart';
import 'package:twitter_clone/common/loading_page.dart';
import 'package:twitter_clone/constants/ui_constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import '../../../constants/constants.dart';
import 'package:flutter/gestures.dart';
import '../../../common/common.dart';
import '../../../theme/theme.dart';
import '../widgets/auth_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});
  static route() => MaterialPageRoute(builder: (context) => const SignUpView());

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appBar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSignUp() {
    ref.read(AuthControllerProvider.notifier).signup(
        email: emailController.text,
        password: passwordController.text,
        context: context);
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
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  AuthField(controller: emailController, hintText: 'Email'),
                  const SizedBox(height: 25.0),
                  AuthField(
                      controller: passwordController, hintText: 'Password'),
                  const SizedBox(height: 40.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RoundedSmallButton(
                      onTap: onSignUp,
                      label: 'Sign Up',
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  RichText(
                      text: TextSpan(
                          text: "Sudah Punya Akun ? ",
                          style: const TextStyle(fontSize: 16),
                          children: [
                        TextSpan(
                            text: "Login",
                            style: const TextStyle(
                                color: Pallete.blueColor, fontSize: 16),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context, LoginView.route());
                              })
                      ]))
                ]),
              ),
            )),
    );
  }
}
