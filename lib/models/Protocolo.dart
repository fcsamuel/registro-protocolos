class Protocolo {
  int id;
  String descricao;
  int buraco;
  int calcada;
  int lotebaldio;
  int sinalizacao;
  int outro;
  String data;
  String cep;
  String endereco;


  Protocolo(this.descricao, this.buraco, this.calcada, this.lotebaldio,
      this.sinalizacao, this.outro, this.data, this.cep, this.endereco);

  Map toMap() {
    Map<String, dynamic> map = {
      "descricao": this.descricao,
      "buraco": this.buraco,
      "calcada": this.calcada,
      "lotebaldio": this.lotebaldio,
      "sinalizacao": this.sinalizacao,
      "outro": this.outro,
      "data": this.data,
      "cep": this.cep,
      "endereco": this.endereco
    };

    if (this.id != null) {
      map["id"] = this.id;
    }

    return map;
  }

  Protocolo.fromMap(Map map) {
    this.id = map["id"];
    this.descricao = map["descricao"];
    this.buraco = map["buraco"];
    this.calcada = map["calcada"];
    this.lotebaldio = map["lotebaldio"];
    this.sinalizacao = map["sinalizacao"];
    this.outro = map["outro"];
    this.data = map["data"];
    this.cep = map["cep"];
    this.endereco = map["endereco"];
  }
}