#include <string>

#include "Estoque.hpp"

void Estoque::add_mercadoria(const std::string& mercadoria, unsigned int qtd) {
  // TODO
  mercadorias_[mercadoria] += qtd;
}

void Estoque::sub_mercadoria(const std::string& mercadoria, unsigned int qtd) {
  // TODO
  if(mercadorias_.find(mercadoria) == mercadorias_.end()){
    std::cout << mercadoria << " inexistente" << std::endl;
    return;
  }

  if(mercadorias_[mercadoria] < qtd){
    std::cout << mercadoria << " insuficiente" << std::endl;
    return;
  }
  // Se chegou até aqui, é possível remover quantidades da mercadoria
  else{
    mercadorias_[mercadoria] -= qtd;
  }

}

unsigned int Estoque::get_qtd(const std::string& mercadoria) const {
  // TODO
  // std::map<std::string, unsigned int>::iterator it_qtd = mercadorias_.find(mercadoria);
  if(mercadorias_.find(mercadoria) != mercadorias_.end()){
    return mercadorias_.find(mercadoria)->second;
  }
  return 0;
}

void Estoque::imprime_estoque() const {
  // TODO
  std::set<std::string> ordered_keys;

  // Insere os nomes das mercadorias num set que, por padrão, é ordenado
  for(auto const& key : mercadorias_){
    ordered_keys.insert(key.first);
  }

  for(auto const& mercadoria : ordered_keys){
    std::cout << mercadoria << ", " << mercadorias_.find(mercadoria)->second << std::endl;
  }
}

Estoque& Estoque::operator += (const Estoque& rhs) {
  // TODO
  for(auto const& mercadoria : rhs.mercadorias_){
    add_mercadoria(mercadoria.first, mercadoria.second);
  }
  return *this;
}

Estoque& Estoque::operator -= (const Estoque& rhs) {
  // TODO
  for(auto const& mercadoria : rhs.mercadorias_){
    sub_mercadoria(mercadoria.first, mercadoria.second);
  }
  return *this;
}

bool operator < (Estoque& lhs, Estoque& rhs) {
  // TODO
  std::map<std::string, unsigned int>::iterator it;

  for(auto const& mercadoria : lhs.mercadorias_){
    it = rhs.mercadorias_.find(mercadoria.first);

    if(it == rhs.mercadorias_.end()){
      return false;
    }

    if(it->second <= lhs.get_qtd(mercadoria.first)){
      return false;
    }
  }

  // Se chegou até aqui, as condições são satisfeitas para todos os elementos
  return true;
}

bool operator > (Estoque& lhs, Estoque& rhs) {
  // TODO
  std::map<std::string, unsigned int>::iterator it;

  for(auto const& mercadoria : rhs.mercadorias_){
    it = lhs.mercadorias_.find(mercadoria.first);

    if(it == lhs.mercadorias_.end()){
      return false;
    }

    if(it->second <= rhs.get_qtd(mercadoria.first)){
      return false;
    }
  }

  // Se chegou até aqui, as condições são satisfeitas para todos os elementos
  return true;
}