#include <iostream>
#include <string>

using namespace std;

int main() {
    int i = 0, j = 0, cont[5] = {0};

    string palavra;
    char vogais[5] = {'a', 'e', 'i', 'o', 'u'};
    cin >> palavra;
    
    for (i = 0; i < palavra.length(); i++){
        for(j = 0; j < 5; j++){
            if(palavra[i] == vogais[j]){
                cont[j]++;
            }
        }
    }

    for(i = 0; i < 5; i++){
        if(cont[i] != 0){
            cout << vogais[i] << " " << cont[i] << endl;
        }
    }

    return 0;
}