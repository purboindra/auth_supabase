import 'dart:developer';

import 'package:auth_supabase/auth/screen/sign_up_screen.dart';
import 'package:auth_supabase/controller/auth_controller.dart';
import 'package:auth_supabase/repository/auth_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isHidePasswordProvider = StateNotifierProvider<HidePassword, bool>((ref) {
  return HidePassword();
});

class HidePassword extends StateNotifier<bool> {
  HidePassword() : super(true);
  isHide() {
    state = !state;
  }
}

class AuthScreen extends ConsumerWidget {
  AuthScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLoading = ref.watch(authControllerProvider);
    bool isHide = ref.watch(isHidePasswordProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/instagram_logo.png',
                    color: Colors.white,
                    height: 60,
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(66, 91, 91, 91),
                      filled: true,
                      contentPadding: const EdgeInsets.all(18),
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
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
                    controller: _passwordController,
                    obscureText: isHide,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(66, 91, 91, 91),
                      filled: true,
                      hintText: 'Password',
                      contentPadding: const EdgeInsets.all(18),
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 222, 222, 222),
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          ref.read(isHidePasswordProvider.notifier).isHide();
                        },
                        icon: Icon(
                          isHide
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 24,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Lupa kata sandi?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue.shade800,
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
                    // TODO CHANGE WITH SIGN IN METHOD
                    onPressed: () => ref
                        .read(authControllerProvider.notifier)
                        .signUpUser(
                            email: _emailController.text,
                            password: _passwordController.text,
                            context: context),
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
                    height: 30,
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          color: Color.fromARGB(255, 173, 173, 173),
                        ),
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      Text(
                        'ATAU',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 173, 173, 173),
                        ),
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      Expanded(
                          child: Divider(
                        color: Color.fromARGB(255, 173, 173, 173),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      log('FACEBOOK');
                      ref.read(authRepositoryProvider).signInFacebook();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.facebook_sharp,
                          color: Color.fromARGB(255, 14, 115, 232),
                          size: 32,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Masuk dengan Facebook',
                          style: TextStyle(
                            color: Color.fromARGB(255, 14, 115, 232),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: isLoading == true
          ? const SizedBox()
          : Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 0),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  children: [
                    const TextSpan(text: 'Belum punya akun? '),
                    TextSpan(
                      text: 'Daftar.',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            )),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 14, 115, 232),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
