import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signup_signin/model/user_model.dart';

class UserRegistrationController extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool loading = false;

  String required = "All Fields are required !";
  String passwordNotMatch = "Passowrd doesn't match !";
  String registered = "Registered successfully !";
  String logedIn = "Login Successfully !";

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<User?> registerUser(context) async {
    UserModel userModel = UserModel();
    userModel.userName = usernameController.text;
    userModel.password = passwordController.text;
    userModel.confirmPassword = confirmPasswordController.text;
    notifyListeners();
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: usernameController.text,
              password: passwordController.text);
      return userCredential.user;
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message.toString()),
        backgroundColor: Colors.red,
      ));
    } catch (error) {
      print(error);
    }
    return null;
  }

  // ignore: non_constant_identifier_names
  Future<User?> SignInUser(context) async {
    UserModel userModel = UserModel();
    userModel.userName = usernameController.text;
    userModel.password = passwordController.text;
    notifyListeners();
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email: usernameController.text,
              password: passwordController.text);
      return userCredential.user;
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message.toString()),
        backgroundColor: Colors.red,
      ));
    } catch (error) {
      print(error);
    }
    return null;
  }

  //Sign In with Google

  Future<User?> signInWithGoogle() async {
    notifyListeners();
    try {
      //Trigger the authentication dialog
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      if (googleSignInAccount == null) {
        return null;
      }

      // obtain the auth request from the request
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // create new credential
      final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      //once sign in return the user data from the firebase
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
      // ignore: dead_code
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      print(error.message);
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future signOut() async {
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
    notifyListeners();
  }
}
