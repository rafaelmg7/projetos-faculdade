#include "pedido.hpp"


Pedido::~Pedido() {
  // TODO: Implemente este metodo.
  /**
   * Aqui voce deve deletar os ponteiros contidos na lista m_produtos
   */
  while(!m_produtos.empty()){
    delete m_produtos.front();
    m_produtos.pop_front();
  }
  m_produtos.clear();
}

void Pedido::setEndereco(const std::string& endereco) {
  // TODO: Implemente este metodo.
  m_endereco = endereco;
}

float Pedido::calculaTotal() const {
  // TODO: Implemente este metodo.
  float total = 0;
  
  for(auto const& produto : m_produtos){
    total += (produto->getQtd() * produto->getValor());
  }

  return total;
}

void Pedido::adicionaProduto(Produto* p) {
  // TODO: Implemente este metodo.
  m_produtos.push_back(p);
}

std::string Pedido::resumo() const {
  // TODO: Implemente este metodo.
  /**
   * Aqui voce deve percorrer a lista de produtos para criar um resumo completo
   * do pedido. A cada iteracao, utilize o metodo descricao de cada produto para
   * montar o resumo do pedido. Por fim, adicione o endereco de entrega.
   *
   */
  std::string resumo;
  for(auto const& produto : m_produtos){
    resumo.append(produto->descricao());
    resumo.append("\n");
  }
  
  resumo.append("Endereco: ");
  resumo.append(m_endereco);

  return resumo;
}