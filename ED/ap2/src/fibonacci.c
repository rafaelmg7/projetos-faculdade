#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "../include/fibonacci.h"

double calc_seno_fib(double x, int n){
    double sen = 0;
    for(int i = 0; i < n; i++){
        sen += pow(-1, i) * pow(x, 2 * i+1) / tgamma(2*i+2);
    }
    return sen;
}

int fib(int n) {
    calc_seno_fib(45, 1000000);
    if (n < 3) 
        return 1;
    else
        return fib(n-1) + fib(n-2);
}

int fibIter(int n) { 
    int fn1 = 1, fn2 = 1;
    int fn, i;
    if (n < 3) return 1;
    for (i = 3; i <= n; i++) { 
        fn = fn2 + fn1;
        fn2 = fn1;
        fn1 = fn; 
    } 
    return fn; 
}