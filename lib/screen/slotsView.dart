import 'dart:ffi';
import 'package:date_format/date_format.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SlotView extends StatefulWidget {
  @override
  _SlotViewState createState() => _SlotViewState();
}

class _SlotViewState extends State<SlotView> {
  var a = [0, 0, 1, 1, 1, 1, 0, 1, 0, 1];
  double right = 0.0;
  double left = 0.0;
  int select = -1;

  double _height;
  double _width;

  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Pick a Slot"),
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    width: _width / 3.1,
                    height: _height / 13,
                    margin: EdgeInsets.only(top: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dateController,
                      onSaved: (String val) {
                        _setDate = val;
                      },
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.only(top: 0.0)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    width: _width / 3.1,
                    height: _height / 12,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                      onSaved: (String val) {
                        _setTime = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeController,
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(3)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: _height - ((_height / 9) * 2),
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
                      SizedBox(
                        width: 5,
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
                      SizedBox(
                        width: 5,
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
                SizedBox(
                  height: 10,
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
        ],
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
