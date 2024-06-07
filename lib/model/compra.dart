import 'package:dart_storage/model/transacao.dart';

class Compra extends Transacao {
  Compra(
      {required super.id,
      required super.preco,
      required super.dataHora,
      required super.produtoId,
      required super.quantidade});
}
