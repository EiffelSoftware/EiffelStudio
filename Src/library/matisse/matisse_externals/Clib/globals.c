#include <stdio.h>
#include "matisse_eif.h"

FILE *traceout = NULL;

void eifmts_trace (char* msg) {
    if ( !traceout )
        traceout = fopen ("C:/EifMTS.LOG", "w");
	else
		traceout = fopen ("C:/EifMTS.LOG", "a");
    if ( !traceout || !msg )
        return;
    fprintf (traceout, msg);
    fflush (traceout);
	fclose(traceout);
}
