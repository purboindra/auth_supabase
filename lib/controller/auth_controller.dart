import 'dart:developer';

import 'package:auth_supabase/auth/screen/auth_screen.dart';
import 'package:auth_supabase/home_page/home_screen.dart';
import 'package:auth_supabase/model/auth_model.dart';
import 'package:auth_supabase/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final userProvider = StateProvider<AuthModel?>((ref) {
  return null;
});

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      repository: ref.watch(authRepositoryProvider), ref: ref);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _repository;
  final Ref _ref;

  AuthController({
    required AuthRepository repository,
    required Ref ref,
  })  : _repository = repository,
        _ref = ref,
        super(false);

  Future signUpUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    AuthResponse authResponse = AuthResponse();
    final response =
        await _repository.signUpUser(email: email, password: password);
    state = false;
    response.fold(
        (l) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Maaf terjadi kesalahan'))), (r) {
      _ref.watch(userProvider.notifier).update((state) => r);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
      log('SIGN UP SUCCESS $r');
    });
    return authResponse;
  }

  Future<AuthResponse> signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    AuthResponse authResponse = AuthResponse();
    final response =
        await _repository.signInUser(email: email, password: password);
    state = false;
    response.fold(
        (l) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Maaf terjadi kesalahan'))), (r) {
      authResponse = r;
      log('SIGN IN SUCCESS $r');
    });
    return authResponse;
  }

  void signOut(BuildContext context) async {
    state = true;
    final response = await _repository.signOut();
    state = false;
    response.fold((l) => log(l.toString()), (r) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AuthScreen(),
          ));

      Future.delayed(
        const Duration(seconds: 1),
        () => _ref.watch(userProvider.notifier).update((state) => null),
      );
    });
  }
}
