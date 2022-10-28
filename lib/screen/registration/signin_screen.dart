import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup_signin/screen/dashboard/home_screen.dart';
import 'package:signup_signin/screen/registration/signup_screen.dart';
import 'package:signup_signin/service/auth_service/user_registration_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var sise = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
        elevation: 5,
        backgroundColor: Colors.green[800],
      ),
      body: Consumer<UserRegistrationController>(
        builder: (context, providerController, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: providerController.usernameController,
                    decoration: const InputDecoration(
                        label: Text("Username"),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: providerController.passwordController,
                    decoration: const InputDecoration(
                        label: Text("Password"),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  providerController.loading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          height: 40,
                          width: sise.width,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (providerController
                                            .usernameController.text ==
                                        "" ||
                                    providerController
                                            .passwordController.text ==
                                        "") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(providerController.required),
                                    backgroundColor: Colors.red,
                                  ));
                                } else {
                                  providerController.loading = true;
                                  User? result =
                                      await providerController.SignInUser(
                                          context);

                                  if (result != null) {
                                    providerController.usernameController
                                        .clear();
                                    providerController.passwordController
                                        .clear();
                                    providerController.confirmPasswordController
                                        .clear();
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HomeScreen(result),
                                      ),
                                      (route) => false,
                                    );
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(providerController.logedIn),
                                      backgroundColor: Colors.green,
                                    ));
                                  }
                                }
                                providerController.loading = false;
                              },
                              child: const Text("Sign In")),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () async {
                        providerController.usernameController.clear();
                        providerController.passwordController.clear();
                        providerController.confirmPasswordController.clear();
                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                          "Already have an account ? sign In here !")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
