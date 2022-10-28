import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup_signin/screen/registration/signin_screen.dart';

import '../screen/dashboard/home_screen.dart';
import '../screen/registration/signup_screen.dart';
import '../service/auth_service/user_registration_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext myAppContext) {
    // return ChangeNotifierProvider<UserRegistrationController>(
    //     create: (_) => UserRegistrationController(),
    //     child: const SplashScreen());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserRegistrationController>(
          create: (_) => UserRegistrationController(),
        ),
        Provider<SignUpScreen>(create: (_) => const SignUpScreen()),
        Provider<SignInScreen>(create: (_) => const SignInScreen())
      ],
      builder: (context, child) => MaterialApp(
        home: StreamBuilder(
          stream: UserRegistrationController().firebaseAuth.authStateChanges(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return HomeScreen(snapshot.data);
            } else {
              return const SignUpScreen();
            }
          },
        ),
      ),
    );
  }
}
