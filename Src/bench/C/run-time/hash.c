/*
	description: "Hashtable of pointers/pointers."
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
doc:<file name="hash.c" header="rt_hash.h" version="$Id$" summary="Hash table implementation">
*/

#include "eif_portable.h"
#include "rt_tools.h"
#include "rt_malloc.h"
#include "rt_hash.h"

/* 
 * Declarations
 */

rt_shared char **hash_search(struct hash *hp, register char *object);	/* Search in the hash table */
rt_shared void hash_free(struct hash *hp);		/* Free the tables */
rt_shared void hash_malloc(struct hash *hp, register long int size);	/* Hash table creation */
/*rt_private void free_entries();*/	/* Free all the hector entries */ /* %%ss undefined not used in run-time */
/* 
 * Function definitions
 */


rt_shared void hash_malloc(struct hash *hp, register long int size)
{
	 /* Initialization of the hash table */

	hp->h_size = nprime(4 * size /3);
	hp->h_key = (char **) eif_rt_xcalloc(hp->h_size, sizeof(char *));
	hp->h_entry = (char **) eif_rt_xcalloc(hp->h_size, sizeof(char *));
}

rt_shared void hash_free(struct hash *hp)
{
	/* Free memory allocated to the tables. */

	eif_rt_xfree((char *) (hp->h_key));			/* Free keys array */
	eif_rt_xfree((char *) (hp->h_entry));			/* Free entries array */
	hp->h_key = NULL;
	hp->h_entry = NULL;
	hp->h_size = 0;
}

rt_shared char **hash_search(struct hash *hp, register char *object)
{
	/* Search in hash table for updating references.
	 * Return a pointer to an entry of `hash_entry' and not the entry itself.
	 */

	rt_uint_ptr pos;
	char *key;
	rt_uint_ptr inc;
	rt_uint_ptr code = ((rt_uint_ptr) object - 1);
	rt_uint_ptr hash_size = hp->h_size;

	/* Initialization of the position */
	pos = code % hash_size;

	for (inc = 1 + (code % (hash_size - 1));; pos = (pos + inc) % hash_size) {
		key = hp->h_key[pos];
		if (!key) {
			hp->h_key[pos] = object;		/* Not yet in table */
			break;
		} else if (key == object)
			break;							/* No conflict */

	}
	return &hp->h_entry[pos];
}

/*
doc:</file>
*/
