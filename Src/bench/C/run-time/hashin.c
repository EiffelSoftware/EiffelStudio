/*

 #    #    ##     ####   #    #     #    #    #           ####
 #    #   #  #   #       #    #     #    ##   #          #    #
 ######  #    #   ####   ######     #    # #  #          #
 #    #  ######       #  #    #     #    #  # #   ###    #
 #    #  #    #  #    #  #    #     #    #   ##   ###    #    #
 #    #  #    #   ####   #    #     #    #    #   ###     ####

	Hash table handling (indexed by integer keys).
*/

#include "config.h"
#include "tools.h"
#include "hashin.h"
#include "malloc.h"
#include "except.h"	/* for panic() */

#ifdef I_STRING
#include <string.h>		/* For memset(), bzero() */
#else
#include <strings.h>
#endif

#ifndef lint
private char *rcsid =
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
 */

public int ht_create(ht, n, sval)
struct htable *ht;
int32 n;
int sval;
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

	array = calloc(hsize, sizeof(long));	/* Mallocs array of keys */
	if (array == (char *) 0)
		return -1;					/* Malloc failed */
	ht->h_keys = (unsigned long *) array;		/* Where array of keys is stored */

	array = malloc(hsize * sval);			/* Mallocs array of values */
	if (array == (char *) 0) {
		free(ht->h_keys);			/* Free keys array */
		return -1;					/* Malloc failed */
	}
	ht->h_values = array;			/* Where array of keys is stored */

	ht->h_size = hsize;				/* Size of hash table */
	ht->h_sval = sval;				/* Size of each stored item */

	return 0;			/* Creation was ok */
}

public void ht_zero(ht)
struct htable *ht;
{
	/* Initialize the hash table with zeros */

	int32 hsize = ht->h_size;

	bzero(ht->h_keys, hsize * sizeof(long));
	bzero(ht->h_values, hsize * ht->h_sval);
}
 
public char *ht_value(ht, key)
struct htable *ht;
register1 unsigned long key;
{
	/* Look for item associated with given key and returns a pointer to its
	 * location in the value array. Return a null pointer if item is not found.
	 */
	
	register2 long pos;		/* Position in H table */
	register3 int32 hsize;		/* Size of H table */
	register4 unsigned long *hkeys;		/* Array of keys */
	register5 int32 try = 0;	/* Count number of attempts */
	register6 long inc;		/* Loop increment */

	/* Initializations */
	hsize = ht->h_size;
	hkeys = ht->h_keys;

	/* Jump from one hashed position to another until we find the value or
	 * go to an empty entry or reached the end of the table.
	 */
	inc = 1 + (key % (hsize - 1));
	for (pos = key % hsize; try < hsize; try++, pos = (pos + inc) % hsize) {
		if (hkeys[pos] == key)
			return ht->h_values + (pos * ht->h_sval);
		else if (hkeys[pos] == 0L)
			break;
	}

	return (char *) 0;			/* Item was not found */
}

public char *ht_first(ht, key)
struct htable *ht;
register1 unsigned long key;
{
	/* Retrun first available item address where key is present or should
	 * be. In case there is no more room, return a null pointer.
	 */

	register2 long pos;		/* Position in H table */
	register3 int32 hsize;	  	/* Size of H table */
	register4 unsigned long *hkeys;	 	/* Array of keys */
	register5 int32 try = 0;	/* Count number of attempts */
	register6 long inc;		/* Loop increment */
	register7 unsigned long other_key;

	/* Initializations */
	hsize = ht->h_size;
	hkeys = ht->h_keys;

	/* Jump from one hashed position to another until we find the value or
	* go to an empty entry or reached the end of the table.
	 */
	inc = 1 + (key % (hsize - 1));
	for (pos = key % hsize; try < hsize; try++, pos = (pos + inc) % hsize) {
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

public char *ht_put(ht, key, val)
struct htable *ht;
register1 unsigned long key;
char *val;
{
	/* Puts value held at 'val' tagged with key 'key' in H table 'ht'. If
	 * insertion was successful, the address of the value is returned and the
	 * value is copied in the array. Otherwise, return a null pointer.
	 */

	register2 long pos;		/* Position in H table */
	register3 int32 hsize;		/* Size of H table */
	register4 unsigned long *hkeys;		/* Array of keys */
	register5 int32 try = 0;	/* Records number of attempts */
	register6 long inc;		/* Loop increment */

	/* Initializations */
	hsize = ht->h_size;
	hkeys = ht->h_keys;

	/* Jump from one hashed position to another until we find a free entry or
	 * we reached the end of the table.
	 */
	inc = 1 + (key % (hsize - 1));
	for (pos = key % hsize; try < hsize; try++, pos = (pos + inc) % hsize) {
#ifdef MAY_PANIC
		if (hkeys[pos] == key)
			panic("H table key conflict");
		else
#endif
		if (hkeys[pos] == 0) {			/* Found a free location */
			hkeys[pos] = key;			/* Record item */
			hkeys = (unsigned long *) (ht->h_values + (pos * ht->h_sval));
			bcopy(val, (char *) hkeys, ht->h_sval);
			return (char *) hkeys;
		}
	}

	return (char *) 0;		/* We were unable to insert item */
}

public int ht_xtend(ht)
struct htable *ht;
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
			free(new_ht.h_values);	/* Free new H table */
			free(new_ht.h_keys);
			panic("cannot extend H table");
		}
#else
		(void) ht_put(&new_ht, *key, val);
#endif

	/* Free old H table and set H table descriptor */
	free(ht->h_values);			/* Free in allocation order */
	free(ht->h_keys);				/* To make free happy (coalescing) */
	bcopy(&new_ht, ht, sizeof(struct htable));

	return 0;		/* Extension was ok */
}

public void ht_free(ht)
struct htable *ht;
{
	/* Free hash table arrays and descriptor */

	free(ht->h_values);
	free(ht->h_keys);
	xfree(ht);
}

