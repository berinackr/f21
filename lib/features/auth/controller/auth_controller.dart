import 'dart:io';
import 'package:f21_demo/core/providers/storage_repository_provider.dart';
import 'package:f21_demo/features/auth/repository/auth_repository.dart';
import 'package:f21_demo/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:f21_demo/core/utils.dart";

final userProvider = StateProvider<UserModel?>((ref) => null);

final isFirstTimeProvider = StateNotifierProvider<IsFirstTime, bool>(
  (ref) => IsFirstTime(ref: ref),
);

class IsFirstTime extends StateNotifier<bool> {
  IsFirstTime({required Ref ref}) : super(true);

  void trigger() {
    state = false;
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
      authRepository: ref.watch(authRepositoryProvider),
      ref: ref,
      storageRepository: ref.watch(storageRepositoryProvider)),
);

final authStateChangesProvider = StreamProvider<User?>((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChanges;
});

final getUserDatProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;

  AuthController(
      {required AuthRepository authRepository, required Ref ref, required StorageRepository storageRepository})
      : _authRepository = authRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void signUp(String email, String password, BuildContext context) async {
    state = true;
    final user = await _authRepository.signUp(email, password);
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) => _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

  void signIn(String email, String password, BuildContext context) async {
    state = true;
    final user = await _authRepository.signIn(email, password);
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) => _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

  void logout() async {
    _ref.read(userProvider.notifier).update((state) => null);
    _authRepository.logOut();
  }

  User? getCurrentUser() {
    final user = _authRepository.getCurrentUser();
    return user;
  }

  void setProfileInfos(
    String username,
    DateTime birthDate,
    String gender,
    bool isPregnant,
    File? profilePic,
    double? months,
    DateTime? babyBirthDate,
    BuildContext context,
  ) async {
    final User? user = _authRepository.getCurrentUser();

    UserModel userModel = UserModel(
      username: username,
      birthDate: birthDate,
      gender: gender,
      isPregnant: isPregnant,
      profilePic:
          "https://firebasestorage.googleapis.com/v0/b/ouaf21-3bfc0.appspot.com/o/default.png?alt=media&token=5270b81e-77ed-4cb2-a357-dd7057045f0e",
      uid: user!.uid,
      months: months,
      babyBirthDate: babyBirthDate,
    );
    if (profilePic != null) {
      final res = await _storageRepository.uploadImage(path: "users/profile", id: username, file: profilePic);
      res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => userModel = userModel.copyWith(profilePic: r),
      );
    }
    final profile = await _authRepository.setProfileInfos(userModel);
    profile.fold((error) => showSnackBar(context, error.message), (userModel) {
      _ref.read(userProvider.notifier).update((state) => userModel);
    });
  }

  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  Stream<UserModel?> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }
}
