/*

 #    #    ##     ####   #    #     #    #    #          #    #
 #    #   #  #   #       #    #     #    ##   #          #    #
 ######  #    #   ####   ######     #    # #  #          ######
 #    #  ######       #  #    #     #    #  # #   ###    #    #
 #    #  #    #  #    #  #    #     #    #   ##   ###    #    #
 #    #  #    #   ####   #    #     #    #    #   ###    #    #

	Declarations for interpreter's hash tables.
*/

#ifndef _hashin_h
#define _hashin_h

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Structure which describes the hash table: array of keys and array of
 * values, along with the table's size and the number of recorded elements.
 */
struct htable {
	int32 h_size;		/* Size of table (prime number) */
	unsigned long *h_keys;		/* Array of keys (integers) */
	int h_sval;			/* Size of each value item, in bytes */
	char *h_values;		/* Array of values (pointer needs casting) */
};

/* Function declaration */
extern int ht_create(struct htable *ht, int32 n, int sval);				/* Create H table */
extern char *ht_value(struct htable *ht, register long unsigned int key);			/* Get value given some key */
extern char *ht_first(struct htable *ht, register long unsigned int key);			/* Get item address */
extern char *ht_put(struct htable *ht, register long unsigned int key, char *val);				/* Insert value in H table */
extern void ht_force(struct htable *ht, register long unsigned int key, char *val);				/* Insert value in H table (extending
									 * hash table if needed) */
extern void ht_remove(struct htable *ht, register long unsigned int key);			/* Remove value in H table */
extern int ht_xtend(struct htable *ht);				/* Extend size of full H table */
extern void ht_zero(struct htable *ht);				/* Initialize H table to zero */
extern void ht_free(struct htable *ht);				/* Free hash table */

#ifdef __cplusplus
}
#endif

#endif
