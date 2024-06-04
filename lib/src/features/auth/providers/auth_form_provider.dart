import 'state/auth_form_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data_source/auth_form_data_source.dart';

final authFormStateNotifierProvider =
    StateNotifierProvider.autoDispose<AuthFormStateNotifier, AuthFormState>(
  (ref) => AuthFormStateNotifier(
    ref.read(authFormDataSourceProvider),
  ),
);

class AuthFormStateNotifier extends StateNotifier<AuthFormState> {
  final AuthFormDataSource _dataSource;

  AuthFormStateNotifier(this._dataSource)
      : super(const AuthFormState.initial());

  Future<void> login({required String email, required String password}) async {
    state = const AuthFormState.loading();

    final response = await _dataSource.login(email: email, password: password);

    state = response.fold(
      (error) => AuthFormState.unauthenticated(message: error),
      (_) => const AuthFormState.authenticated(),
    );
  }

  Future<void> signup({required String email, required String password}) async {
    state = const AuthFormState.loading();

    final response = await _dataSource.signup(email: email, password: password);

    state = response.fold(
      (error) => AuthFormState.unauthenticated(message: error),
      (_) => const AuthFormState.authenticated(),
    );
  }

  Future<void> continueWithGoogle() async {
    state = const AuthFormState.loading();

    final response = await _dataSource.continueWithGoogle();

    state = response.fold(
      (error) => AuthFormState.unauthenticated(message: error),
      (_) => const AuthFormState.authenticated(),
    );
  }
}
