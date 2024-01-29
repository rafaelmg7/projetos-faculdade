#include "jogo_da_vida.h"
#include <iostream>

using namespace std;

int JogoDaVida::NumeroDeVizinhasVivas(int x, int y){
    int i, j, count = 0, aux1, aux2;
    for(i = x-1; i < x + 2; i++){
        aux1 = i;
        if(i == -1){
            aux1 = linhas() - 1;
        }else if(i == linhas()){
            aux1 = 0;
        }
        for(j = y-1; j < y + 2; j++){
            aux2 = j;
            if(j == -1) aux2 = colunas() - 1;
            else if(j == colunas()) aux2 = 0;

            if(viva(aux1, aux2)) count++;
        }
    }

    // Célula x,y é contada nos loops. Se estiver viva, tira ela da conta
    if(viva(x, y)) count--;
    return count;
}

JogoDaVida::JogoDaVida(int l, int c){
    int i, j;
    for(i = 0; i < l; i++){
        std::vector<bool> v;
        for(j = 0; j < c; j++){
            v.push_back(false);
        }
        vivas_.push_back(v);
    }
}

bool JogoDaVida::viva(int i, int j){
    return (vivas_[i][j]);
}

void JogoDaVida::Matar(int i, int j){
    vivas_[i][j] = false;
}

void JogoDaVida::Reviver(int i, int j){
    vivas_[i][j] = true;
}

void JogoDaVida::ExecutarProximaIteracao(){
    int i, j;
    vector<vector<bool>> aux2 (linhas(), vector<bool> (colunas(), 0));
    int aux;
    for(i = 0; i < linhas(); i++){
        for(j = 0; j < colunas(); j++){
            aux = NumeroDeVizinhasVivas(i, j);
            if(viva(i, j) && (aux <= 1 || aux > 3)){
                aux2[i][j] = false;
            }else if(!viva(i, j) && aux == 3){
                aux2[i][j] = true;
            }else{
                aux2[i][j] = vivas_[i][j]; 
            }
        }
    }

    for(i = 0; i < linhas(); i++){
        for(j = 0; j < colunas(); j++){
            vivas_[i][j] = aux2[i][j];
        }
    }
}

