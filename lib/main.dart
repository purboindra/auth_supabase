import 'package:auth_supabase/auth/screen/auth_screen.dart';
import 'package:auth_supabase/reqres_signin/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      // TODO CHANGE WITH YOURS
      /*
    YOU CAN READ THIS DOCUMENTATION
    https://supabase.com/docs/guides/api
    */
      url: '',
      anonKey: '');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}
