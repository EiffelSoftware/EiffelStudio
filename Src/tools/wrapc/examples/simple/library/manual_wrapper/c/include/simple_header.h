#ifndef __EWG_SIMPLE_HEADER__
#define __EWG_SIMPLE_HEADER__

typedef union
{
  int a;
} foo1;

typedef enum
{
  red,
  blue,
  green
} colors;

struct preferences {
	const char * food;
	int a;
};

struct person {
	const char * name;
	int age;
	struct preferences pref;
};

struct foo
{
  int a,b,*pc;
};


void func1 (int a, int b);

int func2 (int a, int b);

#endif
