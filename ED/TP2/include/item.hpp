/**
 * @file   item.hpp
 * @brief  Arquivo contendo a definição de um item da pilha
 * @author Rafael Martins Gomes
 * @date   2023-06-01
 */

#pragma once

#ifndef __ITEM_hpp__
#define __ITEM_hpp__


template<typename T> class Stack;

/**
 * Classe com informações de um item de uma pilha.
 * Esse item conta com um item de tipo genérico que é especificado na criação do item e um apontador para o próximo item da pilha.
*/
template<typename T>
class Item {
    public:
        /**
         * Construtor que inicializa um novo Item
         * @param data Dado a ser inserido na pilha.
        */
        Item(T data){
            this->data = data;
            this->next = nullptr;
        };

        /**
         * Obtém o dado armazenado no item.
         * @return O dado do item.
        */
        T getData(){
            return data;
        }

    private:
        T data;
        Item<T> *next;

    friend class Stack<T>;
};


#endif // __ITEM_hpp__