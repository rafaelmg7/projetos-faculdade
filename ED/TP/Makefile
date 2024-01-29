#---------------------------------------------------------------------
# Arquivo	: Makefile
# Conteúdo	: compilar o programa main
# Autor		: Rafael Martins Gomes
# Histórico	: 2023-04-25 - arquivo criado
#---------------------------------------------------------------------
# Opções	: make all - compila tudo
#		: make clean - remove objetos e executável
#---------------------------------------------------------------------

CC = g++
LIBS = -lm
SRC = src
OBJ = obj
INC = include
BIN = bin
ENT = entdouble
OBJS = $(OBJ)/main.o $(OBJ)/leitura.o $(OBJ)/tree.o
HDRS = $(INC)/item.hpp $(INC)/stack.hpp $(INC)/leitura.hpp $(INC)/tree.hpp $(INC)/tree.hpp
CFLAGS = -Wall -c -I $(INC)

EXE = $(BIN)/main

all: run

run: $(EXE)
	$(EXE) < entrada.in

$(BIN)/main: $(OBJS)
	$(CC) -pg -g -o $(BIN)/main $(OBJS) $(LIBS)

$(OBJ)/main.o: $(HDRS) $(SRC)/main.cpp
	$(CC) $(CFLAGS) -o $(OBJ)/main.o $(SRC)/main.cpp

$(OBJ)/leitura.o: $(HDRS) $(SRC)/leitura.cpp
	$(CC) $(CFLAGS) -o $(OBJ)/leitura.o $(SRC)/leitura.cpp

$(OBJ)/tree.o: $(HDRS) $(SRC)/tree.cpp
	$(CC) $(CFLAGS) -o $(OBJ)/tree.o $(SRC)/tree.cpp

clean:
	rm -f $(EXE) $(OBJS) gmon.out