import 'package:parking_assistant/screen/home.dart';
import 'package:parking_assistant/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:parking_assistant/model/user.dart';
import 'package:flutter/material.dart';
class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user =Provider.of<USer>(context);
    if(user==null) {
      return athenticate();
      }else{
      return Home();
    }

  }
}
