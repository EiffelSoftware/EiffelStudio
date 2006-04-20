/*
	description: "Search table routines."
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

