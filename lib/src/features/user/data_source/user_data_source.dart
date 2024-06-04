import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/firebase_auth_providers.dart';

final userDataSourceProvicer = Provider<UserDataSource>(
  (ref) => UserDataSource(
    ref.read(firebaseAuthProvider),
  ),
);

class UserDataSource {
  final FirebaseAuth _firebaseAuth;

  UserDataSource(this._firebaseAuth);

  User? me() => _firebaseAuth.currentUser;

  Future<void> logout() => _firebaseAuth.signOut();
}
