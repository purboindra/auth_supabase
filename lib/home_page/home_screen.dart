import 'package:auth_supabase/controller/auth_controller.dart';
import 'package:auth_supabase/model/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthModel user = ref.watch(userProvider.notifier).state!;
    bool isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: isLoading == true
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text(user.email),
                    leading: Image.network(user.imgUrl),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                    onPressed: () => ref
                        .read(authControllerProvider.notifier)
                        .signOut(context),
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
      ),
    );
  }
}
