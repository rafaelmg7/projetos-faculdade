#include <iostream>
#include <sstream>
#include <cstring>
#include <iomanip>

#include "leitura.hpp"

/**
 * Armazena uma expressão numérica em uma árvore binária.
 * A expressão só é armazenada se for válida.
 * @param exp String contendo a expressão a ser armazenada.
 * @param tipo Tipo da expressão ("POSFIXA" ou "INFIXA").
*/
void Leitura::armazenaExpressao(std::string& exp, std::string& tipo){
    // Caso já exista uma expressão na árvore, remove-a antes de armazenar a nova expressão
    if(!expressionTerms.isEmpty()){
        expressionTerms.deleteAll();
    }

    // Só armazena a expressão se ela passar na etapa de validação.
    if(validaExpressao(exp, tipo)){
        // Se a expressão for posfixa, pode ser armazenada diretamente na árvore.
        if(tipo == "POSFIXA"){
            expressionTerms.buildTree(exp);
        }
        // Caso seja infixa, deve-se passá-la para posfixa e, depois, armazená-la na árvore.
        else if(tipo == "INFIXA"){
            infixaParaPosfixa(exp);
            expressionTerms.buildTree(exp);
        }else{
            ExcecaoTipoInvalido e;
            throw e;
        }
    }else{
        ExcecaoExpressaoInvalida e;
        throw e;
    }
}

/**
 * Passa uma expressão em notação infixa para notação posfixa.
 * Importante ressaltar que a expressão em notação infixa deve ter parênteses em todos os números e operações.
 * @param exp Expressão a ser convertida.
*/
void Leitura::infixaParaPosfixa(std::string& exp){
    std::string temp, atual, posfixa, anterior;
    Stack<std::string> stack;
    std::istringstream iss(exp);
    
    // Passa pelos termos da expressão (incluindo os parênteses) inserindo-os em uma pilha
    while (iss >> atual){
        // Sempre que achar um parêntese fechado, desempilha os termos da pilha e coloca-os na nova expressão até achar um parêntese aberto.
        if(atual == ")"){
            temp = stack.pop();
            while(temp != "("){
                posfixa.append(temp);
                posfixa.append(" ");
                temp = stack.pop();
            }
        }else{
            stack.push(atual);
        }
    }

    posfixa.pop_back();
    exp = posfixa;
}

/**
 * Verifica se a expressão numérica passada é válida.
 * Aqui, são verificados os números de parênteses, de números e de operadores, bem como se os operandos são de fato números
 * e se as expressões batem com suas notações
*/
bool Leitura::validaExpressao(std::string& exp, std::string& tipo){
    
    // Se o tamanho da expressão exceder o permitido, ela não é válida
    if(exp.length() > 1000){
        return false;
    }

    int i, nParentesesAbertos = 0, nParentesesFechados = 0, nNumeros = 0, nOperadores = 0;
    
    // Substitui as vírgulas por pontos
    for (i = 0; i < exp.length(); i++){
        if(exp[i] == ','){
            exp[i] = '.';
        }
    }

    std::istringstream iss(exp);
    std::string atual, anterior = " ";

    // Passa por todos os termos da expressão passada para os verificar
    while(iss >> atual){
        
        // Expressões em notação posfixa não podem ter parênteses  
        if(atual == "("){
            if(tipo == "POSFIXA") return false;
            nParentesesAbertos++;
        }else if(atual == ")"){
            if(tipo == "POSFIXA") return false;
            if(anterior != ")" && !isNum(anterior)){
                return false;
            }
            nParentesesFechados++;
        }else if(isOperator(atual)){
            if(tipo == "POSFIXA"){
                // Verifica o número de operandos na expressão posfixa
                if(!(nNumeros - nOperadores >= 2)) return false;
            }
            nOperadores++;
        }else{
            // Se não for parêntese ou operador, tem que ser um número; se a expressão for infixa, o termo anterior ao número
            // deve ser um parêntese. Note que, nessa implementação, a expressão em notação infixa deve ter parênteses para todos
            // os operandos e operações.
            if(tipo == "INFIXA"){
                if(anterior != " " && (anterior != "(" && anterior != ")")){
                    return false;
                }
            }
            if(!isNum(atual)) return false;

            // Se chegou até aqui, é um número
            nNumeros++;
        }
        anterior = atual;
    }

    // Numa expressão posfixa, o último termo deve ser um operador
    if(tipo == "POSFIXA"){
        if(!isOperator(atual)) return false;
    }

    // Numa expressão infixa, deve-se ter parênteses
    if(tipo == "INFIXA"){
        if(nParentesesAbertos == 0 || nParentesesFechados == 0) return false;
    }

    // Agora, resta saber se os números de parênteses e de operadores estão corretos
    return ((nParentesesAbertos == nParentesesFechados) && (nNumeros == nOperadores + 1));
}

/**
 * Exibe o resultado da expressão armazenada. Seis dígitos decimais serão exibidos.
*/
void Leitura::imprimeResultado(){
     if(!expressionTerms.isEmpty()){
        std::cout << std::setprecision(6);
        std::cout << std::fixed << expressionTerms.returnResult() << std::endl;
    }
    // Se não houver expressão armazenada, não há como resolver; lança uma exceção informando isso
    else{
        ExcecaoExpressaoInexistente e;
        throw e;
    }
}

/**
 * Exibe a expressão armazenada em notação posfixa. Isso é feito por meio do caminhamento pós-ordem na árvore de expressão.
*/
void Leitura::imprimePosfixa(){
     if(!expressionTerms.isEmpty()){
        expressionTerms.traverse(2);
        std::cout << std::endl;
    }
    // Se não houver expressão armazenada, não há como exibí-la; lança uma exceção informando isso
    else{
        ExcecaoExpressaoInexistente e;
        throw e;
    }
}

/**
 * Exibe a expressão armazenada em notação infixa. Isso é feito por meio do caminhamento in-ordem na árvore de expressão.
*/
void Leitura::imprimeInfixa(){
    if(!expressionTerms.isEmpty()){
        expressionTerms.traverse(1);
        std::cout << std::endl;
    }
    // Se não houver expressão armazenada, não há como exibí-la; lança uma exceção informando isso
    else{
        ExcecaoExpressaoInexistente e;
        throw e;
    }
}

/**
 * Remove a expressão armazenada na árvore.
*/
void Leitura::limpaArvore(){
    expressionTerms.deleteAll();
}