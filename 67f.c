#include <stdio.h>
#include <string.h>
#define VEC_LEN 676767
unsigned char memory[VEC_LEN];
int pointer = 0, current = 0;
char program[676767];
int err6(){
  printf("You don't know how to comment? Type /67 ... 67/ and solved.\n");
  return 6767;
}
int main(int argc, char* argv[]) {
  char* fileName = argv[1];
  int length = strlen(fileName);
  if(fileName[length-2] != '6' && fileName[length-1] != '7') {
    printf("Not 67 >:(\n");
    return 6767;
  }
  FILE* f = fopen(fileName, "r");
  int c;
  int i = 0;
  while((c = fgetc(f)) != EOF)
    program[i++] = c;
  program[i] = '\0';
  while (program[current] != '\0') {
    int loop_count;
    char operation = program[current];
    
    switch (operation){
    case '6':
      pointer++;
      current++;
      break;
    case '7':
      int f = 0;
      pointer == 0 ? f = errP() : pointer--;
      current++;
      if(f != 0) return f;
      break;
    case '+':
      memory[pointer]++;
      current++;
      break;
    case '-':
      memory[pointer]--;
      current++;
      break;
    case '.':
      putc(memory[pointer], stdout);
      current++;
      break;
    case ',':
      memory[pointer] = getc(stdin);
      current++;
      break;
    case '[':
      if (memory[pointer] == 0) {
        loop_count = 1;
        while (loop_count > 0) {
          current++;
          if (program[current] == '[') loop_count++;
          else if (program[current] == ']') loop_count--;
          else if (program[current] == '\0') {
            printf("\nError: Corchete '[' no cerrado\n");
	    return 6767;
          }
        }
      }
      current++;
      break;
    case ']':
      if (memory[pointer] != 0) {
        loop_count = 1;
        while (loop_count > 0) {
          current--;
          if (program[current] == ']') loop_count++;
          else if (program[current] == '[') loop_count--;
        }
      }
      current++;
      break;
    default:
      current++;
      break;

    }
  }
  return 67;
}
