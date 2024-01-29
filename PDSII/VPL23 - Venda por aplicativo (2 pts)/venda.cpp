#include "venda.hpp"

#include <iomanip>

Venda::~Venda() {
  // TODO: Implemente este metodo
  /**
   * Aqui voce deve deletar os ponteiros contidos na lista m_pedidos
   */
  while(!m_pedidos.empty()){
    delete m_pedidos.front();
    m_pedidos.pop_front();
  }
  m_pedidos.clear();
}

void Venda::adicionaPedido(Pedido* p) {
  // TODO: Implemente este metodo
  m_pedidos.push_back(p);
}

void Venda::imprimeRelatorio() const {
  // TODO: Implemente este metodo
  /**
   * Aqui voce tem que percorrer a lista de todos os pedidos e imprimir o resumo
   * de cada um. Por ultimo, devera ser exibido o total de venda e a quantidade
   * de pedidos processados.
   */
  int contador = 1;
  float totalVendas = 0.0;
  for(auto const& pedido : m_pedidos){
    std::cout << "Pedido " << contador++ << std::endl;
    std::cout << pedido->resumo() << std::endl;
    totalVendas += pedido->calculaTotal();
  }

  std::cout << "Relatorio de Vendas" << std::endl;
  std::cout << std::fixed;
  std::cout << std::setprecision(2);
  std::cout << "Total de vendas: R$ " << totalVendas << std::endl;
  std::cout << "Total de pedidos: " << contador - 1 << std::endl;

}