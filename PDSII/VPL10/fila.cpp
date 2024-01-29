#include "fila.h"

Fila::Fila(){
    primeiro_ = nullptr;
    ultimo_ = nullptr;
}

string Fila::primeiro(){
    if(primeiro_ != nullptr && ultimo_ != nullptr){
        return primeiro_->chave;
    }else return "";
}

string Fila::ultimo(){
    if(primeiro_ != nullptr && ultimo_ != nullptr){
        return ultimo_->chave;
    }else return "";
}

bool Fila::vazia(){
    if(primeiro_== nullptr && ultimo_ == nullptr) return true;
    else return false;
}

void Fila::Inserir(string k){
    No* novo = new No;
    novo->chave = k;
    novo->proximo = nullptr;
    if(vazia()){
        primeiro_ = novo;
    }else{
        ultimo_->proximo = novo;
    }
    ultimo_ = novo;
}

void Fila::Remover(){
    if(!vazia()){
        No* removido = primeiro_;
        if(primeiro_->proximo == nullptr){
            ultimo_ = nullptr;
        }
        primeiro_ = primeiro_->proximo;

        delete removido;
    }
}

int Fila::tamanho(){
    No* aux = primeiro_;
    int count = 0;
    while(aux != nullptr){
        count++;
        aux = aux->proximo;
    }

    return count;
}

Fila::~Fila(){
    No* aux;
    ultimo_ = nullptr;
    while(primeiro_ != nullptr){
        aux = primeiro_;
        primeiro_ = primeiro_->proximo;
        delete aux;
    }
}