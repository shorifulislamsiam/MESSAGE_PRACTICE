import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_practice/login_screen/controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
   LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //netlify adding

        body: Center(
          child: Column(
           
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              SizedBox(child: Text("Login Screen")),
              SizedBox(height: 30),
               Obx(() {
                if (!loginController.isInitialized.value) {
                  return const CircularProgressIndicator();
                }
                
                if (loginController.isLoading.value) {
                  return const CircularProgressIndicator();
                }
                
                return ElevatedButton.icon(
                  onPressed: () => loginController.signInWithGoogle(),
                  icon: const Icon(Icons.login),
                  label: const Text('Sign in with Google'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                );
              }),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  //facebook sign-in function will work here
                },
                child: Text(
                  "Sign-in with facebook",
                  style: TextStyle(color: Color(0XFF000000), fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  final LoginController authController = Get.find<LoginController>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => authController.signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Obx(() {
          final user = authController.firebaseUser.value;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (user?.photoURL != null)
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user!.photoURL!),
                ),
              const SizedBox(height: 20),
              Text(
                'Welcome, ${user?.displayName ?? "User"}!',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                user?.email ?? '',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          );
        }),
      ),
    );
  }
}
