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
#include "store.h"
#include "error.h"

#ifdef EIF_OS2
#include <io.h>
#endif

char *partial_retrieve(f_desc, position, nb_obj)
EIF_INTEGER f_desc;
long position, nb_obj;
{
	/* Return `nb_obj' retrieved in file `file_ptr' read at `position'. */
	char *result;

	rt_init_retrieve(old_retrieve_read_with_compression, 0);

	rt_kind = '\0';
	r_fides = (int)f_desc;
	r_fstoretype = 'F';
	if (lseek(r_fides, position, SEEK_SET) == -1) esys();	/* bail out */
	allocate_gen_buffer();
	result = rt_nmake(nb_obj);			/* Retrieve `nb_obj' objects */
	ht_free(rt_table);                  /* Free hash table descriptor */
    epop(&hec_stack, nb_recorded);      /* Pop hector records */

	rt_reset_retrieve();

	return result;
}

char *retrieve_all(f_desc, position)
EIF_INTEGER f_desc;
long position;
{
	/* Return object graph retrieved in file `file_ptr' read at
	 * position. */
	char *result;

	rt_init_retrieve(old_retrieve_read_with_compression, 0);

	rt_kind = '\0';
	r_fides = (int)f_desc;
	r_fstoretype = 'F';
	if (lseek(r_fides, position, SEEK_SET) == -1) esys();	/* bail out */
	allocate_gen_buffer();
	result = rt_make();
	ht_free(rt_table);					/* Free hash table descriptor */
	epop(&hec_stack, nb_recorded);		/* Pop hector records */

	rt_reset_retrieve();

	return result;
}
