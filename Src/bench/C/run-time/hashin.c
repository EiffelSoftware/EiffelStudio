/*

 #    #    ##     ####   #    #     #    #    #           ####
 #    #   #  #   #       #    #     #    ##   #          #    #
 ######  #    #   ####   ######     #    # #  #          #
 #    #  ######       #  #    #     #    #  # #   ###    #
 #    #  #    #  #    #  #    #     #    #   ##   ###    #    #
 #    #  #    #   ####   #    #     #    #    #   ###     ####

	Hash table handling (indexed by integer keys).
*/

#include "eif_portable.h"
#include "eif_tools.h"
#include "eif_hashin.h"
#include "eif_malloc.h"
#include "eif_lmalloc.h"    /* for eif_calloc, eif_malloc, eif_free */
#include "eif_except.h"	/* for eif_panic() */

#include <string.h>		/* For memset(), bzero() */

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

rt_public int ht_create(struct htable *ht, int32 n, int sval)
{
	/* Creates an H table to hold 'n' items with descriptor held in 'ht'. The
	 * size of the table is optimized to avoid conflicts and is of course a
	 * prime number. We take the first prime after (5 * n / 4). The 'sval'
	 * parameter gives the size of the structure used to store the value.
	 * The function returns 0 if everything was ok, -1 otherwise.
	 */

	int32 hsize;		/* Size of created table */
	char *array;		/* For array creation (keys/values) */
	
	hsize = nprime((5 * n) / 4);	/* Table's size */

	array = (char *) eif_calloc(hsize, sizeof(long));	/* Mallocs array of keys */
	if (array == (char *) 0)
		return -1;					/* Malloc failed */
	ht->h_keys = (unsigned long *) array;		/* Where array of keys is stored */

	array = (char *) eif_malloc(hsize * sval);			/* Mallocs array of values */
	if (array == (char *) 0) {
		eif_free(ht->h_keys);			/* Free keys array */
		return -1;					/* Malloc failed */
	}
	ht->h_values = array;			/* Where array of keys is stored */

	ht->h_size = hsize;				/* Size of hash table */
	ht->h_sval = sval;				/* Size of each stored item */

	return 0;			/* Creation was ok */
}

rt_public void ht_zero(struct htable *ht)
{
	/* Initialize the hash table with zeros */

	int32 hsize = ht->h_size;

	memset (ht->h_keys, 0, hsize * sizeof(long));
	memset (ht->h_values, 0, hsize * ht->h_sval);
}
 
rt_public char *ht_value(struct htable *ht, register long unsigned int key)
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
			return ht->h_values + (pos * ht->h_sval);
		else if (hkeys[pos] == 0L)
			break;
	}

	return (char *) 0;			/* Item was not found */
}

rt_public char *ht_first(struct htable *ht, register long unsigned int key)
{
	/* Retrun first available item address where key is present or should
	 * be. In case there is no more room, return a null pointer.
	 */

	register2 long pos;		/* Position in H table */
	register3 int32 hsize;	  	/* Size of H table */
	register4 unsigned long *hkeys;	 	/* Array of keys */
	register5 int32 tmp_try = 0;	/* Count number of attempts */
	register6 long inc;		/* Loop increment */
	register7 unsigned long other_key;

	/* Initializations */
	hsize = ht->h_size;
	hkeys = ht->h_keys;

	/* Jump from one hashed position to another until we find the value or
	* go to an empty entry or reached the end of the table.
	 */
	inc = 1 + (key % (hsize - 1));
	for (pos = key % hsize; tmp_try < hsize; tmp_try++, pos = (pos + inc) % hsize) {
		other_key = hkeys[pos];
		
		if (other_key == key)
			return ht->h_values + (pos * ht->h_sval);
		else if (other_key == 0) {
			hkeys[pos] = key;
			return ht->h_values + (pos * ht->h_sval);
		}

	}

	return (char *) 0;		  /* Item was not found */
}

void ht_force(struct htable *ht, register long unsigned int key, char *val)
{
	/* Tries to put value held at 'val' tagged with key 'key' in H table
	 * 'ht'. If the first put fails, the H table 'ht' is extended and
	 * we try another put. If that fails we raise an exception.
	 * When everything is alright, we return to the callee.
	 */

	if (!(ht_put(ht, key, val))) {		/* Insertion failed => H table full */
		if (ht_xtend(ht))		/* Extend the H table */
			eraise("Hashtable extension failure", EN_FATAL);
				/* Something (...) was wrotten, don't know what */
		if (!(ht_put(ht, key, val))) 	/* Insertion failed again => Bailing out */
			eraise("Hash table insertion failure", EN_FATAL);
	}
}

