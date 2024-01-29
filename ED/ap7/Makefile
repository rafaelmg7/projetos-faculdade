#---------------------------------------------------------------------
# Arquivo	: Makefile
# Conteúdo	: compilar o programa vetop
# Autor		: Wagner Meira Jr. (meira@dcc.ufmg.br)
# Histórico	: 2022-04-02 - arquivo criado
#---------------------------------------------------------------------
# Opções	: make all - compila tudo
#		: make clean - remove objetos e executável
#---------------------------------------------------------------------

CC = gcc
LIBS = -lm
SRC = src
OBJ = obj
INC = include
BIN = bin
OBJS = $(OBJ)/vetop.o $(OBJ)/vet.o 
HDRS = $(INC)/vet.h $(INC)/msgassert.h
CFLAGS = -Wall -c -I$(INC)

EXE = $(BIN)/vetop

run: all

all:  $(EXE)
	$(EXE) -i 100 -f 100000 -t 10 -e

$(BIN)/vetop: $(OBJS)
	$(CC) -g -o $(BIN)/vetop $(OBJS) $(LIBS)

$(OBJ)/vetop.o: $(HDRS) $(SRC)/vetop.c
	$(CC) $(CFLAGS) -o $(OBJ)/vetop.o $(SRC)/vetop.c 

$(OBJ)/vet.o: $(HDRS) $(SRC)/vet.c
	$(CC) $(CFLAGS) -o $(OBJ)/vet.o $(SRC)/vet.c 
	
clean:
	rm -f $(EXE) $(OBJS) gmon.out teste.csv
