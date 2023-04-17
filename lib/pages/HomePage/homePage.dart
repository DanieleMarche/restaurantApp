import 'package:flutter/material.dart';

import 'CustomWidgets/riga.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.white,
        title: const Text(
          'Ristorante',
           style: TextStyle(
            color: Colors.black,
           ),
          ),
        centerTitle: true,
        
      ),
      body: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 25.0, bottom: 20.0),
              child: const Text(
              "Benvenuto nell'app ufficiale de La Masseria:",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.left,),
            ),
            
            
            const Riga(
              testo1: 'Scopri il ristorante', 
              testo2: 'Menu', 
              direzione1: '/scopri', 
              direzione2: '/menu',
              icon2: Icons.qr_code_2,
            ),
            
            const Riga(
              testo1: 'Prenota',
              testo2: 'Ordina',
              direzione1: '/prenota', 
              direzione2: '/ordina',
              icon1: Icons.table_restaurant_sharp,
              icon2: Icons.menu_book_rounded,),

            const Riga(
              testo1: 'Eventi e Promozioni',
               testo2: 'Contatti', 
               direzione1: '/ev', 
               direzione2: '/contatti'),
            
            Container(
              margin: const EdgeInsets.all(40),
            )
        
          ]
        )
    );     
  }
}