#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/resource.h>
#include "../include/fatorial.h"

double calc_seno_fat(double x, int n){
    double sen = 0;
    for(int i = 0; i < n; i++){
        sen += pow(-1, i) * pow(x, 2 * i+1) / tgamma(2*i+2);
    }
    return sen;
}

int fatRec (int n) {
    calc_seno_fat(45, 1000000);
    if (n<=0) 
        return 1;
    else
        return n * fatRec(n-1);
}

int fatIter (int n) {
    int f;
    f = 1;
    while(n > 0){
        f = f * n;
        n = n - 1;
    }
    return f;
}