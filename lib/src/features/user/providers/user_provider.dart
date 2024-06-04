import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state/user_state.dart';
import '../data_source/user_data_source.dart';

final userStateNotifierProvider =
    StateNotifierProvider.autoDispose<UserStateNotifier, UserState>(
  (ref) => UserStateNotifier(ref.read(userDataSourceProvicer)),
);

final class UserStateNotifier extends StateNotifier<UserState> {
  final UserDataSource _dataSource;

  UserStateNotifier(
    this._dataSource,
  ) : super(const UserState.initial()) {
    final user = _dataSource.me();

    if (user == null) {
      state = const UserState.unauthenticated();
    } else {
      state = const UserState.authenticated();
    }
  }

  Future<void> logout() async {
    await _dataSource.logout();
    state = const UserState.unauthenticated();
  }
}
