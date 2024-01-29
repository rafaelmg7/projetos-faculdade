#include "vetor.h"

#include <cmath>

Vetor::Vetor(int inicio, int fim){
    if(fim >= inicio){
        int size = abs(inicio) + abs(fim) + 1;
        inicio_ = inicio;
        elementos_ = new string[size];
    }else{
        inicio = NULL;
        elementos_ = NULL;
    }
}

void Vetor::atribuir(int i, std::string valor){
    if(i >= inicio_ || i <= ((sizeof(elementos_) / sizeof(std::string)) + inicio_)){
        elementos_[i - inicio_] = valor;
    }
}

string Vetor::valor(int i) const{
    if(i >= inicio_ || i <= ((sizeof(elementos_) / sizeof(std::string)) + inicio_)){
        return elementos_[i - inicio_];
    }
    else return NULL;
}

Vetor::~Vetor(){
    delete [] elementos_;
}