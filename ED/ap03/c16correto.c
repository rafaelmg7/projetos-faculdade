#include <stdio.h>
#include <stdlib.h>

int actual_calc(int a, int b){
  int c;
  c=a/b;
  return c;
}

int calc(){
  int a;
  int b;
  a=13;
  b=1;
  return actual_calc(a, b);
}

int main(){
  int res = calc();
  return 0;
}
