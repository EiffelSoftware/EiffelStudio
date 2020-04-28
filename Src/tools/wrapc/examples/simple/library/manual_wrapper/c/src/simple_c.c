
#include "simple_header.h"
#include <stdio.h>

void func1 (int a, int b)
{
  // printf works only in SE AFAIK
  printf ("func1 called\n");
}

int func2 (int a, int b)
{
  return a + b;
}

