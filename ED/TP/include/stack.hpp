/**
 * @file   stack.hpp
 * @brief  Arquivo contendo a definição de uma pilha
 * @author Rafael Martins Gomes
 * @date   2023-04-22
 */

#pragma once

#ifndef __STACK_hpp__
#define __STACK_hpp__


/* Inclusões */
#include "item.hpp"

/**
 * Representação de uma pilha implementada como lista encadeada. Aqui, o último elemento a ser inserido é o primeiro a ser removido.
 * O tipo dos elementos é especificado na criação da pilha.
*/
template<typename T>
class Stack {
    public:
        /**
         * Construtor da classe. Cria uma pilha sem elementos.
        */
        Stack(){
            top = nullptr;
            size = 0;
        };

        /**
         * Destrutor da classe. Remove todos os itens da pilha.
        */
        ~Stack(){
            removeAll();
        };

        /**
         * Obtém o tamanho da pilha.
         * @return O número de itens da pilha;
        */
        int getSize() {return size;};

        /**
         * Verifica se a pilha está vazia.
         * @return "true" se a pilha estiver vazia e "false" caso contrário.
        */
        bool isStackEmpty() {return size == 0; };

        /**
         * Insere um novo elemento na pilha.
         * @param info Dado do novo item a ser inserido na pilha.
        */
        void push(T info){
            // Cria um novo item com o dado passado e o define como novo topo da pilha.
            // Assim, seu próximo elemento será o item que estava antes como topo da pilha.
            Item<T> *newItem = new Item<T>(info);
            newItem->next = this->top;
            this->top = newItem;
            
            // Incrementa o tamanho da pilha
            this->size++;
        };
        
        /**
         * Remove o primeiro item da pilha.
         * @return O dado do item removido.
        */
        T pop(){
            if(!isStackEmpty()){
                Item<T> *temp = this->top;
                T removed = temp->data;

                // O topo da pilha será o item logo após o primeiro, que será removido
                this->top = temp->next;

                // Apaga o item da memória
                delete temp;

                this->size--;

                // Se chegou até aqui, deu tudo certo
                return removed;
            }
            // Caso a pilha esteja vazia, não há dado a ser retornado; logo, retorna um valor nulo
            else{
                return nullptr;
            }
        };

        /**
         * Obtém o elemento no topo da pilha.
         * @return Um apontador para o item no topo da pilha.
        */       
        Item<T> *getTop(){
            return top;
        }

        /**
         * Apaga todos os itens da pilha da memória.
        */
        void removeAll(){
            // Remove o item que está no topo até que a pilha esteja vazia.
            while(!isStackEmpty()){
                pop();
            }
        };

    private:
        // Variável que armazena o número de elementos da pilha.
        int size;

        // Apontador para o primeiro item da pilha .
        Item<T> *top;
};

#endif // __STACK_hpp__