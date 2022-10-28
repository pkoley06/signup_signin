import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:signup_signin/screen/dashboard/home_screen.dart';
import 'package:signup_signin/screen/registration/signin_screen.dart';
import 'package:signup_signin/service/auth_service/user_registration_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext signUpContext) {
    UserRegistrationController providerController =
        Provider.of<UserRegistrationController>(signUpContext);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        elevation: 5,
        backgroundColor: Colors.red[800],
      ),
      body: Consumer<UserRegistrationController>(
        builder: (BuildContext consumerContext, Controller, child) {
          return Padding(
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
                    TextFormField(
                      obscureText: true,
                      controller: providerController.confirmPasswordController,
                      decoration: const InputDecoration(
                          label: Text("Confirm password"),
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
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (providerController
                                              .usernameController.text ==
                                          "" ||
                                      providerController
                                              .passwordController.text ==
                                          "") {
                                    ScaffoldMessenger.of(signUpContext)
                                        .showSnackBar(SnackBar(
                                      content:
                                          Text(providerController.required),
                                      backgroundColor: Colors.red,
                                    ));
                                  } else if (providerController
                                          .passwordController.text !=
                                      providerController
                                          .confirmPasswordController.text) {
                                    ScaffoldMessenger.of(signUpContext)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          providerController.passwordNotMatch),
                                      backgroundColor: Colors.red,
                                    ));
                                  } else {
                                    providerController.loading = true;
                                    User? result = await providerController
                                        .registerUser(consumerContext);

                                    if (result != null) {
                                      providerController.usernameController
                                          .clear();
                                      providerController.passwordController
                                          .clear();
                                      providerController
                                          .confirmPasswordController
                                          .clear();
                                      // ignore: use_build_context_synchronously
                                      Navigator.pushAndRemoveUntil(
                                        consumerContext,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HomeScreen(result),
                                        ),
                                        (route) => false,
                                      );
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(signUpContext)
                                          .showSnackBar(SnackBar(
                                        content:
                                            Text(providerController.registered),
                                        backgroundColor: Colors.green,
                                      ));
                                    }
                                  }
                                  providerController.loading = false;
                                },
                                child: const Text("Sign Up")),
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
                            consumerContext,
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text(
                            "Already have an account ? sign In here !")),
                    SignInButton(Buttons.google, text: "Continue with Google",
                        onPressed: () async {
                      providerController.loading = true;
                      User? result =
                          await providerController.signInWithGoogle();
                      if (result != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                            consumerContext,
                            MaterialPageRoute(
                                builder: ((context) => HomeScreen(result))),
                            (route) => false);

                        print(result);
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(signUpContext)
                            .showSnackBar(SnackBar(
                          content: Text(providerController.registered),
                          backgroundColor: Colors.green,
                        ));
                        providerController.loading = false;
                      }
                    })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
