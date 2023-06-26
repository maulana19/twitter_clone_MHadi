import 'package:fpdart/fpdart.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/providers.dart';

import '../core/core.dart';

final authApiProvider = Provider(
  (ref) {
    final account = ref.watch(appWriteAccountProvider);
    return AuthApi(account: account);
  },
);

abstract class IAuthAPI {
  FutureEither<model.Account> signUp(
      {required String email, required String password});
  FutureEither<model.Session> login(
      {required String email, required String password});
  Future<model.Account?> currenUserAccount();
}

class AuthApi implements IAuthAPI {
  final Account _account;
  AuthApi({required Account account}) : _account = account;

  @override
  Future<model.Account?> currenUserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException catch (e, stackTrace) {
      return null;
    } catch (e, stackTrace) {
      return null;
    }
  }

  @override
  FutureEither<model.Account> signUp(
      {required String email, required String password}) async {
    try {
      final account = await _account.create(
          userId: ID.unique(), email: email, password: password);
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Some unexpected error occured', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<model.Session> login(
      {required String email, required String password}) async {
    try {
      final session =
          await _account.createEmailSession(email: email, password: password);
      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      return left(
          Failure(e.message ?? "Some Unexpected error occured", stackTrace));
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }
}
