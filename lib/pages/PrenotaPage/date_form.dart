import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/PrenotaPage/time_picker_timeline/time_picker_widget.dart';

import 'date_picker_timeline/date_picker_widget.dart';

class DateForm extends StatefulWidget {
  const DateForm({super.key});

  

  @override
  State<DateForm> createState() => _DateFormState();
}

class _DateFormState extends State<DateForm> {

  List<String> orariPranzo = ["12:30", "12:45", "13:00", "13:15", "13:30", "13:45", "14:00", "14:15", "14:30", "14:45"];
  List<String> orariCena = ["19:30", "19:45", "20:00", "20:15", "20:30", "20:45", "21:00", "21:15", "21:30", "21:45", "22:00", "22:15", "22:30", "22:45"];

  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        
        children:  <Widget>[
        
        Container(
          margin: EdgeInsets.only(left: 15),
          alignment: Alignment.centerLeft,
          child: const Text("Data:", textAlign: TextAlign.left),),
        
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: DatePicker(DateTime.now(), initialSelectedDate: DateTime.now(), daysCount: 20)
        ),

        Container(
          margin: EdgeInsets.only(left: 15),
          alignment: Alignment.centerLeft,
          child: const Text("Ora:", textAlign: TextAlign.left),
          ), 
        
        TimePicker(orariPranzo)

        ]

      )

    );
  }

}