rt_public char *ht_put(struct htable *ht, register long unsigned int key, char *val)
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
#ifdef MAY_PANIC
		if (hkeys[pos] == key)
			eif_panic("H table key conflict");
		else
#endif
		if (hkeys[pos] == 0) {			/* Found a free location */
			hkeys[pos] = key;			/* Record item */
			hkeys = (unsigned long *) (ht->h_values + (pos * ht->h_sval));
			memcpy ((char *) hkeys, val, ht->h_sval);
			return (char *) hkeys;
		}
	}

	return (char *) 0;		/* We were unable to insert item */
}

rt_public void ht_remove(struct htable *ht, register long unsigned int key)
{
	/* Remove item and key 'key' from H table 'ht'.
	 * If 'key' does not exist, nothing will be done.
	 * If 'key' does exist, both the 'h_keys' and the 'h_values' will be zero-d at the appropriate place.
	 * NOTE: If one has a pointer in the structure, he/she is responsible for free-ing that
	 *	 part of memory, by first using 'ht_value' and free the memory and thereafter 'ht_remove' the item from the
	 *	 H table.
	 *	 This means too that if 'ht_value' can not find the value, you will not have to call 'ht_remove' (he he).
	 *	 -- GLJ
	 */

	register2 long pos;		/* Position in H table */
	register3 int32 hsize;		/* Size of H table */
	register4 unsigned long *hkeys;		/* Array of keys */
	register5 int32 tmp_try = 0;	/* Records number of attempts */
	register6 long inc;		/* Loop increment */

	/* Initializations */
	hsize = ht->h_size;
	hkeys = ht->h_keys;

	/* Jump from one hashed position to another until we find a free entry or
	 * we reached the end of the table.
	 */
	inc = 1 + (key % (hsize - 1));
	for (pos = key % hsize; tmp_try < hsize; tmp_try++, pos = (pos + inc) % hsize) {
		if (hkeys[pos] == key) {
			hkeys[pos] = 0L;
			memset (ht->h_values + (pos * ht->h_sval), 0, ht->h_sval);
		} else
			if (hkeys[pos] == 0L)
				break;
	}
}

rt_public int ht_xtend(struct htable *ht)
{
	/* The H table 'ht' is full and needs resizing. We add 50% of old size and
	 * copy the old table in the new one, before freeing the old one. Note that
	 * h_create multiplies the number we give by 5/4, so 5/4*3/2 yields ~2, i.e.
	 * the final size will be the double of the previous one (modulo next prime
	 * number).
	 * Return 0 if extension was ok, -1 otherwise.
	 */

	register1 int size;				/* Size of old H table */
	register2 int sval;				/* Size of an H table item */
	register3 unsigned long *key;			/* To loop over keys */
	register4 char *val;			/* To loop over values */
	struct htable new_ht;

	size = ht->h_size;
	sval = ht->h_sval;
	if (-1 == ht_create(&new_ht, size + (size / 2), sval))
		return -1;		/* Extension of H table failed */

	key = ht->h_keys;				/* Start of array of keys */
	val = ht->h_values;				/* Start of array of values */

	/* Now loop over the whole table, inserting each item in the new one */

	for (; size > 0; size--, key++, val += sval)
#ifdef MAY_PANIC
		if ((char *) 0 == ht_put(&new_ht, *key, val)) {	/* Failed */
			eif_free(new_ht.h_values);	/* Free new H table */
			eif_free(new_ht.h_keys);
			eif_panic("cannot extend H table");
		}
#else
		(void) ht_put(&new_ht, *key, val);
#endif

	/* Free old H table and set H table descriptor */
	eif_free(ht->h_values);			/* Free in allocation order */
	eif_free(ht->h_keys);				/* To make free happy (coalescing) */
	memcpy (ht, &new_ht, sizeof(struct htable));

	return 0;		/* Extension was ok */
}

rt_public void ht_free(struct htable *ht)
{
	/* Free hash table arrays and descriptor */

	eif_free(ht->h_values);
	eif_free(ht->h_keys);
	xfree((char *) ht);
}

