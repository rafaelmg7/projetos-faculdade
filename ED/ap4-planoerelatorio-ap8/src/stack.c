/**
 * @file queue.c
 * @brief Implementation of a dynamic circular queue
 * @author Rafael Martins Gomes
 * @date 2023-04-11
 */

#include <stdio.h>
#include <stdlib.h>
#include "../include/stack.h"
// #include "../include/memlog.h"

Stack_t *createStack(){
    Stack_t *stack = (Stack_t *) malloc (sizeof(Stack_t));
    stack->queue = createQueue();

    return stack;
}

int isStackEmpty(Stack_t *stack){
    return (stack->queue->nItems == 0);
}

void stackf(Stack_t *stack, int data){
    insertItem(stack->queue, data);
}

int unstack(Stack_t *stack){
    if(!isStackEmpty(stack)){
        int size = stack->queue->nItems;
        int removed;

        while((size - 1) > 0){
            removed = removeItem(stack->queue);
            insertItem(stack->queue, removed);
            size--;
        }
        removed = removeItem(stack->queue);

        return removed;
    }else{
        return -1;
    }
}

// void printStack(Stack_t* stack){
//     if (!isStackEmpty(stack)) {
//         int i, data;
//         for (i = 0; i < (stack->queue->nItems - 1); i++) {
//             LEMEMLOG((long int)((stack->queue->back)), sizeof(Item_t));
//             data = removeItem(stack->queue);
//             insertItem(stack->queue, data);
//             printf("Item #%d: %d\n", i, data);
//         }
//         data = removeItem(stack->queue);
//         insertItem(stack->queue, data);
//         printf("Item #%d: %d\n", i, data);

//     }else{
//         printf("The stack is empty.\n");
//     }
// }

void destroyStack(Stack_t *stack){
    destroyQueue(stack->queue);
    free(stack);
}