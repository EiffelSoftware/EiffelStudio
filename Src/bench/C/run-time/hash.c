/*

 #    #    ##     ####   #    #           ####
 #    #   #  #   #       #    #          #    #
 ######  #    #   ####   ######          #
 #    #  ######       #  #    #   ###    #
 #    #  #    #  #    #  #    #   ###    #    #
 #    #  #    #   ####   #    #   ###     ####

	Hash table source file.
*/

#include "eif_portable.h"
#include "eif_tools.h"
#include "eif_malloc.h"
#include "eif_hash.h"

/* 
 * Declarations
 */

rt_shared char **hash_search(struct hash *hp, register char *object);	/* Search in the hash table */
rt_shared void hash_free(struct hash *hp);		/* Free the tables */
rt_shared void hash_malloc(struct hash *hp, register long int size);	/* Hash table creation */
/*rt_private void free_entries();*/	/* Free all the hector entries */ /* %%ss undefined not used in run-time */
#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

/* 
 * Function definitions
 */


rt_shared void hash_malloc(struct hash *hp, register long int size)
{
	 /* Initialization of the hash table */

	hp->h_size = nprime(4 * size /3);
	hp->h_key = (char **) xcalloc(hp->h_size, sizeof(char *));
	hp->h_entry = (char **) xcalloc(hp->h_size, sizeof(char *));
}

rt_shared void hash_free(struct hash *hp)
{
	/* Free memory allocated to the tables. */

	xfree((char *) (hp->h_key));			/* Free keys array */
	xfree((char *) (hp->h_entry));			/* Free entries array */
}

rt_shared char **hash_search(struct hash *hp, register char *object)
{
	/* Search in hash table for updating references.
	 * Return a pointer to an entry of `hash_entry' and not the entry itself.
	 */

	register1 long pos;
	register3 char *key;
	register4 int inc;
	register5 unsigned long code = ((unsigned long) object - 1);
	register6 int hash_size = hp->h_size;

	/* Initialization of the position */
	pos = code % hash_size;

	for (inc = 1 + (code % (hash_size - 1));; pos = (pos + inc) % hash_size) {
		key = hp->h_key[pos];
		if (!key) {
			hp->h_key[pos] = object;		/* Not yet in table */
			break;
		} else if (key == object)
			break;							/* No conflict */

	}
	return &hp->h_entry[pos];
}

