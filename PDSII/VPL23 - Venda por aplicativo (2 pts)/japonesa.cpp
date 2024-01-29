#include "japonesa.hpp"

std::string Japonesa::descricao() const {
  // TODO: Implemente este metodo.
  /*
   * Note que aqui voce deve retornar uma descricao detalhada da comida
   * japonesa.
   *
   * Exemplos:
   * 1X Comida japonesa - Combo 1, 4 sushis, 5 temakis e 6 hots.
   * 1X Comida japonesa - Combo 2, 5 sushis, 6 temakis e 8 hots.
   */
  std::string quantidade = std::to_string(m_qtd);
  std::string nSushi = std::to_string(sushis);
  std::string nTemaki = std::to_string(temakis);
  std::string nHot = std::to_string(hots);

  std::string descricao = quantidade + "X Comida japonesa - " + combinado + " , " + nSushi + " sushis, " + nTemaki + " temakis e " + nHot + " hots.";
   
  return descricao;
}

Japonesa::Japonesa(const std::string& combinado,
                   int sushis,
                   int temakis,
                   int hots,
                   int qtd,
                   float valor_unitario) {
  // TODO: Implemente este metodo.
  this->combinado = combinado;
  this->sushis = sushis;
  this->temakis = temakis;
  this->hots = hots;
  this->m_qtd = qtd;
  this->m_valor_unitario = valor_unitario;
}