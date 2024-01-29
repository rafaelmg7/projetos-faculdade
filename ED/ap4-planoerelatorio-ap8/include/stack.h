/**
 * @file   stack.h
 * @brief  File containing the definition of a dynamic stack using a queue
 * @author Rafael Martins Gomes
 * @date   2023-04-11
 */

#pragma once

#ifndef __STACK_h__
#define __STACK_h__


/* Inclusões */
#include <stdint.h>
#include "queue.h"
// #include "memlog.h"

// Stack struct
typedef struct stack{
    Queue_t *queue;
}Stack_t;

// ------------------------------------------------------ Functions ----------------------------------------------------------------------------

Stack_t *createStack ();
int isStackEmpty(Stack_t *stack);
void stackf(Stack_t *stack, int data);
int unstack(Stack_t *stack);
void printStack(Stack_t* stack);
void destroyStack(Stack_t *stack);

#endif // __STACK_h__