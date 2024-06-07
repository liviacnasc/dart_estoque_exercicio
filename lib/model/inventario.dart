import 'package:dart_storage/model/compra.dart';
import 'package:dart_storage/model/produto.dart';
import 'package:dart_storage/model/produto_inventario.dart';
import 'package:dart_storage/model/transacao.dart';
import 'package:dart_storage/model/venda.dart';

class Inventario {
  // productId e product
  Map<int, Produto> storage = {};
  Map<int, Transacao> extrato = {};

  void listarProdutosEInventario() {
    storage.forEach((key, value) => print("id: $key\n${value.toString()}\n"));
  }

  bool verificarSeExiste(int produtoId) {
    return storage.containsKey(produtoId);
  }

  Produto? pegarProdutoPeloId(int? id) {
    return storage[id];
  }

  Produto cadastrarProduto({required String titulo, required double preco, required int quantidade}){
    int id = storage.length + 1;
    ProdutoInventario produtoInventario = ProdutoInventario(produtoId: id, quantidade: quantidade);
    Produto produto = Produto(id: id, titulo: titulo, produtoInventario: produtoInventario, preco: preco);
    storage.addAll({id: produto});
    return Produto(id: id, titulo: titulo, preco: preco, produtoInventario: produtoInventario);
  }

  void cadastrarCompra(Map<int, int> produtoIdQuantidade) {
    
    produtoIdQuantidade.forEach((key, value) {
      int id = extrato.length + 1;
      if(verificarSeExiste(key)){
        Produto produto = storage[key]!;
        double preco = produto.preco * value;

        produto.produtoInventario.quantidade += value;

        storage.update(key, (value) => produto);

        extrato.addAll({id: Compra(id: id, produtoId: produto.id, preco: preco, dataHora: DateTime.now(),quantidade: value,)});

      } else {
        print("O produto [$key] não foi encontrado e a compra do item especificado não foi processada.");
      }
    });

  }

  void cadastrarVenda(Map<int, int> produtoIdQuantidade) {
    produtoIdQuantidade.forEach((key, value) {
      int id = extrato.length + 1;
      if(verificarSeExiste(key)){
        Produto produto = storage[key]!;
        double preco = produto.preco * value;
        
        produto.produtoInventario.quantidade -= value;

        storage.update(key, (value) => produto);

        extrato.addAll({id: Venda(id: id, produtoId: produto.id, preco: preco, dataHora: DateTime.now(),quantidade: value,)});

      } else {
        print("O produto [$key] não foi encontrado e a compra do item especificado não foi processada.");
      }
    });
  }
}