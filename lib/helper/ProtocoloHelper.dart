import 'package:registroprotocolos/models/Protocolo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProtocoloHelper {

  static final ProtocoloHelper _protocoloHelper = ProtocoloHelper._internal();
  static final String nomeTabela = "protocolo";
  Database _db;

  factory ProtocoloHelper() {
    return _protocoloHelper;
  }

  ProtocoloHelper._internal() {

  }

  get db async{
    if (_db != null) {
      return _db;
    }
    _db = await inicializarDB();
    return _db;
  }

  _onCreate(Database db, int version) async {
    String sql = "CREATE TABLE $nomeTabela(id INTEGER PRIMARY KEY AUTOINCREMENT, descricao VARCHAR, "
        "buraco INTEGER, calcada INTEGER, lotebaldio INTEGER, sinalizacao INTEGER, outro INTEGER, "
        "data VARCHAR, cep VARCHAR, endereco VARCHAR)";
    await db.execute(sql);
  }

  inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "protocolo.db");
    var db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> salvarProtocolo(Protocolo protocolo) async {
    var bancoDados = await db;
    int resultado = await bancoDados.insert(nomeTabela, protocolo.toMap());
    return resultado;
  }

  /*Future<List<Protocolo>> listProtocolos() async {

    var bancoDados = await db;

    final List<Map<String, dynamic>> maps = await db.query('protocolo');
    return List.generate(maps.length, (i) {
      return Protocolo(
        maps[i]['descricao'],
        maps[i]['buraco'],
        maps[i]['calcada'],
        maps[i]['lotebaldio'],
        maps[i]['sinalizacao'],
        maps[i]['outro'],
        maps[i]['data'],
        maps[i]['cep'],
        maps[i]['endereco'],
      );
    });
  }*/

  recuperarProtocolos() async {
    var bandoDados = await db;
    List protocolos = await bandoDados.rawQuery("SELECT * FROM $nomeTabela ORDER BY id ASC");
    return protocolos;
  }

}