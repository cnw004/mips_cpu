/*
Program: fibonacci.c
Author: Alan Marchiori, Colin Heinzmann, Gilbert Kim
Description: Computes the 5th fibonacci number and prints it out
Expected output:
------
5
------
*/

#include "lib/lib.h"

int fibonacci(int n)
{
   if ( n == 0 )
      return 0;
   else if ( n == 1 )
      return 1;
   else
      return ( fibonacci(n-1) + fibonacci(n-2) );
}

int main(void) {
   int x = fibonacci(5);
   puts(itoa(x));
}
