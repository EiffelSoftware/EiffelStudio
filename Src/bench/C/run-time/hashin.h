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

#ifdef __cplusplus
extern "C" {
#endif

#include "config.h"
#include "portable.h"

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
extern int ht_create();				/* Create H table */
extern char *ht_value();			/* Get value given some key */
extern char *ht_first();			/* Get item address */
extern char *ht_put();				/* Insert value in H table */
extern void ht_force();				/* Insert value in H table (extending
									 * hash table if needed) */
extern void ht_remove();			/* Remove value in H table */
extern int ht_xtend();				/* Extend size of full H table */
extern void ht_zero();				/* Initialize H table to zero */
extern void ht_free();				/* Free hash table */

#ifdef __cplusplus
}
#endif

#endif
