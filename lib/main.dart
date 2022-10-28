import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:signup_signin/util/myApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splash()));
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    splash();
  }

  splash() async {
    await Future.delayed(const Duration(seconds: 2), () {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MyApp(),
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext mainContext) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        height: 100,
        width: 100,
        child: Image.asset('asset/image/flutter.png'),
      )),
    );
  }
}
