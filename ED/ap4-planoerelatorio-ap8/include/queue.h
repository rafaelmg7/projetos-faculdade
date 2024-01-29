/**
 * @file   queue.h
 * @brief  File containing the definition of a dynamic circular queue
 * @author Rafael Martins Gomes
 * @date   2023-04-11
 */

#pragma once

#ifndef __QUEUE_h__
#define __QUEUE_h__


/* Inclusions */
#include <stdint.h>
#include "memlog.h"

/// Item struct
typedef struct item{
    int data;
    struct item *next;
}Item_t;

// Queue struct
typedef struct queue{
    Item_t *front;
    Item_t *back;
    int nItems;
}Queue_t;

// ------------------------------------------------------ Functions ----------------------------------------------------------------------------

Queue_t *createQueue ();
Item_t *createItem (int data);
int isQueueEmpty (Queue_t *queue);
void insertItem (Queue_t *queue, int info);
int removeItem (Queue_t *queue);
void destroyQueue (Queue_t *queue);

#endif // __QUEUE_h__