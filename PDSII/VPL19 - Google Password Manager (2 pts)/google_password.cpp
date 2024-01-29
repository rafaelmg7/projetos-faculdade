#include "google_password.h"

#include <iostream>

void GooglePassword::insert(const std::string& url,
                            const std::string& login,
                            const std::string& password) {
  if(validPassword(password)){
    if(passwords_.count(url) == 0){
      Usuario novo = {login, password};
      passwords_[url] = novo;
    }
  }
}

void GooglePassword::remove(const std::string& url) {
  passwords_.erase(url);
}


void GooglePassword::update(const std::string& url,
                            const std::string& login,
                            const std::string& old_password,
                            const std::string& new_password) {
  if(validPassword(new_password)){
    if(passwords_.count(url) == 1){
      if(passwords_[url].password == old_password){
        passwords_[url].login = login;
        passwords_[url].password = new_password;
      }
    }
  }
}

void GooglePassword::printPasswords() {
  std::cout << passwords_.size() << std::endl;
  for(auto crendencial : passwords_){
    std::cout << crendencial.first << ": " << crendencial.second.login << " and " << crendencial.second.password << std::endl;
  }
}

bool GooglePassword::validPassword(const std::string& password) const {
  if(password.find("123456") == string::npos){
    if(password.size() >= 6 && password.size() <= 50){
      if(password.find(' ') == string::npos){
        return true;
      }
    }
  }
  return false;
}

