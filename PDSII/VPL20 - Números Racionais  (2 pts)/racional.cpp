#include "racional.h"

#include <cmath>
#include <iostream>

int mdc(int x, int y){
  if(x%y == 0)
        return y;
    else
        return mdc(y, x%y);
}

void Racional::Simplificar() {
    int n = mdc(numerador_, denominador_);
    if(n != 1){
        *this = Racional(numerador_ / n, denominador_ / n);
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
    this->Simplificar();
  }else{
    ExcecaoDivisaoPorZero e;
    throw e;
  }
}

int Racional::numerador() const {
  return numerador_;
}

int Racional::denominador() const {
  return denominador_;
}

Racional Racional::operator-() const {
  return Racional(numerador() * (-1), denominador());
}

Racional Racional::operator+(Racional k) const {
  return Racional(((numerador() * k.denominador()) + (k.numerador() * denominador())), (denominador() * k.denominador()));
}

Racional Racional::operator-(Racional k) const {
  return Racional(((numerador() * k.denominador()) - (k.numerador() * denominador())), (denominador() * k.denominador()));
}

Racional Racional::operator*(Racional k) const {
  // Racional temp = Racional((numerador() * k.numerador()), (denominador() * k.denominador()));
  // temp.Simplificar();
  return Racional((numerador() * k.numerador()), (denominador() * k.denominador()));
}

Racional Racional::operator/(Racional k) const {
    if(k == 0){
        ExcecaoDivisaoPorZero e;
        throw e;
    }
    return Racional((numerador() * k.denominador()), (denominador() * k.numerador()));
}

Racional::operator float() const{
    return (float)numerador_ / (float)denominador_;
}

Racional::operator string() const{
    string texto = std::to_string(numerador_) + "/" + std::to_string(denominador_);
    return texto;
}

ostream& operator<<(ostream& out, Racional r){
    out << (string) r;
    return out;
}

istream& operator>>(istream& in, Racional& r){
    int num, den;
    in >> num >> den;
    r = Racional(num, den);
    return in;
}