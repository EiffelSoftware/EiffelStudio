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

#ifndef lint
private char *rcsid =
	"$Id$";
#endif

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

	array = xcalloc(hsize, sizeof(int32));	/* Mallocs array of keys */
	if (array == (char *) 0)
		return -1;					/* Malloc failed */
	ht->h_keys = (int *) array;		/* Where array of keys is stored */

	array = cmalloc(hsize * sval);			/* Mallocs array of values */
	if (array == (char *) 0) {
		xfree(ht->h_keys);			/* Free keys array */
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

	bzero(ht->h_keys, hsize * sizeof(int32));
	bzero(ht->h_values, hsize * ht->h_sval);
}
 
public char *ht_value(ht, key)
struct htable *ht;
register1 int32 key;
{
	/* Look for item associated with given key and returns a pointer to its
	 * location in the value array. Return a null pointer if item is not found.
	 */
	
	register2 int32 pos;		/* Position in H table */
	register3 int32 hsize;		/* Size of H table */
	register4 int32 *hkeys;		/* Array of keys */
	register5 int32 try = 0;	/* Count number of attempts */
	register6 int32 inc;		/* Loop increment */

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
		else if (hkeys[pos] == 0)
			break;
	}

	return (char *) 0;			/* Item was not found */
}

public char *ht_first(ht, key)
struct htable *ht;
register1 int32 key;
{
	/* Retrun first available item address where key is present or should
	 * be. In case there is no more room, return a null pointer.
	 */

	register2 int32 pos;		/* Position in H table */
	register3 int32 hsize;	  	/* Size of H table */
	register4 int32 *hkeys;	 	/* Array of keys */
	register5 int32 try = 0;	/* Count number of attempts */
	register6 int32 inc;		/* Loop increment */
	register7 int32 other_key;

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
register1 int32 key;
char *val;
{
	/* Puts value held at 'val' tagged with key 'key' in H table 'ht'. If
	 * insertion was successful, the address of the value is returned and the
	 * value is copied in the array. Otherwise, return a null pointer.
	 */

	register2 int32 pos;		/* Position in H table */
	register3 int32 hsize;		/* Size of H table */
	register4 int32 *hkeys;		/* Array of keys */
	register5 int32 try = 0;	/* Records number of attempts */
	register6 int32 inc;		/* Loop increment */

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
			hkeys = (int *) (ht->h_values + (pos * ht->h_sval));
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
	register3 int32 *key;			/* To loop over keys */
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
			xfree(new_ht.h_values);	/* Free new H table */
			xfree(new_ht.h_keys);
			panic("cannot extend H table");
		}
#else
		(void) ht_put(&new_ht, *key, val);
#endif

	/* Free old H table and set H table descriptor */
	xfree(ht->h_values);			/* Free in allocation order */
	xfree(ht->h_keys);				/* To make free happy (coalescing) */
	bcopy(&new_ht, ht, sizeof(struct htable));

	return 0;		/* Extension was ok */
}

public void ht_free(ht)
struct htable *ht;
{
	/* Free hash table arrays and descriptor */

	xfree(ht->h_values);
	xfree(ht->h_keys);
	xfree(ht);
}

