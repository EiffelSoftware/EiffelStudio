/*
 * TESTDESC.C
 *
 * DLL source code
 */

#ifndef _INC_WINDOWS
#	define STRICT
#	include <windows.h>
#endif
#include <stdio.h>

_declspec (dllexport)
LONG Sum (LPCSTR Str, LONG Values[], int Count)
{
	/* Cumputes the sum of `Values'. `Count' is the number of elements. */

	int i;
	LONG Total;

	MessageBox (NULL, Str, "In Sum (TESTDESC.DLL)", MB_OK);

	Total = 0;
	for (i = 0; i < Count; i++)
		Total += Values [i];

	MessageBeep (MB_OK);
	return Total;
}

_declspec (dllexport)
LPSTR EiffelString (void)
{
	return "Eiffel";
}

__declspec(dllexport) 
void input (int a, int b ,int c)
{
	char buf [100];
	sprintf (buf, "%d + %d + %d = %d", a,b,c, a+b+c);
	MessageBox (NULL, buf, "DLL Message", MB_OK);
}

__declspec(dllexport) 
int output (int a,int b)
{
	char buf [100];

	sprintf (buf, "%d %d", a,b);
	MessageBox (NULL, buf, "DLL Message", MB_OK);
	return a * 10 + b;
}

__declspec(dllexport) 
double double_function (double a, double b)
{
	char buf [100];

	sprintf (buf, "%f %f", a, b);
	MessageBox (NULL, buf, "DLL Message", MB_OK);

	return a * b;
}

__declspec(dllexport) 
float float_function (float a, float b)
{
	char buf [100];
	double da, db;

	da = a;
	db = b;
	sprintf (buf, "floats to doubles%f %f", da, db);
	MessageBox (NULL, buf, "DLL Message", MB_OK);

	return a * b;
}

