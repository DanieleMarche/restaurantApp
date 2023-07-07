// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/pages/PrenotaPage/textForm.dart';

class Prenota extends StatefulWidget {
  const Prenota({super.key});

  @override
  State<Prenota> createState() => _PrenotaState();

}

class _PrenotaState extends State<Prenota>{

  String _testo = "null"; 
  bool _textVisibility = false;

  Map<String, String> _prenotazione = {};

  String _result = "";

  Future<String> nuovaPrenotazione(var prenotazione) async {
    String testo = "";
    var db = FirebaseFirestore.instance;
    await db.collection("prova").doc().set(prenotazione)
    .then((value) => setState(() {testo = "success";}))
    .catchError((error) => setState(() {_testo = "problem has occurred";}));
    return testo;
  }

    Widget databaseReturn () {
    if (_prenotazione.isEmpty) {
      return const Text("");
    } else {
      return FutureBuilder<String>(
        future: nuovaPrenotazione(_prenotazione),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          _prenotazione = {};
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


  TextEditingController nominativo = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController speciali = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prenota un tavolo'),
      ),
      body: Center(
        child: Column(
          children: [

            TextForm(titolo: 'Nominativo', hintText: 'Mario Rossi', myController: nominativo,),
            TextForm(titolo: 'Numero', hintText: '30040050000', myController: speciali,),
            TextForm(titolo: 'Richieste Speciali', hintText: 'Es. 1 celicalo', myController: telefono,),
            ElevatedButton(

                child: const Text("Register"),
                onPressed: (){

                  setState(() {
                    _prenotazione = {
                    "nominativo" : nominativo.value.text,
                    "telefono" : telefono.value.text,
                    "richieste_speciali" : speciali.value.text
                    };

                  });

                  nominativo.clear();
                  telefono.clear();
                  speciali.clear();


                }
                
              ),

              DefaultTextStyle(
                style: Theme.of(context).textTheme.displayMedium!,
                textAlign: TextAlign.center,
                child: databaseReturn()
              )
          ],
        ),
      )
    );
  }
}