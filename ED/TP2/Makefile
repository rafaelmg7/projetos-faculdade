#---------------------------------------------------------------------
# Arquivo	: Makefile
# Conteúdo	: compilar o programa main
# Autor		: Rafael Martins Gomes
# Histórico	: 2023-06-09 - arquivo criado
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
OBJS = $(OBJ)/main.o $(OBJ)/convexHull.o
HDRS = $(INC)/item.hpp $(INC)/stack.hpp $(INC)/point.hpp $(INC)/convexHull.hpp
CFLAGS = -Wall -c -I $(INC)

EXE = $(BIN)/fecho

ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))

all: run

run: $(EXE)
	$(EXE) $(ARGS)

$(BIN)/fecho: $(OBJS)
	$(CC) -g -o $(BIN)/fecho $(OBJS) $(LIBS)

$(OBJ)/main.o: $(HDRS) $(SRC)/main.cpp
	$(CC) $(CFLAGS) -o $(OBJ)/main.o $(SRC)/main.cpp

$(OBJ)/convexHull.o: $(HDRS) $(SRC)/convexHull.cpp
	$(CC) $(CFLAGS) -o $(OBJ)/convexHull.o $(SRC)/convexHull.cpp

clean:
	rm -f $(EXE) $(OBJS)