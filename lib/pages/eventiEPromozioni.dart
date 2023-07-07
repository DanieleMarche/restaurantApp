import 'package:flutter/material.dart';

class EventiEPromozioni extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventi e Promozioni'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          child: Text('Torna alla Home'),
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              textStyle: TextStyle(color: Colors.black)
              )
        ),
      ),
    );
  }
}