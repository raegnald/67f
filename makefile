C ?= cc
CFLAGS = -Wall -Wextra -O3 -std=c99

TARGET = bin/67f

SRC = src/67f.c

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) $(SRC) -o $(TARGET)

clean: rm -f $(TARGET)
