#include <iostream>
#include <sstream>
#include <cstring>
#include <cstdlib>

#include "tree.hpp"
#include "stack.hpp"

/**
 * Cria uma árvore vazia.
*/
Tree::Tree(){
    root = nullptr;
}

/**
 * Destrutor da classe. Remove todos os nós da árvore com uma função auxiliar.
*/
Tree::~Tree(){
    deleteAll();
}

/**
 * Verifica se a árvore está vazia.
 * @return "true" se a árvore estiver vazia (i.e., se a raiz não for algum nó) e "false" caso contrário.
*/
bool Tree::isEmpty(){
    return (root == nullptr);
}

/**
 * Verifica se um dado (i.e., um termo de uma expressão numérica) é um operador matemático.
 * @param op Dado (no caso, uma string) a ser verificado.
 * @return "true" caso o dado seja um operador e "false" caso contrário.
*/
bool isOperator(DataType_t op){
    return (op == "+" || op == "-" || op == "*" || op == "/");
}

/**
 * Verifica se o texto em uma string é um número.
 * @param str String a ser verificada.
 * @return "true" caso a string seja um número e "false" caso contrário.
*/
bool isNum(const std::string& str)
{
    char* endptr = 0;
    strtod(str.c_str(), &endptr);

    // Se a conversão tiver dado errado, então não é um número
    if(*endptr != '\0' || endptr == str)
        return false;
    return true;
}

/**
 * Constrói uma árvore binária contendo uma expressão numérica.
 * A árvore é construída de baixo pra cima. A expressão passada deve estar na forma posfixa.
 * @param expressao String contendo a expressão numérica a ser colocada na árvore
*/
void Tree::buildTree(DataType_t expressao){
    Stack<Node*> *stack = new Stack<Node*>;
    Node *node;
    std::istringstream iss(expressao);
    std::string aux;

    // Passa por todos os termos da expressão
    while(iss >> aux){
        node = new Node(aux);
        // Se o termo for um operador, coloca os termos de sua expressão, que estão no topo da pilha, em seus nós descendentes.
        // Caso o termo seja um operando, ele será uma folha (não terá filhos)
        if(isOperator(aux)){
            node->right = stack->pop();
            node->left = stack->pop();
        }
        // Insere o novo item na pilha
        stack->push(node);
    }

    // Define o topo da pilha como raiz da árvore e, assim, liga a raiz da árvore à expressão armazenada em nós
    root = stack->pop();
    
    delete stack;
}

/**
 * Passa pelos elementos da árvore pelo caminhamento pré-ordem, em ordem ou pós-ordem.
 * @param type Valor inteiro que representa o tipo do caminhamento desejado.
 *  '0' indica o caminhamento pré-ordem;
 *  '1' indica o caminhamento em ordem;
 *  '2' indica o caminhamento pós-ordem.
*/
void Tree::traverse(int type){
    if(type == 0) preOrder(root);
    else if(type == 1) inOrder(root);
    else if(type == 2) postOrder(root);
    else throw "ERRO: CAMINHAMENTO INEXISTENTE";
}

/**
 * Imprime um nó da árvore e, em seguida, seus descendentes da esquerda e da direita, respectivamente.
 * @param node Nó a ser impresso.
*/
void Tree::preOrder(Node *node){
    if(node != nullptr){
        std::cout << node->data << " ";
        preOrder(node->left);
        preOrder(node->right);
    }
}

/**
 * Imprime os descendentes da esquerda de um nó, o nó propriamente dito e, depois, seus descendentes da direita.
 * A impressão desse caminhamento representa a notação infixa da expressão armazenada e, para isso, o caminhamento foi
 * adaptado.
 * @param node Nó a ser impresso.
*/
void Tree::inOrder(Node *node){
    if(node != nullptr){
        // Se chegar num operador ou num número, abre parênteses
        if(isOperator(node->data) || isNum(node->data)){
            std::cout << "( ";
        }
        inOrder(node->left);
        std::cout << node->data << " ";
        inOrder(node->right);
        // Fecha os parênteses referentes a uma operação ou um número
        if(isOperator(node->data) || isNum(node->data)){
            std::cout << ") ";
        }
    }
}

/**
 * Imprime os descendentes da esquerda e da direita de um nó e, depois, o nó propriamente dito.
 * A impressão desse caminhamento representa a notação posfixa da expressão armazenada.
 * @param node Nó a ser impresso.
*/
void Tree::postOrder(Node *node){
    if(node != nullptr){
        postOrder(node->left);
        postOrder(node->right);
        std::cout << node->data << " ";
    }
}

/**
 * Retorna o resultado da expressão armazenada na árvore.
 * @return O resultado da expressão no tipo 'double'.
*/
double Tree::returnResult(){
    return solveExpression(root);
}

/**
 * Resolve a expressão numérica a partir de certo nó.
 * @return O resultado no tipo 'double'.
*/
double Tree::solveExpression(Node *node){
    if(node != nullptr){
        // Se o dado no nó for um operador, faz a operação correspondente a ele (com seus descendentes)
        if(node->data == "+"){
            return (solveExpression(node->left) + solveExpression(node->right));
        }
        else if(node->data == "-"){
            return (solveExpression(node->left) - solveExpression(node->right));
        }
        else if(node->data == "*"){
            return (solveExpression(node->left) * solveExpression(node->right));
        }
        else if(node->data == "/"){
            return (solveExpression(node->left) / solveExpression(node->right));
        }
        // Se o dado no nó for um operando, "devolve-o" para o operador que chamou a funçãoo
        else{
            return stod(node->data);
        }
    }else{
        return 0.0;
    }
}

/**
 * Apaga um nó da árvore e seus descendentes recursivamente, passando pelas sub-árvores da esquerda e da direita e deletando-as.
 * @param node Nó a ser removido.
*/
void Tree::deleteRecursively(Node *node){
    if(node != nullptr){
        deleteRecursively(node->left);
        deleteRecursively(node->right);
        delete node;
    }
}

/**
 * Apaga todos os nós da árvore.
*/
void Tree::deleteAll(){
    deleteRecursively(root);
    root = nullptr;
}