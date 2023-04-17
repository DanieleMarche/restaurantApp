import 'package:flutter/material.dart';
import 'package:drop_down_list/drop_down_list.dart';

import 'bottone.dart';

class Riga extends StatelessWidget {
  final String testo1; 
  final String testo2;
  final String direzione1; 
  final String direzione2;
  final IconData icon1;
  final IconData icon2;

  const Riga({super.key, required this.testo1, required this.testo2, required this.direzione1, required this.direzione2, this.icon1 = Icons.circle, this.icon2 = Icons.circle});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          
          Expanded(
            child: Bottone(testo: testo1, direzione: direzione1, icon: icon1)
          ),

          Container(
            margin: const EdgeInsets.all(10),
          ),
          
          Expanded(
            child: Bottone(testo: testo2, direzione: direzione2, icon: icon2)
          )
        ],
      )
    );
  }
}