#include <stdio.h>
#include "fext.h"

void c_print (EIF_POINTER ptr) {
	int i;

	for (i = 0; i < 10; i++) {
		printf ("@%d = %ld\n", i+1, (EIF_INTEGER) *((EIF_INTEGER *)ptr+i));
	}

}

