#include "mystring.h"

MyString::MyString (char * AString)
{
	_Value = strdup (AString);
}

MyString::~MyString ()
{
	delete _Value;
}
