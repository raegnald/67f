# 67f
## What's 67f?
67f is a meme language based on Brainf*ck.
It means, 67f is an esoteric programming language, and it can do the same as Brainf*ck, but with 2 extra operators. What you can do in 67f is summarized in this table:
| Operator | Functionality |
|----------|--------------|
| 6 | Increment the pointer by one |
| 7 | Decrement the pointer by one |
| + | Increment the byte at the data pointer by one |
| - | Decrement the byte at the data pointer by one |
| . | Output the byte at the data pointer |
| , | Accept one byte of input, storing its value in the byte at the data pointer |
| [ | If the byte at the data pointer is zero, then instead of moving the instruction pointer forward to the next command, jump it forward to the command after the matching ] command |
| ] | If the byte at the data pointer is nonzero, then instead of moving the instruction pointer forward to the next command, jump it back to the command after the matching [ command |
| 9 | Generates a random value between 0 and 1 |
| ; | Instantly end the program |
| /67 | Marks the beginning of a comment section |
| 67/ | Marks the end of a comment section |

With all these operators, you can make any program you want (if you have the right amount of patience and capability of reading that code). If you want some inspiration, in the directory `test` you have some of them, for example, this is the code of the `67.67` file, that prints 67 (with the \n at the end):
```67f
++++++[6++
+++++++7-]6.+.
6++++++[6++
+++++++7-]6.+.
766++[6+++++7-]6.
```
## How can I use 67f?
First of all, clone the repo in your device using:
```bash
git clone https://github.com/Efrenjs8/67f.git
```
Later, type one of these commands in your terminal, always in the root directory of the repo:
### Linux/MacOS
```bash
make
```
### Windows
```powershell
mkdir bin -ErrorAction SilentlyContinue
gcc -Wall -Wextra -O3 -std=c11 src/67f.c -o bin/67f.exe
```
### Usage
After compilation, a new directory called `bin` will appear in the root directory of the repository containing the 67f interpreter. The syntax of the interpreter is the next one:
#### Linux/MacOS
```bash
./bin/67f path/to/file.67
```
#### Windows
```powershell
.\bin\67f.exe path\to\file.67
```
>[!NOTE]
> All 67f source codes must end with the .67 extension, otherwise the interpreter will not read it.

> [!WARNING]
> **Code Quality Disclaimer:** The source code of this interpreter intentionally implements programming practices you should avoid if you want a good source code. It's done like that to match the meme nature of the language. Do not use this as a reference to make your own code if you want to do the things as they should be done.


