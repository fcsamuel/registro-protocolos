import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:registroprotocolos/helper/ProtocoloHelper.dart';
import 'dart:convert';

import 'package:registroprotocolos/models/Protocolo.dart';

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {

  int _irregularidade;
  DateTime _selectedDate = DateTime.now();
  TextEditingController _data = new TextEditingController();
  TextEditingController _cep = new TextEditingController();
  TextEditingController _descricao = new TextEditingController();
  String _resultado, logradouro, complemento, bairro, localidade, uf = "";
  bool _buraco = false, _loteBaldio = false, _sinalizacao = false, _calcada = false, _outros = false;
  var _db = ProtocoloHelper();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2900));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        String dia = _selectedDate.day.toString();
        String mes = _selectedDate.month.toString();
        String ano = _selectedDate.year.toString();
        _data.text = "$dia/$mes/$ano";
      });
  }

  void _abrirConsulta() {
    Navigator.pushNamed(context, "/consulta");
  }

  void _consultarCep() async {
    String url = "https://viacep.com.br/ws/${_cep.text}/json/";
    http.Response response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    logradouro = retorno["logradouro"];
    complemento = retorno["complemento"];
    bairro = retorno["bairro"];
    localidade = retorno["localidade"];
    uf = retorno["uf"];
    setState(() {
      _resultado = "${logradouro}, ${bairro}, ${localidade} - ${uf}";
    });
  }

  _salvar() async {
    String data = "${_data.text} ${TimeOfDay.now().hour.toString()}:${TimeOfDay.now().minute.toString()}";
    String cep = _cep.text;
    String endereco = _resultado;
    String descricao = _descricao.text;
    int buraco = 0;
    int calcada = 0;
    int lotebaldio = 0;
    int sinalizacao = 0;
    int outro = 0;
    if (_buraco) {
      buraco = 1;
    }
    if (_calcada) {
      calcada = 1;
    }
    if (_loteBaldio) {
      lotebaldio = 1;
    }
    if (_sinalizacao) {
      sinalizacao = 1;
    }
    if (_outros) {
      outro = 1;
    }

    Protocolo protocolo = new Protocolo(
        descricao,
        buraco,
        calcada,
        lotebaldio,
        sinalizacao,
        outro,
        data,
        cep,
        endereco);

    int result = await _db.salvarProtocolo(protocolo);
    print("Protocolo Salvo: " + result.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro de Protocolo"),),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CheckboxListTile(
                  title: Text("Buraco"),
                  value: _buraco,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _buraco = value;
                    });
                  }
              ),
              CheckboxListTile(
                  title: Text("Lote baldio"),
                  value: _loteBaldio,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _loteBaldio = value;
                    });
                  }
              ),
              CheckboxListTile(
                  title: Text("Sinalização"),
                  value: _sinalizacao,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _sinalizacao = value;
                    });
                  }
              ),
              CheckboxListTile(
                  title: Text("Calçada"),
                  value: _calcada,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _calcada = value;
                    });
                  }
              ),
              CheckboxListTile(
                  title: Text("Outros"),
                  value: _outros,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _outros = value;
                    });
                  }
              ),
              Row(
                children: <Widget>[
                  Expanded(child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Data"),
                    style: TextStyle(fontSize: 15),
                    maxLength: 200,
                    enabled: false,
                    controller: _data,
                  ),),
                  IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Informe o CEP"
                    ),
                    controller: _cep,
                  ),),
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _consultarCep();
                        FocusScope.of(context).unfocus();
                      }
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  _resultado!=null?_resultado:"",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
                decoration: InputDecoration(labelText: "Descrição"),
                controller: _descricao,
              ),
              Column(
                children: <Widget>[
                  Center(

                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: RaisedButton(
                      color: Colors.purple,
                      padding: EdgeInsets.all(10),
                      child: Text("Salvar", style: TextStyle(fontSize: 15, color: Colors.white),),
                      onPressed: () {
                        _salvar();
                        _abrirConsulta();
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
