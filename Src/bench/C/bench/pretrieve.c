/*

 #####   #####   ######   #####  #####      #    ######  #    #  ######
 #    #  #    #  #          #    #    #     #    #       #    #  #
 #    #  #    #  #####      #    #    #     #    #####   #    #  #####
 #####   #####   #          #    #####      #    #       #    #  #        ###
 #       #   #   #          #    #   #      #    #        #  #   #        ###
 #       #    #  ######     #    #    #     #    ######    ##    ######   ###

	Partial retrieve mechanism
*/

#include "portable.h"
#include "macros.h"
#include "malloc.h"
#include "garcol.h"
#include "retrieve.h"

char *partial_retrieve(file_ptr, position, nb_obj)
FILE *file_ptr;
long position, nb_obj;
{
	/* Return `nb_obj' retrieved in file `file_ptr' read at `position'. */
	char *result;

	rt_kind = '\0';
	rt_file = file_ptr;
	fseek(rt_file, position, 0);
	result = rt_nmake(nb_obj);			/* Retrieve `nb_obj' objects */
	ht_free(rt_table);                  /* Free hash table descriptor */
    epop(&hec_stack, nb_recorded);      /* Pop hector records */

	return result;
}

char *retrieve_all(file_ptr, position)
FILE *file_ptr;
long position;
{
	/* Return object graph retrieved in file `file_ptr' read at
	 * position. */
	char *result;

	rt_kind = '\0';
	rt_file = file_ptr;
	fseek(rt_file, position, 0);
	result = rt_make();
	ht_free(rt_table);					/* Free hash table descriptor */
	epop(&hec_stack, nb_recorded);		/* Pop hector records */

	return result;
}
