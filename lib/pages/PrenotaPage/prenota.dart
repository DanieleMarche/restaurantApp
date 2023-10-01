// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/PrenotaPage/date_picker_timeline/date_picker_widget.dart';
import 'package:flutter_application_1/pages/PrenotaPage/phone_number_form.dart';

import 'package:flutter_application_1/pages/PrenotaPage/textForm.dart';
import 'package:flutter_application_1/pages/PrenotaPage/time_picker_timeline/time_picker_widget.dart';

import 'date_form.dart';

class Prenota extends StatefulWidget {
  const Prenota({super.key});

  @override
  State<Prenota> createState() => _PrenotaState();

}

class _PrenotaState extends State<Prenota>{

  Map<String, Object> _prenotazione = {};

  bool _pranzoAperti = false;

  bool _martediAperti = false;

  String _result = "";

  TextEditingController nominativo = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController speciali = TextEditingController();
  DatePickerController giorno = DatePickerController();
  TimePickerController lunchController = TimePickerController();
  TimePickerController dinnerController = TimePickerController();
  


  @override
  void initState() {
    super.initState();

    getInitialDatasFromDatabase();

  }

  ///This function gets the datas from the admin account that needs to run correctly
  ///the reservation form.
  void getInitialDatasFromDatabase () async {

    var collection = FirebaseFirestore.instance.collection('admin');
    var docSnapshot = await collection.doc('admin').get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      _pranzoAperti = data?['pranzo_giorni_feriali'];
      _martediAperti = data?['martedì_aperti']; // <-- The value you want to retrieve. 
      // Call setState if needed.
      setState(() {
        _result = "$_pranzoAperti , $_martediAperti";
      });
    } else {
      _pranzoAperti = false;
      _martediAperti = false;
      setState(() {
        _result = "database problem has occurred";
      });
    }
  }

  Future<String> nuovaPrenotazione(var prenotazione) async {
    String testo = "";
    var db = FirebaseFirestore.instance;

    await db.collection("prova").doc().set(prenotazione)
    .then((value) => setState(() {testo = "success";}))
    .catchError((error) => setState(() {testo = "problem has occurred : $error";}));
    
    _prenotazione.clear();

    return testo;
  }

  Widget databaseReturn () {
    if (_prenotazione.isEmpty) {
      return Text(_result);
    } else {
      return FutureBuilder<String>(
        future: nuovaPrenotazione(_prenotazione),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Caricamento...");
          } else {
            _result = "risultato = ${snapshot.data}";
          
            return Text(_result);
            
          }
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),

        backgroundColor: Colors.white,
        title: const Text('Prenota un tavolo', style: TextStyle(color: Colors.black),),
        
      ),
      body: 
      
        Container(

          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 15, left: 10, right: 10),

          child: Column(

            children: [

              TextForm(titolo: 'Nominativo:', hintText: 'Mario Rossi', myController: nominativo, ),
              
              PhoneNumberForm(titolo: "Recapito Telefonico", hintText: "3004005000", myController: telefono),
                
              
              
              DateForm(datePickerController: giorno, lunchTimePickerController: lunchController, dinnerTimePickerController: dinnerController, pranzoGiorniFeriali: _pranzoAperti, martediAperti: _martediAperti,),
              TextForm(titolo: 'Richieste Speciali(facoltativo):', hintText: 'Es. 1 celicalo', myController: speciali,),

              ElevatedButton(

                child: const Text("Prenota il tavolo"),
                onPressed: (){
                  if (nominativo.value.text != "" && telefono.value.text != "" && giorno.currentDate != null)  {

                    DateTime d = giorno.currentDate;

                    if(lunchController.isADateSelected()) {
                      d = d.copyWith(hour: lunchController.ora, minute: lunchController.minuti, second: 00);
                    } else {
                      d = d.copyWith(hour: dinnerController.ora, minute: dinnerController.minuti, second: 00);
                    }
                    

                    setState(() {


                    _prenotazione = {

                    "data" : Timestamp.fromDate(d),
                    "nominativo" : nominativo.value.text,
                    "telefono" : telefono.value.text,
                    "richieste_speciali" : speciali.value.text

                    };
                    });
                    
                  }else {
                    setState(() {
                      _result = "Riempi tutti i campi";
                    });
                  }

                  nominativo.clear();
                  telefono.clear();
                  speciali.clear();

                  
                }
                  
                ),

                DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                  child: databaseReturn()
                )
            ],
          ),
        )
      );

  }
}