/*

 #    #    ##     ####   #    #     #    #    #           ####
 #    #   #  #   #       #    #     #    ##   #          #    #
 ######  #    #   ####   ######     #    # #  #          #
 #    #  ######       #  #    #     #    #  # #   ###    #
 #    #  #    #  #    #  #    #     #    #   ##   ###    #    #
 #    #  #    #   ####   #    #     #    #    #   ###     ####

	Hash table handling (indexed by integer keys).
*/

#include "eif_config.h"
#include "eif_tools.h"
#include "eif_hashinin.h"
#include "eif_malloc.h"
#include "eif_lmalloc.h"    /* for eif_calloc, eif_malloc, eif_free */
#include "eif_except.h"	/* for eif_panic() */

#ifdef I_STRING
#include <string.h>		/* For memset(), bzero() */
#else
#include <strings.h>
#endif

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

/* These routines use malloc and free and not xcalloc, xfree because we
 * want to release the memory taken by the hash table after retrieving
 * the precompiled project (~400k) so that it will be reused by Eiffel
 * objects.
 * The note above is only valid for Windows (and any other implementation
 * that does not redefine malloc and free. If they are redefined, the
 * blocks of memory will be managed the same way.
 * Xavier
 * Note: We renamed malloc/realloc/panic/calloc in eif_malloc, eif_realloc, eif_.. so that
 * to avoid any conflict of names. 
 * Manuelt.
 */

rt_public int store_ht_create(struct store_htable *ht, int32 n, int sval)
{
	/* Creates an H table to hold 'n' items with descriptor held in 'ht'. The
	 * size of the table is optimized to avoid conflicts and is of course a
	 * prime number. We take the first prime after (5 * n / 4). The 'sval'
	 * parameter gives the size of the structure used to store the value.
	 * The function returns 0 if everything was ok, -1 otherwise.
	 */

	int32 hsize;		/* Size of created table */
	int *array;		/* For array creation (keys/values) */
	
	hsize = nprime((5 * n) / 4);	/* Table's size */

	array = (int *) eif_calloc(hsize, sizeof(long));	/* Mallocs array of keys */
	if (array == NULL)
		return -1;					/* Malloc failed */
	ht->h_keys = (unsigned long *) array;		/* Where array of keys is stored */

	array = (int *) eif_malloc(hsize * sval);			/* Mallocs array of values */
	if (array == NULL) {
		eif_free(ht->h_keys);			/* Free keys array */
		return -1;					/* Malloc failed */
	}
	ht->h_values = (int *) array;			/* Where array of keys is stored */

	ht->h_size = hsize;				/* Size of hash table */
	ht->h_sval = sval;				/* Size of each stored item */

	return 0;			/* Creation was ok */
}

rt_public void store_ht_zero(struct store_htable *ht)
{
	/* Initialize the hash table with zeros */

	int32 hsize = ht->h_size;

	memset (ht->h_keys, 0, hsize * sizeof(long));
	memset (ht->h_values, 0, hsize * ht->h_sval);
}
 
rt_public int store_ht_value(struct store_htable *ht, register long unsigned int key)
{
	/* Look for item associated with given key and returns a pointer to its
	 * location in the value array. Return a null pointer if item is not found.
	 */
	
	register2 long pos;		/* Position in H table */
	register3 int32 hsize;		/* Size of H table */
	register4 unsigned long *hkeys;		/* Array of keys */
	register5 int32 tmp_try = 0;	/* Count number of attempts */
	register6 long inc;		/* Loop increment */

	/* Initializations */
	hsize = ht->h_size;
	hkeys = ht->h_keys;

	/* Jump from one hashed position to another until we find the value or
	 * go to an empty entry or reached the end of the table.
	 */
	inc = 1 + (key % (hsize - 1));
	for (pos = key % hsize; tmp_try < hsize; tmp_try++, pos = (pos + inc) % hsize) {
		if (hkeys[pos] == key)
			return ht->h_values[pos];
		else if (hkeys[pos] == 0L)
			break;
	}

	return (int) 0;			/* Item was not found */
}

rt_public int store_ht_put(struct store_htable *ht, register long unsigned int key, int val)
{
	/* Puts value held at 'val' tagged with key 'key' in H table 'ht'. If
	 * insertion was successful, the address of the value is returned and the
	 * value is copied in the array. Otherwise, return a null pointer.
	 */

	register2 long pos;		/* Position in H table */
	register3 int32 hsize;		/* Size of H table */
	register4 unsigned long *hkeys;		/* Array of keys */
	register5 int32 tmp_try = 0;	/* Records number of attempts */
	register6 long inc;		/* Loop increment */

	/* Initializations */
	hsize = ht->h_size;
	hkeys = ht->h_keys;

	/* Jump from one hashed position to another until we find a eif_free entry or
	 * we reached the end of the table.
	 */
	inc = 1 + (key % (hsize - 1));
	for (pos = key % hsize; tmp_try < hsize; tmp_try++, pos = (pos + inc) % hsize) {
		if (hkeys[pos] == 0) {			/* Found a free location */
			hkeys[pos] = key;			/* Record item */
			ht->h_values [pos] = val;
			return val;
		}
	}

	return (int) 0;		/* We were unable to insert item */
}

rt_public void store_ht_free(struct store_htable *ht)
{
	/* Free hash table arrays and descriptor */

	eif_free(ht->h_values);
	eif_free(ht->h_keys);
	xfree((char *) ht);
}


