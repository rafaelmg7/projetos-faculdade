#include <regex>
#include <math.h>
#include <string>
#include <vector>
#include <sstream>
#include <ctype.h>
#include <list>

#include "LineProcessor.hpp"

void LinePrinter::processaLinha(const std::string &str) {
  std::cout << str << std::endl;
}

bool ContadorPopRural::linhaValida(const std::string &str) const {
  // Neste exemplo usaremos expressoes regulares para verificar se uma linha
  // eh valida ou nao.
  //
  // Esta expressao regular eh formada por cinco partes. Cada uma dessas
  // partes eh um dos tres tipos de padrao regular abaixo:
  //
  // \\w+ eh qualquer palavra com um ou mais digitos, letras e sublinhas (_)
  // \\s* eh qualquer sequencia de zero ou mais espacos (inclui tab)
  // \\d+ eh qualquer sequencia de um ou mais digitos
  std::regex regularExpr("\\w+\\s*\\d+\\s*\\d+");

  // A funcao regex_match vai retornar verdadeiro se a string str casa-se com
  // a expressao regular que acabamos de criar:
  return std::regex_match(str, regularExpr);
}

void ContadorPopRural::processaLinha(const std::string &str) {
  //
  // Em geral eh mais facil ler dados de uma string se a string eh transformada
  // em um objeto do tipo stringstream:
  std::stringstream ss(str);
  //
  // Iremos ler os dados da string nestas tres variaveis abaixo:
  std::string nomePais;
  unsigned populacao, percUrbana;
  //
  // Como sabemos que a linha contem string int int, podemos fazer a leitura
  // facilmente usando o operador de streaming:
  ss >> nomePais >> populacao >> percUrbana;
  //
  // Note que precisamos arredondar o valor que serah impresso. O arredondamento
  // serah feito via a funcao floor. Ou seja, decimais serao sempre
  // arredondados para baixo:
  unsigned popRural = floor(populacao - (populacao * (percUrbana/100.0)));
  //
  // Uma vez encontrados os valores que precisam ser impressos, seguimos o
  // modelo do enunciado do exercicio:
  std::cout << popRural << " pessoas vivem no campo no " << nomePais <<
    std::endl;
}

bool ContadorNumNaturais::linhaValida(const std::string &str) const {
  // TODO: Implemente este metodo
  // for(i = 0; i < str.length(); i++){
  //   int codigo = int((unsigned char)str[i]);
  //   if(isdigit(str.at(i)) || codigo == 32 || codigo == 9 || codigo == 11){
  //     continue;
  //   }else{
  //     return false;
  //   }
  // }

  for(auto const& c : str){
    if(!isdigit(c) && c != ' ') return false;
  }

  return true;
}

void ContadorNumNaturais::processaLinha(const std::string &str) {
  // TODO: Implemente este metodo:
  int soma = 0;
  int aux;

  std::istringstream iss(str);

  while (iss >> aux)
  {
      soma += aux;
  }

  std::cout << soma << std::endl;
}

bool LeitorDeFutebol::linhaValida(const std::string &str) const {
  // TODO: Implemente este metodo
  std::regex regularExpr("\\s*\\w+\\s*\\d+\\s*\\w+\\s*\\d+\\s*");
    
  return std::regex_match(str, regularExpr);
}

void LeitorDeFutebol::processaLinha(const std::string &str) {
  // TODO: Implemente este metodo:
  char c = str[0];
  int i = 1;
  std::string time1, aux;
  std::string time2, aux2;
  std::string vencedor;

  while(c == ' '){
    c = str[i++];
  }
  
//   if(i > 1) c = str[i++];

  while(c != ' '){
    time1 += c;
    c = str[i++];
  }

  while(c == ' '){
    c = str[i++];
  }

  while(c != ' '){
    aux += c;
    c = str[i++];
  }

  while(c == ' '){
    c = str[i++];
  }

  int gols1 = std::stoi(aux);

  while(c != ' '){
    time2 += c;
    c = str[i++];
  }

  while(c == ' '){
    c = str[i++];
  }

  while(c != ' '){
    aux2 += c;
    c = str[i++];
  }

  int gols2 = std::stoi(aux2);

  if(gols1 > gols2) vencedor = "Vencedor: " + time1;
  else if(gols2 > gols1) vencedor = "Vencedor: " + time2;
  else vencedor = "Empate";

  std::cout << vencedor << std::endl;
}

void ContadorDePalavras::processaLinha(const std::string &str) {
  // TODO: Implemente este metodo:
  int cont = 0;
  std::string aux;
  std::istringstream iss(str);

  while (iss >> aux){
    cont++;
  }
  // for(auto c : str){
  //   if(c == ' ') cont++;
  // }
  // cont++;
  std::cout << cont << std::endl;
}

bool InversorDeFrases::linhaValida(const std::string &str) const {
  // TODO: Implemente este metodo
  for(auto const& c : str){
    if(!isalpha(c) && c != ' ') return false;
  }
  return true;
}

void InversorDeFrases::processaLinha(const std::string &str) {
  // TODO: Implemente este metodo:
  std::list<std::string> palavras;
  std::string aux;
  for(auto const& c : str){
    if(c == ' '){
      palavras.push_front(aux);
      aux = "";
    }else{
      aux += c;
    }
  }
  
  palavras.push_front(aux);\

  for(auto const& palavra : palavras){
    std::cout << palavra << " ";
  }
  std::cout << std::endl;
}

bool EscritorDeDatas::linhaValida(const std::string &str) const {
  std::string dateFormat = "\\s*\\d\\d?/\\d\\d?/\\d{4}";
  std::regex expression(dateFormat);
  // TODO: Implemente este metodo
  // Note que você pode usar uma expressao regular como:
  // "\\s*\\d\\d?/\\d\\d?/\\d{4}" para saber se a linha eh valida:
  return std::regex_match(str, expression);
}

void EscritorDeDatas::processaLinha(const std::string &str) {
  // TODO: Implemente este metodo:
  // Lembre-se que as iniciais dos meses sao:
  // "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out",
  // "Nov", e "Dez".
  std::string mes;
  std::string iniciaisMes;
  for(int i = 0; i < str.length(); i++){
    if(str[i] == '/'){
      if(str[i + 1] == '0'){
        mes = str.substr(i + 2, 1);
      }else if(str[i + 1] == '1' && str[i + 2] != '/'){
        mes = str.substr(i + 1, 2);
      }else{
        mes = str.substr(i + 1, 1);
      }

      if(mes == "1") iniciaisMes = "Jan";
      else if(mes == "2") iniciaisMes = "Fev";
      else if(mes == "3") iniciaisMes = "Mar";
      else if(mes == "4") iniciaisMes = "Abr";
      else if(mes == "5") iniciaisMes = "Mai";
      else if(mes == "6") iniciaisMes = "Jun";
      else if(mes == "7") iniciaisMes = "Jul";
      else if(mes == "8") iniciaisMes = "Ago";
      else if(mes == "9") iniciaisMes = "Set";
      else if(mes == "10") iniciaisMes = "Out";
      else if(mes == "11") iniciaisMes = "Nov";
      else if(mes == "12") iniciaisMes = "Dez";

      break;   
    }
  }
  std::cout << iniciaisMes << std::endl;
}