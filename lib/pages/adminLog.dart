import 'package:flutter/material.dart';

class AdminLog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagina dell'admin"),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              textStyle: TextStyle(
                color: Colors.black)
              ),
          child: const Text('Torna alla Home')
        ),
      ),
    );
  }
}