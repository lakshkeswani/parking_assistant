import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parking_assistant/Service/auth.dart';
import 'package:parking_assistant/authenticate/register.dart';
import 'package:parking_assistant/authenticate/signin.dart';
import 'package:parking_assistant/model/user.dart';
import 'package:parking_assistant/screen/finalizebooking.dart';
import 'package:parking_assistant/screen/home.dart';
import 'package:parking_assistant/screen/slotsView.dart';
import 'package:parking_assistant/screen/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<USer>.value(
      value: AuthService().user,
      child:
          (MaterialApp(title: 'parking assistant', initialRoute: '/', routes: {
        '/': (context) => Wrapper(),
        '/home': (context) => Home(),
        '/register': (context) => Register(),
        '/signin': (context) => SignIn(),
        '/SlotView': (context) => SlotView(),
            // 'finalizebooking':(context) => FinalizeBooking()
      })),
    );
  }
}
