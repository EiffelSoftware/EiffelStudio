#include <stdio.h>
#include "fext.h"

void c_printf (EIF_POINTER ptr) {
	printf ("\nHere is the C string: \n");
	printf ("%s\n", (char *) ptr);
}

