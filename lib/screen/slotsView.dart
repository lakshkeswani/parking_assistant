import 'dart:ffi';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlotView extends StatefulWidget {
  @override
  _SlotViewState createState() => _SlotViewState();
}

class _SlotViewState extends State<SlotView> {
  var a = [0, 0, 1, 1, 1, 1, 0, 1, 0, 1];
  double right = 0.0;
  double left = 0.0;
  int select = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Pick a Slot"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 20,
              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        "Available",
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        "Selected",
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        "Bookesd",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(a.length, (index) {
                  if (index % 2 == 0) {
                    setState(() {
                      right = 20;
                      left = 0;
                    });
                  } else {
                    setState(() {
                      right = 0;
                      left = 50;
                    });
                  }
                  if (a[index] == 1) {
                    return GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: left, right: right),
                        child: gettile(index, select),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          select = index;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: left, right: right),
                        child: gettile(index, select),
                      ),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_right),
        onPressed: () {
          Navigator.pushNamed(context, 'finalizebooking');
        },
      ),
    );
  }

  Widget gettile(int index,int select){
    bool isSelected = index == select ;
    bool isbooked = a[index] == 1;
    return Container(
        child: isbooked
            ? Icon(
                FontAwesomeIcons.carSide,
                size: 90,
                color: Colors.grey,
              )
            : isSelected
                ? Icon(
                    FontAwesomeIcons.carSide,
                    size: 90,
                    color: Colors.blue,
                  )
                : Icon(
                    FontAwesomeIcons.carSide,
                    size: 90,
                    color: Colors.green,
                  ),
        padding: EdgeInsets.all(40),
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(
              width: 3, color: Colors.black, style: BorderStyle.solid),
          bottom: BorderSide(
              width: 9, color: Colors.black, style: BorderStyle.solid),
        )));
  }
}
