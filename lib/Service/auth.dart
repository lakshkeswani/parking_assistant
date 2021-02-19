import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking_assistant/model/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //user object based on firebase user
  USer _userFromFirebaseUser(User user) {
    return user != null ? USer(uid: user.uid,email:user.email ) : null;
  }

  //auth change user stream
  Stream<USer> get user {
    return _auth
        .authStateChanges()
        //  .map((User user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  Future sign_in_anon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //verify users email
  String verifyEmail ()
  {
    User user = FirebaseAuth.instance.currentUser;
    if (!user.emailVerified) {
      user.sendEmailVerification();
      return "not verified";
    }
    else
      return "";

  }

  //signin
  Future UserSignin(String email,String password) async {
    try {
      UserCredential response = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user=response.user;
      await verifyEmail();
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString()+"wrong  ... . .. . . .cdcdcd");
      return null;
    }
  }


  // register with email and password
  Future RegisterUser(String email,String password) async {
    try {
      UserCredential response = await _auth.createUserWithEmailAndPassword(email:email , password: password);
    User user=response.user;
     await verifyEmail();
    return _userFromFirebaseUser(user);
    } catch (e) {
       print(e.toString()+"wrong  ... . .. . . .cdcdcd");
       return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
