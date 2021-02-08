import 'package:flutter/material.dart';
import 'package:parking_assistant/Service/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String Email = "";
  String Name = "";
  String Password = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Text("Register"),
        actions: [
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Log In"))
        ],
      ),
      body: Container(
        child: Form(
          key: _formkey,
          child: Center(
            child: Container(
              width: 250,
              height: 350,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue[600],
                    width: 8,
                  ),
                  color: Colors.blue[600],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0,
                    )
                  ]),
              child: Column(
                children: [
                  TextFormField(
                    validator: (val) => val.isEmpty ? "enter a name" : null,
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    onChanged: (val) {
                      setState(() => Name = val);
                    },
                    cursorColor: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (val) => val.isEmpty ? "enter a email" : null,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: "Email"),
                    onChanged: (val) {
                      setState(() => Email = val);
                    },
                    cursorColor: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (val) =>
                        val.length < 6 ? "enter a password" : null,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white),
                        suffix: InkWell(
                          onTap: _toggle,
                          child: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        )
                    ),
                    onChanged: (val) {
                      setState(() => Password = val);
                    },
                    cursorColor: Colors.white,
                    obscureText: _obscureText,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        dynamic result =
                            await _auth.RegisterUser(Email, Password);
                        if (result == null) {
                          setState(() => error = "invalid email");
                          print(error);
                        } else {
                          print("google baba hello");
                        }
                      }
                    },
                    color: Colors.black,
                    child: Text(
                      "Sign Up",
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
          ),
        ),
      ),
    );
  }
}
