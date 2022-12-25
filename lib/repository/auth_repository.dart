import 'dart:developer';

import 'package:auth_supabase/core/fpdart.dart';
import 'package:auth_supabase/failure/failures.dart';
import 'package:auth_supabase/model/auth_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;

final authRepositoryProvider = riverpod.Provider((ref) {
  return AuthRepository(supabase: Supabase.instance);
});

class AuthRepository {
  final Supabase _supabase;
  AuthRepository({
    required Supabase supabase,
  }) : _supabase = supabase;

  FutureEither<AuthModel> signUpUser(
      {required String email, required String password}) async {
    try {
      AuthModel authModel =
          AuthModel(uid: '', email: '', password: '', imgUrl: '');
      final response =
          await _supabase.client.auth.signUp(email: email, password: password);
      Session session = response.session!;
      log('SESSION ${session.user.toJson()}');
      authModel = AuthModel(
        uid: session.user.id,
        email: email,
        password: password,
        imgUrl:
            'https://images.unsplash.com/photo-1577375729152-4c8b5fcda381?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1160&q=80',
      );
      return right(authModel);
    } catch (e) {
      log('FROM AUTH REPO SIGN UP $e');
      return left(Failure(message: e.toString()));
    }
  }

  FutureVoid signOut() async {
    try {
      return right(_supabase.client.auth.signOut());
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  FutureEither<AuthResponse> signInUser({
    required String email,
    required String password,
  }) async {
    late AuthResponse response;
    try {
      if (email.contains('@')) {
        response = await _supabase.client.auth
            .signInWithPassword(email: email, password: password);
        User user = response.user!;
        log('USER SIGN IN ${user.email}');
        Session session = response.session!;
        log('SESSION SIGN IN ${session.user.toJson()}');
      } else {}
      return right(response);
    } catch (e) {
      log('FROM AUTH REPO SIGN IN $e');
      return left(Failure(message: e.toString()));
    }
  }
}
