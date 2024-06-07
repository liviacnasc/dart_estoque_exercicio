import 'dart:io';

import 'package:dart_storage/model/inventario.dart';
import 'package:dart_storage/model/produto.dart';

class Estoque {
  bool programaTerminado = false;
  Inventario inventario = Inventario();

  void iniciarPrograma() {
    while(!programaTerminado){
      print("1. Listar produtos");
      print("2. Cadastrar produtos");
      print("3. Registrar compra");
      print("4. Registrar venda");
      int opcoes = int.tryParse(stdin.readLineSync()!) ?? 0;
      
      switch(opcoes) {
        case 1:
          _listarProdutos();
        break;
        case 2:
          _cadastrarProduto();
        break;
        case 3:
          _cadastrarCompra();
          break;
        case 4:
          _cadastrarVenda();
        default:
          print("Opção inválida.");
      }
    }
  }

  void _listarProdutos() {
    inventario.listarProdutosEInventario();
  }

  void _cadastrarProduto(){

    // recebendo e validando o título
    print("Insira o titulo do produto: ");

    String titulo = stdin.readLineSync() ?? "";

    while(titulo == ""){
      print("O titulo não pode ser vazio. Insira o título do produto: ");
      titulo = stdin.readLineSync() ?? "";
    }
    // -----------------------
    // recebendo e validando o preço
    print("Insira o preço do produto: ");
    double preco = double.tryParse(stdin.readLineSync()!) ?? 0.0;

    while(preco == 0.0){
      print("Preço invalido. Insira o preço do produto: ");
      preco = double.tryParse(stdin.readLineSync()!) ?? 0.0;
    }
    // -----------------------
    // recebendo e validando a quantidade
    print("Insira a quantidade do produto: ");
    int quantidade = int.tryParse(stdin.readLineSync()!) ?? 0;

    while(quantidade == 0){
      print("Preço invalido. Insira o preço do produto: ");
      quantidade = int.tryParse(stdin.readLineSync()!) ?? 0;
    }

    Produto produto = inventario.cadastrarProduto(titulo: titulo, preco: preco, quantidade: quantidade);

    print("${produto.toString()} foi cadastrado.");
  }

  void _cadastrarCompra() {
    bool acaoTerminada = false;
    Map<int, int> produtos = {};
    while(!acaoTerminada) {
      print("Carrinho: \n");
      for (var element in produtos.entries) {
        print("Produto: ${inventario.pegarProdutoPeloId(element.key)?.titulo}\nQuantidade: ${element.value}");
      }
      print("1. Adicionar produto ao carrinho");
      print("2. Encerrar compra");
      int? opcoes = int.tryParse(stdin.readLineSync()!);
      switch(opcoes) {
        case 1:
          produtos.addAll(_adicionarProdutoAoCarrinho(0));
        case 2:
          _encerrarCompra(produtos);
          acaoTerminada = true;
          break;
      }
    }
  }

  Map<int, int> _adicionarProdutoAoCarrinho(int tipo){
    _listarProdutos();
    print("Insira o ID do produto: ");
    //recebendo ID
    int id = int.tryParse(stdin.readLineSync()!) ?? 0;
    // verificando se é nulo
    while(id == 0){
      print("ID inválido. Insira um ID válido.");
      id = int.tryParse(stdin.readLineSync()!) ?? 0;
    }
    // verificando se o produto existe
    Produto? produto = inventario.pegarProdutoPeloId(id);

    while(produto == null){
      print("Produto não encontrado. Insira um ID válido.");
      id = int.tryParse(stdin.readLineSync()!) ?? 0;
      produto = inventario.pegarProdutoPeloId(id);
    }

    print("${produto.titulo} selecionado. Insira a quantidade: ");
    //recebendo ID
    int quantidade = int.tryParse(stdin.readLineSync()!) ?? 0;

    while(quantidade <= 0 || (tipo == 1 && quantidade > produto.produtoInventario.quantidade)) {
      print("Valor invalido. Insira a quantidade: ");
      quantidade = int.tryParse(stdin.readLineSync()!) ?? 0;
    }

    return {id: quantidade};
  }

  void _encerrarCompra(Map<int, int> produtos) {
    if(produtos.isEmpty){
      print("Nenhum produto encontrado no carrinho. Compra encerrada.");
    } else {
      inventario.cadastrarCompra(produtos);
      for (var element in produtos.entries) {
        print("Produto: ${inventario.pegarProdutoPeloId(element.key)?.titulo}\nQuantidade: ${element.value}");
      }
      print("${inventario.extrato.entries.last.toString()} foi adicionado com sucesso.");
    }
  }

  void _encerrarVenda(Map<int, int> produtos) {
    if(produtos.isEmpty){
      print("Nenhum produto encontrado no carrinho. Venda encerrada.");
    } else {
      inventario.cadastrarVenda(produtos);
      for (var element in produtos.entries) {
        print("Produto: ${inventario.pegarProdutoPeloId(element.key)?.titulo}\nQuantidade: ${element.value}");
      }
      print("${inventario.extrato.entries.last.toString()} foi adicionado com sucesso.");
    }
  }

  void _cadastrarVenda() {
    bool acaoTerminada = false;
    Map<int, int> produtos = {};
    while(!acaoTerminada) {
      print("Carrinho: \n");
      for (var element in produtos.entries) {
        print("Produto: ${inventario.pegarProdutoPeloId(element.key)?.titulo}\nQuantidade: ${element.value}");
      }
      print("1. Adicionar produto ao carrinho");
      print("2. Encerrar venda");
      int? opcoes = int.tryParse(stdin.readLineSync()!);
      switch(opcoes) {
        case 1:
          produtos.addAll(_adicionarProdutoAoCarrinho(1));
        case 2:
          _encerrarVenda(produtos);
          acaoTerminada = true;
          break;
      }
    }
  }
}