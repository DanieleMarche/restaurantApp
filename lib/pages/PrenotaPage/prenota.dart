// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/PrenotaPage/date_picker_timeline/date_picker_widget.dart';

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

  late bool _pranzoAperti;

  String _result = "";

  TextEditingController nominativo = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController speciali = TextEditingController();
  DatePickerController giorno = DatePickerController();
  TimePickerController ora = TimePickerController();

    @override
  void initState() async {
    super.initState();

    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc('doc_id').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      _pranzoAperti = data?['pranzo_giorni_feriali']; // <-- The value you want to retrieve. 
      // Call setState if needed.
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

              TextForm(titolo: 'Nominativo:', hintText: 'Mario Rossi', myController: nominativo,),
              TextForm(titolo: 'Numero di telefono:', hintText: '30040050000', myController: telefono,),
              DateForm(datePickerController: giorno, timePickerController: ora,),
              TextForm(titolo: 'Richieste Speciali(facoltativo):', hintText: 'Es. 1 celicalo', myController: speciali,),

              ElevatedButton(

                child: const Text("Prenota il tavolo"),
                onPressed: (){
                  if (nominativo.value.text != "" && telefono.value.text != "" && giorno.currentDate != null)  {

                    DateTime d = giorno.currentDate;
                    d = d.copyWith(hour: ora.ora, minute: ora.minuti, second: 00);

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