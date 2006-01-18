/*
	description: "Include file for hashtable of pointers/integers."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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
RT_LNK void ht_free(struct htable *ht);				/* Free hash table */

#ifdef __cplusplus
}
#endif

#endif
