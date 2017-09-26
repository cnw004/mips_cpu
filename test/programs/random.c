/*
Program: random.c
Author: Alan Marchiori, Colin Heinzmann, Gilbert Kim
Description: Computes a random number
Expected output:
------

-----
*/

#include "lib/lib.h"

int random(int a, int c, int m, int x_n) {
  return ((a * x_n) + c) % m;
}

int randomTop(int a, int c, int m, int x_0, int n) {
  int result = x_0;
  for (int i = 1; i < n; i++) {
    result = random(a, c, m, result);
  }
  return result;
}

int main(void) {
  int start = 13;
  int x = randomTop(3, 21, 100, 42, start);
  puts(itoa(x));
}
