#include <iostream>
#include <vector>

using namespace std;

int main(){
    int l1, l2, c2;
    int i, j, k, valor = 0, soma;

    vector<vector<int>> matriz1;
    vector<vector<int>> matriz2;
    vector<vector<int>> resultado;

    cin >> l1 >> l2 >> c2;

    for(i = 0; i < l1; i++){
        vector<int> aux;
        for(j = 0; j < l2; j++){
            cin >> valor;
            aux.push_back(valor);
        }
        matriz1.push_back(aux);
    }

    for(i = 0; i < l2; i++){
        vector<int> aux;
        for(j = 0; j < c2; j++){
            cin >> valor;
            aux.push_back(valor);
        }
        matriz2.push_back(aux);
    }

    for(i = 0; i < l1; i++){
        vector<int> aux;
        for(k = 0; k < c2; k++){
            soma = 0;
            for(j = 0; j < l2; j++){
                soma += (matriz1[i][j] * matriz2[j][k]);
            }
            aux.push_back(soma);
        }
        resultado.push_back(aux);
    }

    for(i = 0; i < l1; i++){
        for(j = 0; j < c2; j++){
            cout << resultado[i][j] << " ";
        }
        cout << endl;
    }

    return 0;
}