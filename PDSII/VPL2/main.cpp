#include <iostream>
#include <map>  // Isto é uma dica. 

using namespace std;

int main() {
    map<string, int> frase;
    string aux, comum;
    int i = 0, cont = 0;

    while (cin >> aux){
        frase[aux]++;
    }

    map<string, int>::iterator it;
    for(it = frase.begin(); it != frase.end(); it++){
        if(it->second > cont){
            comum = it->first;
            cont = it->second;
        }
    }

    cout << comum << endl;

    return 0;
}