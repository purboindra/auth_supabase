import 'dart:developer';
import 'package:auth_supabase/model/auth_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mediumAuthRepositoryProvider = Provider((ref) {
  return MediumAuthRepository(supabase: supabase.Supabase.instance);
});

class MediumAuthRepository {
  final supabase.Supabase _supabase;
  MediumAuthRepository({
    required supabase.Supabase supabase,
  }) : _supabase = supabase;

  // SIGN UP
  Future<AuthModel> signUp(
      {required String email, required String password}) async {
    log('EMAIL $email password $password');
    try {
      AuthModel authModel =
          AuthModel(uid: '', email: '', password: '', imgUrl: '');
      final response =
          await _supabase.client.auth.signUp(email: email, password: password);
      authModel = AuthModel(
          uid: response.user!.id, email: email, password: password, imgUrl: '');
      log('AUTH MODEL $authModel');
      return authModel;
    } catch (e) {
      log('ERROR $e');
      throw 'Error';
    }
  }

  // SIGN IN
  Future<AuthModel> signIn(
      {required String email, required String password}) async {
    try {
      AuthModel authModel =
          AuthModel(uid: '', email: '', password: '', imgUrl: '');
      final response = await _supabase.client.auth
          .signInWithPassword(email: email, password: password);
      log('RESPONSE ${response.user}');
      authModel = AuthModel(
          uid: response.user!.id, email: email, password: password, imgUrl: '');
      log('SIGN IN $authModel');
      return authModel;
    } catch (e) {
      log('ERROR SIGN IN $e');
      throw 'Error';
    }
  }

  // SIGN OUT
  Future<void> signOut() async {
    try {
      _supabase.client.auth.signOut();
    } catch (e) {
      log('ERROR SIGN OUT $e');
      throw 'Error';
    }
  }
}
