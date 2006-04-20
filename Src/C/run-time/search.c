/*
	description: "Search table (like an H table, but no value array)."
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

/*
doc:<file name="search.c" header="rt_search.h" version="$Id$" summary="Search table, ie hash table where keys are the elements">
*/

#include "eif_portable.h"
#include "rt_search.h"
#include "rt_tools.h"
#include "rt_malloc.h"
#include <string.h>

rt_public struct s_table *s_create(size_t size)
{
	/* Returns new search table of size `size'. */

	size_t real_size;
	char **keys;
	struct s_table *result;

	real_size = nprime((4 * size) / 3);
	keys = (char **) eif_rt_xcalloc(real_size, sizeof(char *));
	if (keys == (char **) 0)
		enomem(MTC_NOARG);
	result = (struct s_table *) cmalloc(sizeof(struct s_table));
	if (result == (struct s_table *) 0)
		enomem(MTC_NOARG);
	result->s_size = real_size;
	result->s_keys = keys;
	result->s_count = 0;
	return result;
}

rt_public int s_put(struct s_table *tbl, char *object)
{
	/* Insert `object' in `h_table'. Return `EIF_SEARCH_CONFLICT' if already in it,
	 * otherwise return `EIF_SEARCH_OK'.
	 */

	size_t pos; 		/* Table position */

	pos = s_search(tbl,object);
	if (pos == EIF_SEARCH_FOUND)
		return EIF_SEARCH_CONFLICT;
	else {
		if ((tbl->s_size * 80) <= (tbl->s_count * 100)) {
			s_resize(tbl);
			pos = s_search(tbl,object);
		}
		tbl->s_keys[pos] = object;
		tbl->s_count++;
		return EIF_SEARCH_OK;
	}
}

rt_public size_t s_search(struct s_table *tbl, char *object)
{
	/* Internal search of `object' in `tbl'. Return EIF_SEARCH_FOUND if found, otherwise
	 * position where to insert it.
	 */

	size_t key = ((size_t) (rt_uint_ptr) object) - 1;	/* Key for `object' */
	size_t position;
	size_t increment;
	size_t size = tbl->s_size;			/* Table size */
	char **keys = tbl->s_keys;			/* Table keys */
	char *old_key;

	increment = 1 + (key % (size - 1));
	for (position = key % size; ; position = (position + increment) % size)  {
		old_key = keys[position];
		if (old_key == (char *) 0)
			return position;			/* `object' not found */
		else if (old_key == object)
			return EIF_SEARCH_FOUND;				/* `object' found */
	}
}

rt_public void s_resize(struct s_table *tbl)
{
	/* Resize `tbl' to a bigger size */

	size_t i, size;
	struct s_table *new;
	char *one_key;
	char **keys = tbl->s_keys;

	size = tbl->s_size;
	new = s_create(3 * size / 2);
	for(i = 0; i < size; i++) {			/* Iteration on keys of `tbl' */
		one_key = keys[i];
		if (one_key != (char *) 0)
			s_put(new,one_key);
	}
	eif_rt_xfree((char *) (tbl->s_keys));			/* Free old keys */
	memcpy (tbl, new, sizeof(struct s_table));	/* Copy new descriptor */
	eif_rt_xfree((char *) new);					/* Free temporary descriptor */
}

/*
doc:</file>
*/
