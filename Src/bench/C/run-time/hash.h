/*

 #    #    ##     ####   #    #          #    #
 #    #   #  #   #       #    #          #    #
 ######  #    #   ####   ######          ######
 #    #  ######       #  #    #   ###    #    #
 #    #  #    #  #    #  #    #   ###    #    #
 #    #  #    #   ####   #    #   ###    #    #

	Include file for hash table.
*/

#ifndef _hash_h_
#define _hash_h_

#ifdef __cplusplus
extern "C" {
#endif

struct hash {				/* Hashing table pointer -> EIF_OBJ */
	int h_size;				/* Size of the hash table */
	char **h_key;			/* Keys array */
	char **h_entry;			/* Entries array */
};

extern char **hash_search();		/* Search in hash table */
extern void hash_free();			/* Free allocated table */
extern void hash_malloc();			/* Table allocation */

#ifdef __cplusplus
}
#endif

#endif

