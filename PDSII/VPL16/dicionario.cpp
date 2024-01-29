#include "dicionario.h"

Dicionario::Dicionario(){
    list<Elemento> novo = {};
    elementos_ = novo;
}

int Dicionario::tamanho(){
    return elementos_.size();
}

bool Dicionario::pertence(string chave){
    list<Elemento>::iterator it;
    for (it = elementos_.begin(); it != elementos_.end(); ++it){
        if(it->chave == chave){
            return true;
        }
    }
    return false;
}

string Dicionario::menor(){
    list<Elemento>::iterator it;
    string menor = elementos_.front().chave;
    for (it = elementos_.begin(); it != elementos_.end(); ++it){
        if(it->chave < menor){
            menor = it->chave;
        }
    }
    return menor;
}

string Dicionario::valor(string chave){
    list<Elemento>::iterator it;
    for (it = elementos_.begin(); it != elementos_.end(); ++it){
        if(it->chave == chave){
            return it->valor;
        }
    }
}

void Dicionario::Inserir(string chave, string valor){
    Elemento novo = {chave, valor};
    elementos_.push_back(novo);
}

void Dicionario::Remover(string chave){
    list<Elemento>::iterator it;
    for (it = elementos_.begin(); it != elementos_.end(); ++it){
        if(it->chave == chave){
            elementos_.erase(it);
            break;
        }
    }
}

void Dicionario::Alterar(string chave, string valor){
    list<Elemento>::iterator it;
    for (it = elementos_.begin(); it != elementos_.end(); ++it){
        if(it->chave == chave){
            it->valor = valor;
            break;
        }
    }
}

Dicionario::~Dicionario(){
    elementos_.clear();
    elementos_.~list();
}