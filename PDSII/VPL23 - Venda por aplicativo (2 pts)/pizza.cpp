#include "pizza.hpp"

std::string Pizza::descricao() const {
  // TODO: Implemente este metodo.
  /*
   * Note que aqui voce deve retornar uma descricao detalhada da pizza.
   *
   * Exemplos:
   * 2X Pizza Calabresa, 4 pedacos e borda recheada.
   * 2X Pizza Calabresa, 4 pedacos sem borda recheada.
   */
  std::string quantidade = std::to_string(m_qtd);
  std::string nPedacos = std::to_string(pedacos);
  
  std::string borda;
  if(borda_recheada){
    borda = "borda recheada.";
  }else{
    borda = "sem borda recheada.";
  }

  std::string descricao = quantidade + "X Pizza " + sabor + ", " + nPedacos + " pedacos e " + borda;

  return descricao;
}

Pizza::Pizza(const std::string& sabor,
             int pedacos,
             bool borda_recheada,
             int qtd,
             float valor_unitario) {
  // TODO: Implemente este metodo.
  this->sabor = sabor;
  this->pedacos = pedacos;
  this->borda_recheada = borda_recheada;
  this->m_qtd = qtd;
  this->m_valor_unitario = valor_unitario;
}