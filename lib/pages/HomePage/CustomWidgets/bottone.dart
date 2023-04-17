import 'package:flutter/material.dart';

class Bottone extends StatelessWidget {
  final String testo;
  final String direzione;
  final IconData? icon;
  
  const Bottone({super.key, required this.testo, required this.direzione, this.icon = Icons.circle});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(20.0)
          ),
          backgroundColor: MaterialStateProperty.all(
            Colors.white
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0)
            )
          )
        ),
        onPressed: () => Navigator.pushNamed(context, direzione),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
              
              child: Icon(
                icon, 
                color: Colors.black,
                size: 50.0 
                )
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                testo,
                style: const TextStyle(
                  color: Colors.black
                ),
            ),
            )
            
          ],
        )
      )
    );
  }
}