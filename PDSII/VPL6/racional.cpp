#include "racional.h"

#include <cmath>
#include <iostream>

int mdc(int x, int y){
  if(x%y == 0)
        return y;
    else
        return mdc(y, x%y);
}

void Racional::Normalizar() {
  int n = mdc(numerador(), denominador());
  if(n > 1){
    *this = Racional(numerador() / n, denominador() / n);
  }
}

Racional::Racional() {
  numerador_ = 0;
  denominador_ = 1;
}

Racional::Racional(int n)  {
  numerador_ = n;
  denominador_ = 1;
}

Racional::Racional(int n, int d) {
  if(d != 0){
    numerador_ = n;
    denominador_ = d;
    this->Normalizar();
  } 
}

int Racional::numerador() const {
  return numerador_;
}

int Racional::denominador() const {
  return denominador_;
}

Racional Racional::simetrico() const {
  return Racional(numerador() * (-1), denominador());
}

Racional Racional::somar(Racional k) const {
  return Racional(((numerador() * k.denominador()) + (k.numerador() * denominador())), (denominador() * k.denominador()));
}

Racional Racional::subtrair(Racional k) const {
  return Racional(((numerador() * k.denominador()) - (k.numerador() * denominador())), (denominador() * k.denominador()));
}

Racional Racional::multiplicar(Racional k) const {
  // Racional temp = Racional((numerador() * k.numerador()), (denominador() * k.denominador()));
  // temp.Normalizar();
  return Racional((numerador() * k.numerador()), (denominador() * k.denominador()));
}

Racional Racional::dividir(Racional k) const {
  return Racional((numerador() * k.denominador()), (denominador() * k.numerador()));
}

