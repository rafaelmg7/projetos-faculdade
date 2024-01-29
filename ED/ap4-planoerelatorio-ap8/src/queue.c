/**
 * @file queue.c
 * @brief Implementation of a dynamic circular queue
 * @author Rafael Martins Gomes
 * @date 2023-04-11
 */

#include <stdio.h>
#include <stdlib.h>
#include "../include/queue.h"
// #include "../include/memlog.h"

Queue_t *createQueue (){
    Queue_t *queue = (Queue_t *) malloc (sizeof(Queue_t));
    queue->front = queue->back = NULL;
    queue->nItems = 0;

    return queue;
}

Item_t *createItem (int data){
    Item_t *item = (Item_t *)malloc(sizeof(Item_t));
    item->data = data;
    item->next = NULL;

    return item;
}

int isQueueEmpty (Queue_t *queue){
    return (queue->nItems == 0);
}

void insertItem (Queue_t *queue, int info){
    Item_t *newItem = createItem(info);
    if(isQueueEmpty(queue)){
        queue->front = newItem;
    }else{
        queue->back->next = newItem;
    }

    queue->back = newItem;
    newItem->next = queue->front;
    
    queue->nItems++;

    ESCREVEMEMLOG((long int)((queue->back)), sizeof(Item_t));
}

int removeItem (Queue_t *queue){
    if(!isQueueEmpty(queue)){
        LEMEMLOG((long int)((queue->front)), sizeof(Item_t));
        int removed = queue->front->data;
        if(queue->front == queue->back){
            free(queue->front);
            queue->front = queue->back = NULL;
        }else{
            Item_t *aux = queue->front;
            queue->front = queue->front->next;
            queue->back->next = queue->front;
            free(aux);
        }

        queue->nItems--;

        return removed;
    }else{
        return -1;
    }
}

void destroyQueue (Queue_t *queue){
    while(!isQueueEmpty(queue)){
        removeItem(queue);
    }
    free(queue);
}