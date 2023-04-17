import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/PrenotaPage/textForm.dart';

class Prenota extends StatefulWidget {
  Prenota({super.key});

  String testo = "ciao"; 
    
  @override
  State<Prenota> createState() => _PrenotaState();

}

class _PrenotaState extends State<Prenota>{

  TextEditingController nominativo = new TextEditingController();
  TextEditingController telefono = new TextEditingController();
  TextEditingController speciali = new TextEditingController();


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
                child: Text("Register"),
                onPressed: (){

                  final prenotazione = {
                    "nominativo" : nominativo.value.text,
                    "telefono" : telefono.value.text,
                    "richieste_speciali" : speciali.value.text
                  };

                  var db = FirebaseFirestore.instance;
                  db.collection("prova").doc().set(prenotazione);
                  
                },
              ),

              Text(widget.testo)
              

              
            
            
          ],
        ),
      )
    );
  }

}
