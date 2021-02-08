import 'package:flutter/material.dart';
import 'package:parking_assistant/authenticate/register.dart';
import 'package:parking_assistant/authenticate/signin.dart';
class athenticate extends StatefulWidget {
  @override
  _athenticateState createState() => _athenticateState();
}

class _athenticateState extends State<athenticate> {
  bool showSignIn=true;

  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {


    if(showSignIn){
      return SignIn(toggleView:toggleView);
    }else
      {
        return Register(toggleView:toggleView);}

  }
}
