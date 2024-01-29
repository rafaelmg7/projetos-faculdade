#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <string.h>

#include "../include/fatorial.h"
#include "../include/fibonacci.h"

void calculateDelta(struct timespec start, struct timespec finish, struct timespec *delta, struct rusage start_user, struct rusage end_user, struct rusage *delta_user){
    if (finish.tv_nsec < start.tv_nsec){
        // ajuste necessario, utilizando um segundo de tv_sec
        delta->tv_nsec = 1000000000+finish.tv_nsec-start.tv_nsec;
        delta->tv_sec = finish.tv_sec-start.tv_sec-1;
    } else {
        // nao e necessario ajuste
        delta->tv_nsec = finish.tv_nsec-start.tv_nsec;
        delta->tv_sec = finish.tv_sec-start.tv_sec;
    }

    if (end_user.ru_utime.tv_usec < start_user.ru_utime.tv_usec){
        // ajuste necessario, utilizando um segundo de tv_sec
        delta_user->ru_utime.tv_usec = 1000000+end_user.ru_utime.tv_usec-start_user.ru_utime.tv_usec;
        delta_user->ru_utime.tv_sec = end_user.ru_utime.tv_sec-start_user.ru_utime.tv_sec-1;
    } else {
        // nao e necessario ajuste
        delta_user->ru_utime.tv_usec = end_user.ru_utime.tv_usec-start_user.ru_utime.tv_usec;
        delta_user->ru_utime.tv_sec = end_user.ru_utime.tv_sec-start_user.ru_utime.tv_sec;
    }

    if (end_user.ru_stime.tv_usec < start_user.ru_stime.tv_usec){
        // ajuste necessario, utilizando um segundo de tv_sec
        delta_user->ru_stime.tv_usec = 1000000+end_user.ru_stime.tv_usec-start_user.ru_stime.tv_usec;
        delta_user->ru_stime.tv_sec = end_user.ru_stime.tv_sec-start_user.ru_stime.tv_sec-1;
    } else {
        // nao e necessario ajuste
        delta_user->ru_stime.tv_usec = end_user.ru_stime.tv_usec-start_user.ru_stime.tv_usec;
        delta_user->ru_stime.tv_sec = end_user.ru_stime.tv_sec-start_user.ru_stime.tv_sec;
    }
}

int main(int argc, char ** argv){
    
    char* operation = argv[1];
    int N = atoi(argv[2]);
    
    long long unsigned int f1, f2, f3, f4;
    struct timespec start, finish, delta;
    struct rusage start_user, end_user, delta_user;

    if(strcmp(operation, "fatorial") == 0){
        // RECURSIVO
        getrusage(RUSAGE_SELF, &start_user);
        clock_gettime(CLOCK_MONOTONIC, &start);
        f1 = fatRec(N);
        getrusage(RUSAGE_SELF, &end_user);
        clock_gettime(CLOCK_MONOTONIC, &finish);

        calculateDelta(start, finish, &delta, start_user, end_user, &delta_user);
        
        printf("RECURSIVO:\n");
        printf("Tempo relógio: %d.%.9ld\t Tempo usuário: %d.%.9ld\t Tempo sistema: %d.%.9ld\n", (int)delta.tv_sec, delta.tv_nsec, (int)delta_user.ru_utime.tv_sec, delta_user.ru_utime.tv_usec, (int)delta_user.ru_stime.tv_sec, delta_user.ru_stime.tv_usec);
        
        // ITERATIVO
        getrusage(RUSAGE_SELF, &start_user);
        clock_gettime(CLOCK_MONOTONIC, &start);
        f2 = fatIter(N);
        getrusage(RUSAGE_SELF, &end_user);
        clock_gettime(CLOCK_MONOTONIC, &finish);

        calculateDelta(start, finish, &delta, start_user, end_user, &delta_user);
        
        printf("ITERATIVO:\n");
        printf("Tempo relógio: %d.%.9ld\t Tempo usuário: %d.%.9ld\t Tempo sistema: %d.%.9ld\n", (int)delta.tv_sec, delta.tv_nsec, (int)delta_user.ru_utime.tv_sec, delta_user.ru_utime.tv_usec, (int)delta_user.ru_stime.tv_sec, delta_user.ru_stime.tv_usec);

    }
    else if(strcmp(operation, "fibonacci") == 0){
        // RECURSIVO
        getrusage(RUSAGE_SELF, &start_user);
        clock_gettime(CLOCK_MONOTONIC, &start);
        f3 = fib(N);
        getrusage(RUSAGE_SELF, &end_user);
        clock_gettime(CLOCK_MONOTONIC, &finish);

        calculateDelta(start, finish, &delta, start_user, end_user, &delta_user);

        printf("RECURSIVO:\n");
        printf("Tempo relógio: %d.%.9ld\t Tempo usuário: %d.%.9ld\t Tempo sistema: %d.%.9ld\n", (int)delta.tv_sec, delta.tv_nsec, (int)delta_user.ru_utime.tv_sec, delta_user.ru_utime.tv_usec, (int)delta_user.ru_stime.tv_sec, delta_user.ru_stime.tv_usec);
        
        // ITERATIVO
        getrusage(RUSAGE_SELF, &start_user);
        clock_gettime(CLOCK_MONOTONIC, &start);
        f4 = fibIter(N);
        getrusage(RUSAGE_SELF, &end_user);
        clock_gettime(CLOCK_MONOTONIC, &finish);

        calculateDelta(start, finish, &delta, start_user, end_user, &delta_user);
        
        printf("ITERATIVO:\n");
        printf("Tempo relógio: %d.%.9ld\t Tempo usuário: %d.%.9ld\t Tempo sistema: %d.%.9ld\n", (int)delta.tv_sec, delta.tv_nsec, (int)delta_user.ru_utime.tv_sec, delta_user.ru_utime.tv_usec, (int)delta_user.ru_stime.tv_sec, delta_user.ru_stime.tv_usec);
    }
}