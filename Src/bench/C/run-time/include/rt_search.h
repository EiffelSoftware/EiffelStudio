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
	Search table routines.
*/

#ifndef _eif_search_h_
#define _eif_search_h_

#include "eif_types.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Search table declarations.
 */

#define EIF_SEARCH_OK		0		/* No conflict result value of `s_put' */
#define EIF_SEARCH_CONFLICT	1		/* Conflict result value of `s_put' */
#define EIF_SEARCH_FOUND	-1		/* Object found by `s_search' */

/*
 * Search table interface.
 */

extern struct s_table *s_create(size_t size);	/* Creates search table */
extern int s_put(struct s_table *tbl, char *object);					/* Insertion in search table */
extern size_t s_search(struct s_table *tbl, char *object);			/* Search in table */
extern void s_resize(struct s_table *tbl);				/* Search table resizing */

#ifdef __cplusplus
}
#endif

#endif

