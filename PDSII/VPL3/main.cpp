#include <iostream>

using namespace std;

int main(){
    int i;

    // 1) Declare uma variável do tipo inteiro e atribua o valor '10'
    int var1 = 10;

    // 2) Declare um ponteiro para inteiros e inicialize com valor nulo (aka 'nullptr')
    int *ptr2 = nullptr;

    // 3) Declare um vetor de inteiros e inicialize com valores de 9 a 0 (nessa ordem)
    int vet3[10] = {9, 8, 7, 6, 5, 4, 3, 2, 1, 0};

    // 4) Imprima o ENDEREÇO da variável declarada em (1)
    cout << &var1 << endl;

    // 5) Imprima o CONTEÚDO da variável declarada em (1)
    cout << var1 << endl;

    // 6) Imprima o ENDEREÇO da variável declarada em (2)
    cout << &ptr2 << endl;

    // 7) Imprima o CONTEÚDO da variável declarada em (2)
    cout << ptr2 << endl;

    // 8) Imprima o ENDEREÇO da variável declarada em (3)
    cout << &vet3 << endl;

    // 9) Imprima o ENDEREÇO da primeira posição da variável declarada em (3)
    cout << vet3 << endl;

    // 10) Imprima o CONTEÚDO da primeira posição da variável declarada em (3)
    cout << *vet3 << endl;

    // 11) Atribua o ENDEREÇO da variável declarada em (1) à variável declarada em (2)
    ptr2 = &var1;

    // 12) Imprima o CONTEÚDO da variável declarada em (2)
    cout << ptr2 << endl;

    // 13) Imprima o CONTEÚDO da varíavel que é apontada por (2)
    cout << *ptr2 << endl;

    // 14) Imprima o resultado da comparação do ENDEREÇO de (1) e do CONTEÚDO de (2)
    cout << (&var1 == ptr2) << endl;

    // 15) Coloque o VALOR '5' na varíavel que é apontada pela variável de (2)
    *ptr2 = 5;

    // 16) Imprima o CONTEÚDO da variável declarada em (1)
    cout << var1 << endl;

    // 17) Atribua o CONTEÚDO da variável de (3) à variável de (2)
    ptr2 = vet3;

    // 18) Imprima o CONTEÚDO da variável declarada em (2) 
    cout << ptr2 << endl;

    // 19) Imprima o CONTEÚDO da variável que é apontada pela variável de (2)
    cout << *ptr2 << endl;

    // 20) Atribua o ENDEREÇO da primeira posição de (3) à variável de (2)
    ptr2 = &vet3[0];

    // 21) Imprima o CONTEÚDO da variável declarada em (2) 
    cout << ptr2 << endl;

    // 22) Imprima o CONTEÚDO da variável que é apontada pela variável de (2) 
    cout << *ptr2 << endl;

    // 23) Imprima os elementos de (3) utilizando a notação [] (e.g. v[i])
    for(i = 0; i < 10; i++){
        cout << vet3[i];
        if(i != 9) cout << " ";
        else cout << endl;
    }

    // 24) Imprima os elementos de (3) utilizando a notação ponteiro/deslocamento (e.g. *(v + i))
    for(i = 0; i < 10; i++){
        cout << *(vet3 + i);
        if(i != 9) cout << " ";
        else cout << endl;
    }

    return 0;
}