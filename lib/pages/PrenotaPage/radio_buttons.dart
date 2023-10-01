import 'package:flutter/material.dart';

class RadioButtons extends StatefulWidget {
  const RadioButtons({super.key});
  
  @override
  State<StatefulWidget> createState() => _RadioButtonsState();

}

class _RadioButtonsState extends State<RadioButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }

}

class _RadioButton extends StatefulWidget{
  _RadioButton({super.key, required this.testo});

  String testo;

  @override
  State<StatefulWidget> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<_RadioButton>{
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {  },
    child: Text(widget.testo),);
  }

}