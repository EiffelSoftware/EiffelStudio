#include "eif_eiffel.h"
#include "matisse_store.h"

static int *translation_table;

void display ()
{
	int i;
	FILE *output;

	translation_table = (int *) access_current_table ();

	fprintf (stderr, "Current table:\n");
	for (i = 0; i < scount ; i ++)	
	    fprintf (stderr, "%s has this dtype %d but we need to store %d\n", 
	    		System(i).cn_generator, i, translation_table [i]);
}

