/*

 #    #    ##     ####   #    #          #    #
 #    #   #  #   #       #    #          #    #
 ######  #    #   ####   ######          ######
 #    #  ######       #  #    #   ###    #    #
 #    #  #    #  #    #  #    #   ###    #    #
 #    #  #    #   ####   #    #   ###    #    #

	Include file for hash table.
*/

#ifndef _eif_hash_h_
#define _eif_hash_h_

#ifdef __cplusplus
extern "C" {
#endif

struct hash {				/* Hashing table pointer -> EIF_OBJECT */
	int h_size;				/* Size of the hash table */
	char **h_key;			/* Keys array */
	char **h_entry;			/* Entries array */
};

extern char **hash_search(struct hash *hp, register char *object);		/* Search in hash table */
extern void hash_free(struct hash *hp);			/* Free allocated table */
extern void hash_malloc(struct hash *hp, register long int size);			/* Table allocation */

#ifdef __cplusplus
}
#endif

#endif

