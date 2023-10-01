import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberForm extends StatefulWidget {
  PhoneNumberForm({super.key, required this.titolo, required this.hintText, required this.myController, this.textInputType});

  String titolo;
  String hintText;
  TextEditingController myController;
  TextInputType? textInputType;

  @override
  State<PhoneNumberForm> createState() => _PhoneNumberFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _PhoneNumberFormState extends State<PhoneNumberForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
   
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next step.
    return Column(
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          margin: const EdgeInsets.only(bottom: 10, left: 10),
          child: Text(
            widget.titolo,
            style: const TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 15
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: InternationalPhoneNumberInput(
            onInputChanged: (phoneNumber) {}, 
            hintText: widget.hintText,
            textFieldController: widget.myController,
            countries: const ["IT"],
            inputDecoration: InputDecoration(
            border:  const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            hintText: widget.hintText
          ),
          //maxLength: 10,
          spaceBetweenSelectorAndTextField: 0.0,
          )
        )
        
    ]);
  }
}