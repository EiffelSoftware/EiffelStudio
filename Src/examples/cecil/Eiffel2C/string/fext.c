#include <stdio.h>
#include "fext.h"

void c_printf (EIF_POINTER ptr) {
	printf ("%s\n", (char *) ptr);
}

