import 'package:flutter/material.dart';

class Ordina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ordina'),
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