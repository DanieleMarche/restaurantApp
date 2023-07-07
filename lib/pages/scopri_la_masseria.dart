
import 'package:flutter/material.dart';

class ScopriLaMasseria extends StatelessWidget {
  
  const ScopriLaMasseria({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scopri La masseria'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              textStyle: const TextStyle(color: Colors.black)
              ),
          child: const Text('Torna alla Home')
        ),
      ),
    );
  }
}