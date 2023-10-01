import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/PrenotaPage/time_picker_timeline/time_picker_widget.dart';

import 'date_picker_timeline/date_picker_widget.dart';

class DateForm extends StatefulWidget {
  DateForm({super.key, required this.datePickerController, required this.lunchTimePickerController, required this.dinnerTimePickerController, required this.pranzoGiorniFeriali, required this.martediAperti});

  DatePickerController datePickerController;
  TimePickerController lunchTimePickerController;
  TimePickerController dinnerTimePickerController;

  late bool _lunchSelected;
  late bool _dinnerSelected;


  bool pranzoGiorniFeriali;
  bool martediAperti;

  get whichIsSelected {
    if (_lunchSelected == true) {
      return lunchTimePickerController;
    }
    return dinnerTimePickerController;
  }

  @override
  State<DateForm> createState() => _DateFormState();
}

class _DateFormState extends State<DateForm> {

  final List<String> orariPranzo = ["12:30", "12:45", "13:00", "13:15", "13:30", "13:45", "14:00", "14:15", "14:30", "14:45"];
  final List<String> orariCena = ["19:30", "19:45", "20:00", "20:15", "20:30", "20:45", "21:00", "21:15", "21:30", "21:45", "22:00", "22:15", "22:30", "22:45"];





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
          child: DatePicker(DateTime.now(), daysCount: 20, controller: widget.datePickerController, tuesday: widget.martediAperti,)
        ),

        Container(
          margin: EdgeInsets.only(left: 15),
          alignment: Alignment.centerLeft,
          child: const Row(children: [
            Text("Cena:", textAlign: TextAlign.left),
            
          ],),
          
          ), 
          TimePicker(orariPranzo, controller: widget.lunchTimePickerController, onTimeChange: (selectedDate) {widget._lunchSelected = true; widget._dinnerSelected = false; widget.dinnerTimePickerController.deselectTime();} ,),

          Container(
          margin: EdgeInsets.only(left: 15),
          alignment: Alignment.centerLeft,
          child: const Row(children: [
            Text("Pranzo:", textAlign: TextAlign.left),
            
          ],),
          
          ), 
          TimePicker(orariCena, controller: widget.dinnerTimePickerController, onTimeChange: (selectedDate) {
            widget._dinnerSelected = true;
            widget._lunchSelected = false; 
            widget.lunchTimePickerController.deselectTime();
          },)
          
        ]

      )

    );
  }

}