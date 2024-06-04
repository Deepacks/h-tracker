import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/firebase_auth_providers.dart';

final authFormDataSourceProvider = Provider<AuthFormDataSource>(
  (ref) => AuthFormDataSource(
    ref.read(firebaseAuthProvider),
  ),
);

class AuthFormDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthFormDataSource(this._firebaseAuth);

  Future<Either<String, void>> signup({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to Signup.');
    }
  }

  Future<Either<String, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to Login');
    }
  }

  Future<Either<String, User>> continueWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final response = await _firebaseAuth.signInWithCredential(credential);
        return right(response.user!);
      } else {
        return left('Unknown Error');
      }
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Unknow Error');
    }
  }
}
