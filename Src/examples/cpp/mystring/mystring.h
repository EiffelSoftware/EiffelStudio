#ifndef _MYSTRING_
#define _MYSTRING_

#include <string.h>

class MyString
{
public:
	MyString (char * AString);
	~MyString ();
	char * Value () { return _Value; }
	int Length () { return strlen (_Value); }

private:
	char * _Value;
};

#endif
