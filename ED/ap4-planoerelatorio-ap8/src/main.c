/**
 * @file main.c
 * @brief File for execution and maintenance of a stack implemented with a circular queue
 * @author Rafael Martins Gomes
 * @date 2023-04-13
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "../include/stack.h"
// #include "../include/memlog.h"

int main(){
    Stack_t *stack = createStack();
    int i, x;

    srand(time(NULL));

    iniciaMemLog("teste.out");

    defineFaseMemLog(0);
    for(i = 0; i < 1000; i++){
        x = rand() % 10;
        stackf(stack, x);
        printf("Item #%d: %d\n", i, x);
    }
    // printStack(stack);
    defineFaseMemLog(1);
    for(i = 0; i < 1000; i++){
        printf("%d\n", unstack(stack));
    }

    destroyStack(stack);

    return 0;
}