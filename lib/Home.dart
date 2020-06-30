import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void _abrirRegistro() {
    Navigator.pushNamed(context, "/registro");
  }

  void _abrirConsulta() {
    Navigator.pushNamed(context, "/consulta");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Protocolos")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: _abrirRegistro,
                  child: Image.asset(
                    "images/add.png",
                    height: 80,
                    width: 80,
                  ),
                ),
                GestureDetector(
                  onTap: _abrirConsulta,
                  child: Image.asset(
                    "images/search.png",
                    height: 80,
                    width: 80,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Cadastro", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Consulta", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
