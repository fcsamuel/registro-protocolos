import 'package:flutter/material.dart';
import 'package:registroprotocolos/Consulta.dart';
import 'package:registroprotocolos/Home.dart';
import 'package:registroprotocolos/Registro.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        "/home": (context) => Home(),
        "/registro": (context) => Registro(),
        "/consulta": (context) => Consulta(),
      },
      home: Home(),
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
    )
  );
}