// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dart_storage/model/produto_inventario.dart';

class Produto {
  int id;
  String titulo;
  double preco;
  ProdutoInventario produtoInventario;

  Produto({
    required this.id,
    required this.titulo,
    required this.preco,
    required this.produtoInventario
  });

  @override
  String toString() {
    int quantidade = produtoInventario.quantidade;
    return "Nome: $titulo \nPreço: $preco, \nQuantidade: $quantidade \n";
  }
}
