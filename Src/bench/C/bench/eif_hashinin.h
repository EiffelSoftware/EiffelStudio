/*

 #    #    ##     ####   #    #     #    #    #          #    #
 #    #   #  #   #       #    #     #    ##   #          #    #
 ######  #    #   ####   ######     #    # #  #          ######
 #    #  ######       #  #    #     #    #  # #   ###    #    #
 #    #  #    #  #    #  #    #     #    #   ##   ###    #    #
 #    #  #    #   ####   #    #     #    #    #   ###    #    #

	Declarations for interpreter's hash tables.
*/

#ifndef _hashinin_h
#define _hashinin_h

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_config.h"
#include "eif_portable.h"

/* Structure which describes the hash table: array of keys and array of
 * values, along with the table's size and the number of recorded elements.
 */
struct store_htable {
	int32 h_size;		/* Size of table (prime number) */
	unsigned long *h_keys;		/* Array of keys (integers) */
	int h_sval;			/* Size of each value item, in bytes */
	int  *h_values;		/* Array of values (pointer needs casting) */
};

/* Function declaration */
extern int store_ht_create(struct store_htable *ht, int32 n, int sval);				/* Create H table */
extern int store_ht_value(struct store_htable *ht, register long unsigned int key);			/* Get value given some key */
extern int store_ht_put(struct store_htable *ht, register long unsigned int key, int val);				/* Insert value in H table */
extern void store_ht_zero(struct store_htable *ht);				/* Initialize H table to zero */
extern void store_ht_free(struct store_htable *ht);				/* Free hash table */

#ifdef __cplusplus
}
#endif

#endif
