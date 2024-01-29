/**
 * @file   list.hpp
 * @brief  Arquivo contendo a definição de uma lista encadeada genérica
 * @author Rafael Martins Gomes
 * @date   2023-06-28
 */

#pragma once

#ifndef __LIST_hpp__
#define __LIST_hpp__

#include "item.hpp"
#include <string>

/**
 * Classe com informações de uma lista encadeada.
 * A lista encadeada conta com um apontador para o primeiro item da lista e um inteiro que armazena o tamanho da lista.
 * O tipo de dado armazenado na lista é especificado na criação da lista.
*/
template<typename T>
class List{
    public:
        /**
         * Construtor que inicializa uma nova lista.
        */
        List(){
            head = nullptr;
            size = 0;
        };

        /**
         * Destrutor que desaloca a memória alocada para a lista.
         * O destrutor chama o método deleteAll() para desalocar a memória de todos os itens da lista.
         * @see deleteAll()
        */
        ~List(){
            deleteAll();
        };

        /**
         * Obtém o tamanho da lista.
         * @return O tamanho da lista.
        */
        int getSize(){
            return size;
        };

        /**
         * Verifica se a lista está vazia.
         * @return true se a lista estiver vazia, false caso contrário.
        */
        bool isEmpty(){
            return size == 0;
        };

        /**
         * Insere um item no início da lista.
         * @param data Dado a ser inserido na lista.
        */
        void insertFirst(T data){
            Item<T> *newItem = new Item<T>(data);

            newItem->next = head;
            head = newItem;
            size++;
        };

        /**
         * Insere um item ordenadamente na lista.
         * @param newNode Dado a ser inserido na lista.
         * @see Item<T>::operator<()
        */
        void insertOrdered(T newNode){
            Item<T> *newItem = new Item<T>(newNode);
            Item<T> *aux = head;
            Item<T> *prev = nullptr;

            while(aux != nullptr && aux->data->operator<(*newNode)){
                prev = aux;
                aux = aux->next;
            }

            if(prev == nullptr){
                newItem->next = head;
                head = newItem;
            }else{
                newItem->next = prev->next;
                prev->next = newItem;
            }

            size++;
        };

        /**
         * Remove o primeiro item da lista.
         * @return O dado do item removido.
        */
        T deleteFirst(){
            Item<T> *aux = head;
            T deletedNode = aux->data;

            head = head->next;
            delete aux;
            size--;

            return deletedNode;
        };

        /**
         * Remove todos os itens da lista.
         * O método remove todos os itens da lista chamando o método deleteFirst() até que a lista esteja vazia.
         * @see deleteFirst()
        */
        void deleteAll(){
            while(size > 0){
                deleteFirst();
            }
        };        

    private:
        Item<T> *head;
        int size;

        friend class Codes;
};

#endif // __LIST_hpp__