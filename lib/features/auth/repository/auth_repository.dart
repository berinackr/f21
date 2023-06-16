import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f21_demo/core/failure.dart';
import 'package:f21_demo/core/providers/firebase_providers.dart';
import 'package:f21_demo/core/type_defs.dart';
import 'package:f21_demo/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AuthRepository({required FirebaseFirestore firestore, required FirebaseAuth auth})
      : _firestore = firestore,
        _auth = auth;

  CollectionReference get _users => _firestore.collection('users');

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  FutureEither<UserModel?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      final UserModel userModel = UserModel(
        uid: user!.uid,
      );
      await _users.doc(user.uid).set(userModel.toMap());
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      UserModel? userModel = await getUserData(userCredential.user!.uid).first;
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  void logOut() async {
    await _auth.signOut();
  }

  FutureEither<UserModel?> setProfileInfos(
    UserModel userModel,
  ) async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        throw Failure("User is null");
      }
      await _users.doc(user.uid).update(userModel.toMap());
      return right(userModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.message.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  User? getCurrentUser() {
    final User? user = _auth.currentUser;
    return user;
  }

  Stream<UserModel?> getUserData(String uid) {
    return _users
        .doc(uid)
        .snapshots()
        .map((event) => event.exists ? UserModel.fromMap(event.data() as Map<String, dynamic>) : null);
  }
}
