import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospitalappointmentsystem/Auth/loginView.dart';
import 'package:hospitalappointmentsystem/constants/constants.dart';
import 'package:hospitalappointmentsystem/drawerMenu.dart';

import '../controllers/BottomNavBarController.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("Users");
  final firebaseAuth = FirebaseAuth.instance;
  final BottomNavBarController _controller = Get.put(BottomNavBarController());

//REGISTER
  Future<void> signUp(context,
      {required String name,
      required String email,
      required String password}) async {
    try {
   
      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
             //Succes
        _registerUser(name: name, email: email, password: password);
Constants().goPage(context, DrawerMenu());

       
      }
    } on FirebaseAuthException catch (e) {
errorMessage(e);

    }
  }

  //LOGIN

  Future<void> signIn(context,{required String email, required String password}) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        //Succes
Constants().goPage(context, DrawerMenu());

      }
    } on FirebaseAuthException catch (e) {
      errorMessage(e);
  
    }
  }
//LOGOUT
  Future<void> signOut(context) async {
  await FirebaseAuth.instance.signOut();
  _controller.currentIndex.value=2;
Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>const LoginView(),), (route) => false);

}


  //ADD COLLECTION- USER DATA

  Future<void> _registerUser(
      {required String name,
      required String email,
      required String password}) async {
  
    await userCollection
        .doc(firebaseAuth.currentUser?.uid)
        .set({"name": name, "email": email, "password": password});
  }



  void errorMessage(var e){
        Get.showSnackbar(
        GetSnackBar(
          title: "HATA",
          message: e.message,
          icon: const Icon(Icons.refresh),
          duration: const Duration(seconds: 3),
        ),
      );
  }



  //

}
