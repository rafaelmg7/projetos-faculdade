#include "fila_de_prioridade.h"

#include <list>
#include <string>
#include <vector>

using std::string;
using std::vector;

void FilaDePrioridade::Adicionar(Pessoa p) {
  if(lista_.empty()){
    lista_.push_back(p);
  }else{
    list<Pessoa>::iterator it;
    for (it = lista_.begin(); it != lista_.end(); ++it){
      if(p.prioridade > it->prioridade){
        // it++;
        lista_.insert(it, p);
      }else if(p.prioridade <= it->prioridade){
        continue;
      }
      break;
    }
    if(it == lista_.end()) lista_.push_back(p);
  }
}

string FilaDePrioridade::RemoverMaiorPrioridade() {
  if(lista_.empty()) return NULL;

  string nome = lista_.front().nome;
  lista_.pop_front();
  return nome;
}

void FilaDePrioridade::Remover(string nome) {
  list<Pessoa>::iterator it;
  for (it = lista_.begin(); it != lista_.end(); ++it){
    if(it->nome.compare(nome) == 0){
      lista_.erase(it);
      break;
    }
  }
}

int FilaDePrioridade::tamanho() {
  return lista_.size();
}

vector<string> FilaDePrioridade::listar() {
  vector<string> v;
  
  for(auto pessoa : lista_){
    v.push_back(pessoa.nome);
  }

  return v; 
}