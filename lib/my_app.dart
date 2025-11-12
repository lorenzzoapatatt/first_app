import 'package:flutter/material.dart';
import 'package:first_app/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App de Tarefas',
      home: MyHomePage(title: 'Minhas Tarefas', subtitle: 'Lista atual'),
    );
  }
}