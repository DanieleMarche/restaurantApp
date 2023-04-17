import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/adminLog.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina 2'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/adminLog'),
            icon: const Icon(
              Icons.person, color: Colors.blue))
        ],
        
      ),
      body: Center(
        child: TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              textStyle: TextStyle(color: Colors.black)
              ),
          child: const Text('Torna alla Home')
        ),
      ),
    );
  }
}