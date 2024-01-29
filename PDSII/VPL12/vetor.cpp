#include "vetor.h"

#include <cmath>

Vetor::Vetor(int inicio, int fim) : inicio_(inicio), fim_(fim) {
    if (fim < inicio){
        IntervaloVazio e{inicio, fim};
        throw e;
    }

    int size = abs(inicio) + abs(fim) + 1;
    inicio_ = inicio;
    elementos_ = new string[size];
}

void Vetor::atribuir(int i, std::string valor){
    if (i < inicio_ || i > fim_){
        IndiceInvalido e{inicio_, fim_, i};
        throw e;
    }
    elementos_[i - inicio_] = valor;
}

string Vetor::valor(int i) const{
    if(i < inicio_ || i > fim_){
        IndiceInvalido e {inicio_, fim_, i};
        throw e;
    }else if(elementos_[i - inicio_] == string()){
        IndiceNaoInicializado e {i};
        throw e;
    }
    return elementos_[i - inicio_];
}

Vetor::~Vetor(){
    delete [] elementos_;
}