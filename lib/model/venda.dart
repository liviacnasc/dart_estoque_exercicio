import 'package:dart_storage/model/transacao.dart';

class Venda extends Transacao {
  Venda(
      {required super.id,
      required super.produtoId,
      required super.quantidade,
      required super.preco,
      required super.dataHora});
}
