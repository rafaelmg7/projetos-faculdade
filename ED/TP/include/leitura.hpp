/**
 * @file   leitura.hpp
 * @brief  Arquivo contendo informações da classe que realiza a leitura de uma expressão matemática
 * @author Rafael Martins Gomes
 * @date   2023-04-22
 */

#pragma once

#ifndef __LEITURA_hpp__
#define __LEITURA_hpp__


/* Inclusões */
#include "tree.hpp"
#include "stack.hpp"

/* Exceções */
struct ExcecaoExpressaoInvalida {};
struct ExcecaoExpressaoInexistente {};
struct ExcecaoComandoInvalido {};
struct ExcecaoTipoInvalido {};


/**
 * Classe com as informações do leitor da expressão numérica.
 * Na parte de leitura, é feita a validação da expressão, bem como o armazenamento da expressão (caso ela seja válida) 
 * e as operações que se queira fazer com ela. 
*/
class Leitura {
    public:
        void armazenaExpressao(std::string &exp, std::string& tipo);
        void infixaParaPosfixa(std::string& exp);
        bool validaExpressao(std::string& exp, std::string& tipo);
        void imprimePosfixa();
        void imprimeInfixa();
        void imprimeResultado();
        void limpaArvore();

    private:
        // Árvore que armazenará a expressão numérica.
        Tree expressionTerms;
};

#endif // __LEITURA_hpp__