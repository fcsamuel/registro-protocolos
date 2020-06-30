import 'package:flutter/material.dart';
import 'package:registroprotocolos/helper/ProtocoloHelper.dart';
import 'package:registroprotocolos/models/Protocolo.dart';

class Consulta extends StatefulWidget {
  @override
  _ConsultaState createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  List _itens = [];
  var _db = ProtocoloHelper();
  List<Protocolo> _protocolos = List<Protocolo>();

  void _carregarItens() {
    _itens = [];
    for(int i=0; i<=10; i++) {
      Map<String, dynamic> item = Map();
      item["id"] = "${_protocolos[i].id}";
      item["caso"] = "${_getCaso(_protocolos[i])}";
      item["endereco"] = "${_protocolos[i].endereco}";
      item["descricao"] = "${_protocolos[i].descricao}";
      item["data"] = "${_protocolos[i].data}";
      _itens.add(item);
    }
  }

  String _getCaso(Protocolo protocolo) {
    String ret = "";
    if(protocolo.buraco == 1) {
      ret += "Buraco. ";
    }
    if(protocolo.calcada == 1) {
      ret += "Calçada. ";
    }
    if(protocolo.lotebaldio == 1) {
      ret += "Lote Baldio. ";
    }
    if(protocolo.sinalizacao == 1) {
      ret += "Sinalização. ";
    }
    if(protocolo.outro == 1) {
      ret += "Outros. ";
    }
    return ret;
  }

  _recuperarProtocolos() async {
    List protocolosRecuperados = await _db.recuperarProtocolos();
    List<Protocolo> listaTemporaria = List<Protocolo>();
    for (var item in protocolosRecuperados) {
      Protocolo protocolo = Protocolo.fromMap(item);
      listaTemporaria.add(protocolo);
    }

    setState(() {
      _protocolos = listaTemporaria;
    });
    listaTemporaria = null;
    _carregarItens();
  }

  @override
  void initState() {
    super.initState();
    _recuperarProtocolos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cadastro de Protocolos"),
        backgroundColor: Colors.black,
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: _protocolos.length,
            itemBuilder: (context, indice) {
              return Card (
                child: ListTile(
                  title: Text(_itens[indice]["id"]),
                  subtitle: Text(
                      _itens[indice]["caso"] + _itens[indice]["endereco"]
                          +"\n"+ _itens[indice]["descricao"]
                          +"\n"+ _itens[indice]["data"]
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
