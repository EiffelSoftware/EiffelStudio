/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
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
	size_t h_size;			/* Size of table (prime number) */
	rt_uint_ptr *h_keys;	/* Array of keys (integers) */
	size_t h_sval;			/* Size of each value item, in bytes */
	EIF_POINTER h_values;	/* Array of values (pointer needs casting) */
};

/* Function declaration */
extern int ht_create(struct htable *ht, size_t n, size_t sval);				/* Create H table */
extern EIF_POINTER ht_value(struct htable *ht, rt_uint_ptr key);			/* Get value given some key */
extern EIF_POINTER ht_first(struct htable *ht, rt_uint_ptr key);			/* Get item address */
extern EIF_POINTER ht_put(struct htable *ht, rt_uint_ptr key, EIF_POINTER val);				/* Insert value in H table */
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
