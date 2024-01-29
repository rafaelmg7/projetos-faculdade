#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/resource.h>
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
    int i;
    long long unsigned int f;
    // f = fib(4);
    struct timespec start, finish, delta;
    struct rusage start_user, end_user, delta_user;
    // clock_t start, end;
    struct timespec start_total_time_clock_rec, end_total_time_clc, total_time_clock_iter;
    struct rusage total_time_system_user_rec , total_time_system_user_iter ;

    double system_total_rec =0.0, user_total_rec=0.0, clock_total_rec=0.0, system_total_iter=0.0, user_total_iter=0.0, clock_total_iter=0.0;

    // RECURSIVO:
    // getrusage(RUSAGE_SELF, &total_time_system_user_rec);
    // clock_gettime(CLOCK_MONOTONIC, &start);
    for(i = 1; i <= MAXFIB; i++){
        getrusage(RUSAGE_SELF, &start_user);
        clock_gettime(CLOCK_MONOTONIC, &start);
        // start = clock();
        f = fib(i);
        getrusage(RUSAGE_SELF, &end_user);
        clock_gettime(CLOCK_MONOTONIC, &finish);

        calculateDelta(start, finish, &delta, start_user, end_user, &delta_user);
        // double deltaClock = ((finish.tv_sec - start.tv_sec) + (finish.tv_nsec - start.tv_nsec)) / 10e9;
        // double deltaUser = ((end_user.ru_utime.tv_sec - start_user.ru_utime.tv_sec) + (end_user.ru_utime.tv_usec - start_user.ru_utime.tv_usec)) / 10e6;
        // double deltaSystem = ((end_user.ru_stime.tv_sec - start_user.ru_stime.tv_sec) + (end_user.ru_stime.tv_usec - start_user.ru_stime.tv_usec)) / 10e6;

        clock_total_rec += delta.tv_sec + (delta.tv_nsec / 10e9);
        user_total_rec += delta_user.ru_utime.tv_sec + (delta_user.ru_utime.tv_usec / 10e6);
        system_total_rec += delta_user.ru_stime.tv_sec + (delta_user.ru_stime.tv_usec / 10e6);
        // clock_total_iter += it_clock_time; 
        // user_total_iter += it_user_time;
        // system_total_iter += it_sys_time;
        // sub_timespec(start, finish, &delta);
        // if (finish.tv_nsec < start.tv_nsec){
        //     // ajuste necessario, utilizando um segundo de tv_sec
        //     delta.tv_nsec = 1000000000+finish.tv_nsec-start.tv_nsec;
        //     delta.tv_sec = finish.tv_sec-start.tv_sec-1;
        // } else {
        //     // nao e necessario ajuste
        //     delta.tv_nsec = finish.tv_nsec-start.tv_nsec;
        //     delta.tv_sec = finish.tv_sec-start.tv_sec;
        // }

        // if (end_user.ru_utime.tv_usec < start_user.ru_utime.tv_usec){
        //     // ajuste necessario, utilizando um segundo de tv_sec
        //     delta_user.ru_utime.tv_usec = 1000000+end_user.ru_utime.tv_usec-start_user.ru_utime.tv_usec;
        //     delta_user.ru_utime.tv_sec = end_user.ru_utime.tv_sec-start_user.ru_utime.tv_sec-1;
        // } else {
        //     // nao e necessario ajuste
        //     delta_user.ru_utime.tv_usec = end_user.ru_utime.tv_usec-start_user.ru_utime.tv_usec;
        //     delta_user.ru_utime.tv_sec = end_user.ru_utime.tv_sec-start_user.ru_utime.tv_sec;
        // }

        // if (end_user.ru_stime.tv_usec < start_user.ru_stime.tv_usec){
        //     // ajuste necessario, utilizando um segundo de tv_sec
        //     delta_user.ru_stime.tv_usec = 1000000+end_user.ru_stime.tv_usec-start_user.ru_stime.tv_usec;
        //     delta_user.ru_stime.tv_sec = end_user.ru_stime.tv_sec-start_user.ru_stime.tv_sec-1;
        // } else {
        //     // nao e necessario ajuste
        //     delta_user.ru_stime.tv_usec = end_user.ru_stime.tv_usec-start_user.ru_stime.tv_usec;
        //     delta_user.ru_stime.tv_sec = end_user.ru_stime.tv_sec-start_user.ru_stime.tv_sec;
        // }
        

        // printf("Tempo relógio: %lf\t Tempo usuário: %lf\t Tempo sistema: %lf\n", deltaClock, deltaUser, deltaSystem);
        printf("Tempo relógio: %d.%.9ld\t Tempo usuário: %d.%.9ld\t Tempo sistema: %d.%.9ld\n", (int)delta.tv_sec, delta.tv_nsec, (int)delta_user.ru_utime.tv_sec, delta_user.ru_utime.tv_usec, (int)delta_user.ru_stime.tv_sec, delta_user.ru_stime.tv_usec);

        // end = clock();
        // time_spent += (double)(end - start) / CLOCKS_PER_SEC;
        // printf("Tempo: %.2f\n", time_spent);
        // time_spent = 0.0;
        // clock_gettime(CLOCK_MONOTONIC, &start);

        // total_time_clock_rec += del
        // total_time_system_rec +=
        // total_time_user_rec +=

    }

    printf("\nTempo total relógio: %lf\t Tempo total usuário: %lf\t Tempo total sistema: %lf\n", clock_total_rec, user_total_rec, system_total_rec);



    for(i = 1; i <= MAXFIB; i++){
        getrusage(RUSAGE_SELF, &start_user);
        clock_gettime(CLOCK_MONOTONIC, &start);
        // start = clock();
        f = fibIter(i);
        getrusage(RUSAGE_SELF, &end_user);
        clock_gettime(CLOCK_MONOTONIC, &finish);

        calculateDelta(start, finish, &delta, start_user, end_user, &delta_user);
        // double deltaClock = ((finish.tv_sec - start.tv_sec) + (finish.tv_nsec - start.tv_nsec)) / 10e9;
        // double deltaUser = ((end_user.ru_utime.tv_sec - start_user.ru_utime.tv_sec) + (end_user.ru_utime.tv_usec - start_user.ru_utime.tv_usec)) / 10e6;
        // double deltaSystem = ((end_user.ru_stime.tv_sec - start_user.ru_stime.tv_sec) + (end_user.ru_stime.tv_usec - start_user.ru_stime.tv_usec)) / 10e6;

        clock_total_iter += delta.tv_sec + (delta.tv_nsec / 10e9);
        user_total_iter += delta_user.ru_utime.tv_sec + (delta_user.ru_utime.tv_usec / 10e6);
        system_total_iter += delta_user.ru_stime.tv_sec + (delta_user.ru_stime.tv_usec / 10e6);
        // clock_total_iter += it_clock_time; 
        // user_total_iter += it_user_time;
        // system_total_iter += it_sys_time;
        // sub_timespec(start, finish, &delta);
        // if (finish.tv_nsec < start.tv_nsec){
        //     // ajuste necessario, utilizando um segundo de tv_sec
        //     delta.tv_nsec = 1000000000+finish.tv_nsec-start.tv_nsec;
        //     delta.tv_sec = finish.tv_sec-start.tv_sec-1;
        // } else {
        //     // nao e necessario ajuste
        //     delta.tv_nsec = finish.tv_nsec-start.tv_nsec;
        //     delta.tv_sec = finish.tv_sec-start.tv_sec;
        // }

        // if (end_user.ru_utime.tv_usec < start_user.ru_utime.tv_usec){
        //     // ajuste necessario, utilizando um segundo de tv_sec
        //     delta_user.ru_utime.tv_usec = 1000000+end_user.ru_utime.tv_usec-start_user.ru_utime.tv_usec;
        //     delta_user.ru_utime.tv_sec = end_user.ru_utime.tv_sec-start_user.ru_utime.tv_sec-1;
        // } else {
        //     // nao e necessario ajuste
        //     delta_user.ru_utime.tv_usec = end_user.ru_utime.tv_usec-start_user.ru_utime.tv_usec;
        //     delta_user.ru_utime.tv_sec = end_user.ru_utime.tv_sec-start_user.ru_utime.tv_sec;
        // }

        // if (end_user.ru_stime.tv_usec < start_user.ru_stime.tv_usec){
        //     // ajuste necessario, utilizando um segundo de tv_sec
        //     delta_user.ru_stime.tv_usec = 1000000+end_user.ru_stime.tv_usec-start_user.ru_stime.tv_usec;
        //     delta_user.ru_stime.tv_sec = end_user.ru_stime.tv_sec-start_user.ru_stime.tv_sec-1;
        // } else {
        //     // nao e necessario ajuste
        //     delta_user.ru_stime.tv_usec = end_user.ru_stime.tv_usec-start_user.ru_stime.tv_usec;
        //     delta_user.ru_stime.tv_sec = end_user.ru_stime.tv_sec-start_user.ru_stime.tv_sec;
        // }
        

        // printf("Tempo relógio: %lf\t Tempo usuário: %lf\t Tempo sistema: %lf\n", deltaClock, deltaUser, deltaSystem);
        printf("Tempo relógio: %d.%.9ld\t Tempo usuário: %d.%.9ld\t Tempo sistema: %d.%.9ld\n", (int)delta.tv_sec, delta.tv_nsec, (int)delta_user.ru_utime.tv_sec, delta_user.ru_utime.tv_usec, (int)delta_user.ru_stime.tv_sec, delta_user.ru_stime.tv_usec);


    }

    printf("\nTempo total relógio: %.9lf\t Tempo total usuário: %lf\t Tempo total sistema: %lf\n", clock_total_iter, user_total_iter, system_total_iter);
    // printf("%d\n", f);
}