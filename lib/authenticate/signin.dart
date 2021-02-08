import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_assistant/Service/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String Email = "";
  String Password = "";
  String error ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sigin to Parker"),
        actions: [
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
                print(" called by signin");
              },
              icon: Icon(Icons.person),
              label: Text("Register"))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formkey,
              child: Center(
                child: Container(
                  height: 300,
                  width: 250,
                  padding: EdgeInsets.symmetric(vertical:5,horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue[600],
                        width: 8,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.blue[600],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 6.0,
                        )
                      ]
                  ),
                  child: Column(
            children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder:OutlineInputBorder(
                        borderSide:  BorderSide(color: Colors.pink[400],width: 3),
                      )
                    ),
                    validator: (val) => val.isEmpty ? "enter email" : null,
                    onChanged: (val) {
                      setState(() => Email = val);
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      focusedBorder:OutlineInputBorder(
                        borderSide:  BorderSide(color: Colors.pink[400],width: 3),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white),
                      suffix: InkWell(
                        onTap: _toggle,
                        child: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (val) => val.isEmpty ? "enter password" : null,
                    onChanged: (val) {
                      setState(() => Password = val);
                    },
                    obscureText: _obscureText,
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    onPressed: () async {

                      if (_formkey.currentState.validate()) {
                        dynamic result =
                        await _auth.UserSignin(Email, Password);
                        if (result == null) {
                          setState(() => error = "incorrect email or password");
                          print(error);
                        } else {
                          print("google baba hello");
                        }
                      }

                    },
                    color: Colors.pink[400],
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  ),
            ],
          ),
                ),
              ))),
    );
  }
}
