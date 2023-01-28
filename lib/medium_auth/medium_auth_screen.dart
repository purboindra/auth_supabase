import 'package:auth_supabase/repository/medium_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MediumSignUpScreen extends ConsumerStatefulWidget {
  const MediumSignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MediumSignUpScreenState();
}

class _MediumSignUpScreenState extends ConsumerState<MediumSignUpScreen> {
  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();

  void signUp() {
    ref
        .read(mediumAuthRepositoryProvider)
        .signUp(email: _emailC.text, password: _passwordC.text);
  }

  void signIn() {
    ref
        .read(mediumAuthRepositoryProvider)
        .signIn(email: _emailC.text, password: _passwordC.text);
  }

  void signOut() {
    ref.read(mediumAuthRepositoryProvider).signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supabase x Riverpod'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextFormField(
              controller: _emailC,
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.all(18),
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordC,
              decoration: InputDecoration(
                filled: true,
                hintText: 'Password',
                contentPadding: const EdgeInsets.all(18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 222, 222, 222),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 50),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 10),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
                // SIGN UP
                // signUp();

                // SIGN IN
                signIn();
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            ElevatedButton(
                onPressed: () => signOut(), child: const Text('Sign Out')),
          ],
        ),
      ),
    );
  }
}
