// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProdutoInventario {
  int produtoId;
  int quantidade;

  ProdutoInventario({
    required this.produtoId,
    required this.quantidade,
  });

  int getProdutoId() {
    return produtoId;
  }

  int? getQuantityById(int id) {
    if(id == produtoId){
      return quantidade;
    }
    return null;
  }
}
