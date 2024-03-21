import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAuthProvider extends ChangeNotifier{
  User? firebaseUserAuth;

  void setUsers(User? newFirebaseUserAuth){
    firebaseUserAuth = newFirebaseUserAuth;
  }
  bool isFirebaseUserLoggedIn(){
    if(FirebaseAuth.instance.currentUser== null)return false;
    firebaseUserAuth = FirebaseAuth.instance.currentUser;
    return true;
  }

  Future<void> signOut() async{
    firebaseUserAuth = null;
    return await FirebaseAuth.instance.signOut();
  }
}