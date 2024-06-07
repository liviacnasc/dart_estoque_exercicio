// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class Transacao {
  int id;
  int produtoId;
  int quantidade;
  double preco;
  DateTime dataHora;

  Transacao({
    required this.id,
    required this.produtoId,
    required this.quantidade,
    required this.preco,
    required this.dataHora,
  });

  @override
  String toString() {
    return "ID: $id\n Preço: $preco\nData e Hora: ${dataHora.toUtc()}";
  }
}
