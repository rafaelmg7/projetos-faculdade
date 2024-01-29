// Copyright 2022 Universidade Federal de Minas Gerais (UFMG)

#include "complexo.h"

#include <cmath>

// #define I sqrt(-1);

double realPolar(double a, double b){
  return sqrt((pow(a, 2) + pow(b, 2)));
}

double imagPolar(double a, double b){
  return abs(atan(b/a));
}

Complexo::Complexo() {
  real_ = 0.00;
  imag_ = 0.00;
}

Complexo::Complexo(double a, double b) {
  real_ = a;
  imag_ = b;
}

double Complexo::real() {
  return real_;
}

double Complexo::imag() {
  return imag_;
}

bool Complexo::igual(Complexo x) {
  return (real() == x.real() && imag() == x.imag());
}

void Complexo::Atribuir(Complexo x) {
  *this = x;
}

// Aqui, multiplicamos o quadrado da parte imaginária por -1 devido ao quadrado de sqrt(-1)
double Complexo::modulo() {
  Complexo temp(realPolar(real(), imag()), imagPolar(real(), imag()));
  return sqrt(pow(temp.real(), 2) + (pow(temp.imag(), 2)));
}

Complexo Complexo::conjugado() {
  // Complexo c(realPolar(real(), imag()), -1 * imagPolar(real(), imag()));
  Complexo c(real(), -1 * imag());
  return c;
}

Complexo Complexo::simetrico() {
  Complexo c(realPolar(real() * -1, imag() * -1), imagPolar(real() * -1, imag() * -1));
  // Complexo c((real() * -1), (imag() * -1));
  return c;
}

Complexo Complexo::inverso() {
  // double temp = multiplicar(conjugado()).real();
  Complexo i((1 / realPolar(real(), imag())), imagPolar(real(), imag()));
  // Complexo i(1 / real(), imag());
  return i;
}

Complexo Complexo::somar(Complexo y) {
  Complexo s(realPolar(real(), imag()), imagPolar(real(), imag()));
  s.real_ += y.real();
  s.imag_ += y.imag();
  // Complexo s (real() + y.real(), imag() + y.imag());
  return s;
}

Complexo Complexo::subtrair(Complexo y) {
  Complexo s(realPolar(real(), imag()), imagPolar(real(), imag()));
  s.real_ -= y.real();
  s.imag_ -= y.imag();
  // Complexo s (real() - y.real(), imag() - y.imag());
  return s;
}

Complexo Complexo::multiplicar(Complexo y) {
  Complexo p(realPolar(real(), imag()), imagPolar(real(), imag()));
  p.real_ *= y.real();
  p.imag_ += y.imag();
  // Complexo p((real() * y.real()), (imag() + y.imag()));
  return p;
}

Complexo Complexo::dividir(Complexo y) {
  Complexo d(realPolar(real(), imag()), imagPolar(real(), imag()));
  d.real_ /= y.real();
  d.imag_ -= y.imag();
  // Complexo d((real() / y.real()), (imag() - y.imag()));
  return d;
}
