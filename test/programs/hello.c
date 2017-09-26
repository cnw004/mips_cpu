/*
Program: hello.c
Author: Colin Heinzmann
Description: Prints out hello world using strings located in different
             parts of the data segment.
Expected Program Output:
-----
Hello from global data!
Hello from read only data!
-----
*/

#include "lib/lib.h"

static const char str[] = "Hello from global data!\n";

int main(void)
{
  puts(str);
  puts("Hello from read only data!\n");
}
