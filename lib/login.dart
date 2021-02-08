import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  String x="nothing entered";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container (
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value){
                    if(value.isEmpty)
                      {
                        return "enter somthing";
                      }
                    return null;
                  },

                ),
                GestureDetector(
                    onTap: (){
                      setState(() {
                        x="something";
                      });
                    },
                    child: Text("click here",style: TextStyle(
                      backgroundColor: Colors.red,
                    ),)


                ),
                Text(x),

              ],
            ),
          ),
      ),
        ),
    );
  }
}
