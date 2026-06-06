#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#define VEC_LEN 676767
unsigned char memory[VEC_LEN] = {0};
int pointer = 0, current = 0;
char program[676767] = {0};
int errP(){
  printf("Error: pointer is zero\n");
  return 6767;
}
int err6(){
  printf("You don't know how to comment? Type /67 ... 67/ and solved.\n");
  return 6767;
}
int errArg(){
  printf("Error. Usage is: ./67f fileName\n");
  return 6767;
}
int main(int argc, char* argv[]) {
  if(argc != 2){
    int e = errArg();
    return e;
  }
  bool cont = true; // For the comment section
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
  fclose(f);
  while (program[current] != '\0') {
    int loop_count;
    char operation = program[current];
    
    switch (operation){
    case '/': {
      current++;
      int e;
      if(program[current] == '6'){
	current++;
	if(program[current] == '7'){
	  current++;
	  cont = true;
	  while(program[current] != '\0' && cont){
	    current++;
	    if(program[current] == '6' && program[current+1] == '7' && program[current+2] == '/') cont = false;
	    }
	  if(cont){
	    e =  err6();
	    return e;
	  } else current+=3;
	} else{
	  e =  err6();
	  return e;
	}
      } else{
	e =  err6();
	return e;
      }
      break;
    }
    case '6':
      pointer++;
      current++;
      break;
    case '7': {
      int f_err = 0;
      pointer == 0 ? f_err = errP() : pointer--;
      current++;
      if(f_err != 0) return f_err;
      break;
    }
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
