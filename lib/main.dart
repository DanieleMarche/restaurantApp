// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/all.dart';
import 'pages/HomePage/homePage.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const LaMasseriaApp());

} 

class LaMasseriaApp extends StatelessWidget {
  const LaMasseriaApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App con Home e Bottoni',
      
      home: const HomePage(),
      routes: {
        '/scopri': (context) => const ScopriLaMasseria(),
        '/menu': (context) => const Menu(),
        '/adminLog': (context) => const AdminLog(),
        '/prenota': (context) => const Prenota(),
        '/ordina':(context) => const Ordina(),
        '/ev':(context) => const EventiEPromozioni(),
        '/contatti':(context) => const Contatti()
        
      },
    );
  }
}






