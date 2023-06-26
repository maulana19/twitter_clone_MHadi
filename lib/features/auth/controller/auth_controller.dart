import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/core/core.dart';

import '../../home/view/home_view.dart';
import '../view/login_view.dart';

final AuthControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) {
    return AuthController(authAPI: ref.watch(authApiProvider));
  },
);
final currenUserAccountProvider = FutureProvider((ref) {
  final AuthController = ref.watch(AuthControllerProvider.notifier);
  return AuthController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthApi _authAPI;
  AuthController({required AuthApi authAPI})
      : _authAPI = authAPI,
        super(false);

  Future<model.Account?> currentUser() => _authAPI.currenUserAccount();
  void signup({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(email: email, password: password);
    state = false;
    res.fold((l) => showSnackbar(context, l.message), (r) {
      showSnackbar(context, "Berhasil Menambahkan Akun Baru, Silahkan Login !");
      Navigator.push(context, LoginView.route());
    });
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.login(email: email, password: password);
    state = false;
    res.fold((l) => showSnackbar(context, l.message), (r) {
      Navigator.push(context, HomeView.route());
    });
  }
}
