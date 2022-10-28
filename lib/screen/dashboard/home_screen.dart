import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup_signin/screen/registration/signin_screen.dart';
import 'package:signup_signin/screen/registration/signup_screen.dart';
import 'package:signup_signin/service/auth_service/user_registration_controller.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    UserRegistrationController provider =
        Provider.of<UserRegistrationController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          //sign out button
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: ((BuildContext context) {
                      return AlertDialog(
                        title: const Text("Please Confirm"),
                        content: const Text("Are you sure to log out?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("No")),
                          TextButton(
                              onPressed: () async {
                                await provider.signOut();
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const SignUpScreen())));
                              },
                              child: const Text("Yes"))
                        ],
                      );
                    }));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [Text("Hi ! User, You are Welcome..!")],
        ),
      ),
    );
  }
}
