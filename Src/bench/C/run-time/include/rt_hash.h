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
	Include file for hash table.
*/

#ifndef _eif_hash_h_
#define _eif_hash_h_

#ifdef __cplusplus
extern "C" {
#endif

struct hash {				/* Hashing table pointer -> EIF_OBJECT */
	size_t h_size;				/* Size of the hash table */
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

