/*
	description: "[
		Hash table handling (indexed by integer keys compatible with the size of a pointer, i.e. we can also
		index by pointers). For details on the implementation, look at the EiffelBase HASH_TABLE class.

		The routines use eif_malloc and eif_free and not eif_rt_xcalloc,
	   	eif_rt_xfree because we want to release the memory taken by the
	   	hash table after retrieving a storable (from ~40k to a much more) so that
	   	it will be reused by Eiffel objects.
		The note above is only valid for Windows (and any other implementation
		that does not redefine malloc and free. If they are redefined, the
		blocks of memory will be managed the same way.)

		]"
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
doc:<file name="hashin.c" header="rt_hashin.h" version="$Id$" summary="Hash table implementation indexed by integer keys">
*/

#include "eif_portable.h"
#include "rt_tools.h"
#include "rt_hashin.h"
#include "rt_malloc.h"
#include "rt_lmalloc.h"    /* for eif_calloc, eif_malloc, eif_free */
#include "eif_except.h"	/* for eif_panic() */
#include "rt_assert.h" /* for ENSURE */

#include <string.h>		/* For memset(), bzero() */

/*
doc:	<routine name="ht_create" return_type="int" export="shared">
doc:		<summary>Initializes a hash-table `ht' to hold `n' items of size `sval'. This is the C equivalent version of the EiffelBase HASH_TABLE class. We allocate the table so that it can hold at least (n + n // 2) entries.</summary>
doc:		<param name="ht" type="struct htable *">Table to initialize.</param>
doc:		<param name="n" type="size_t">Number of elements `ht' must accomodate.</param>
doc:		<param name="sval" type="size_t">Size of elements stored in `ht'.</param>
doc:		<return>Returns 0 if initialization was done, -1 otherwise.</return>
doc:		<thread_safety>Not Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_shared int ht_create(struct htable *ht, size_t n, size_t sval)
{
	size_t l_capacity;		/* Size of created table */
	char *array;		/* For array creation (keys/values) */

	REQUIRE("ht not null", ht);
	
	l_capacity = nprime(n + (n / 2));	/* Table's size */

	array = (char *) eif_calloc(l_capacity, sizeof(rt_uint_ptr));	/* Mallocs array of keys */
	if (!array) {
		return -1;					/* Malloc failed */
	}
	ht->h_keys = (rt_uint_ptr *) array;		/* Where array of keys is stored */

	array = (char *) eif_calloc(l_capacity, sizeof(char));
	if (!array) {
		eif_free(ht->h_keys);
		return -1;
	}
	ht->h_deleted = array;

	array = (char *) eif_calloc(l_capacity, sval);			/* Mallocs array of values */
	if (!array) {
		eif_free(ht->h_keys);			/* Free keys array */
		eif_free(ht->h_deleted);
		return -1;					/* Malloc failed */
	}
	ht->h_values = (void *) array;			/* Where array of keys is stored */

	ht->h_capacity = l_capacity;				/* Size of hash table */
	ht->h_sval = sval;				/* Size of each stored item */

	return 0;			/* Creation was ok */
}

/*
doc:	<routine name="ht_zero" export="shared">
doc:		<summary>Reset the whole `ht' to its default initialization state.</summary>
doc:		<param name="ht" type="struct htable *">Table to re-initialize.</param>
doc:		<thread_safety>Not Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_shared void ht_zero(struct htable *ht)
{
	size_t l_capacity = ht->h_capacity;

	REQUIRE("ht not null", ht);

	memset (ht->h_keys, 0, l_capacity * sizeof(rt_uint_ptr));
	memset (ht->h_values, 0, l_capacity * ht->h_sval);
	memset (ht->h_deleted, 0, l_capacity * sizeof(char));
}

/*
doc:	<routine name="ht_value" return_type="void *" export="shared">
doc:		<summary>Search `key' in hash-table `ht' and returns the associated value address if found.</summary>
doc:		<param name="ht" type="struct htable *">Table to initialize.</param>
doc:		<param name="key" type="rt_uint_ptr">Key to find in `ht'.</param>
doc:		<return>Returns address of value in `ht' if found, NULL otherwise.</return>
doc:		<thread_safety>Not Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_shared void * ht_value(struct htable *ht, rt_uint_ptr key)
{
	size_t pos;		/* Position in H table */
	size_t l_capacity;		/* Size of H table */
	rt_uint_ptr *hkeys;		/* Array of keys */
	char *hdeleted;
	size_t tmp_try = 0;	/* Count number of attempts */
	size_t inc;		/* Loop increment */
	rt_uint_ptr l_key;

	REQUIRE("ht not null", ht);
	REQUIRE("key not null", key);

		/* Initializations */
	l_capacity = ht->h_capacity;
	hkeys = ht->h_keys;
	hdeleted = ht->h_deleted;

	/* Jump from one hashed position to another until we find the value or
	 * go to an empty entry or reached the end of the table. */
	inc = 1 + (key % (l_capacity - 1));
	for (pos = key % l_capacity; tmp_try < l_capacity; tmp_try++, pos = (pos + inc) % l_capacity) {
		l_key = hkeys[pos];
		if (l_key == key) {
			return ((char *) ht->h_values) + (pos * ht->h_sval);
		} else if ((l_key == 0L) && (!hdeleted[pos])) {
				/* There is no key and it is not a deleted position, so
				 * we can stop the search here! */
			return NULL;
		}
	}
	return NULL;			/* Item was not found */
}

/*
doc:	<routine name="ht_first" return_type="void *" export="shared">
doc:		<summary>WARNING!! It is a side effect query. If `key' is present it behaves exactly as `ht_value'. If `key' is not present, it inserts `key' at the first suitable location, if any, and returns the associated value address. If no suitable location is found, we return NULL.</summary>
doc:		<param name="ht" type="struct htable *">Table to initialize.</param>
doc:		<param name="key" type="rt_uint_ptr">Key to find in `ht'.</param>
doc:		<return>Returns address of value in `ht' if possible, NULL otherwise.</return>
doc:		<thread_safety>Not Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_shared void * ht_first(struct htable *ht, rt_uint_ptr key)
{
	size_t pos;		/* Position in H table */
	size_t l_capacity;	  	/* Size of H table */
	rt_uint_ptr *hkeys;	 	/* Array of keys */
	char *hdeleted;
	size_t tmp_try = 0;	/* Count number of attempts */
	size_t inc;		/* Loop increment */
	rt_uint_ptr l_key;
	size_t l_available_pos = (size_t) -1;

	REQUIRE("ht not null", ht);
	REQUIRE("key not null", key);

		/* Initializations */
	l_capacity = ht->h_capacity;
	hkeys = ht->h_keys;
	hdeleted = ht->h_deleted;

		/* Jump from one hashed position to another until we find the value or
		 * go to an empty entry or reached the end of the table. */
	inc = 1 + (key % (l_capacity - 1));
	for (pos = key % l_capacity; tmp_try < l_capacity; tmp_try++, pos = (pos + inc) % l_capacity) {
		l_key = hkeys[pos];
		if (l_key == key) {
			return ((char *) ht->h_values) + (pos * ht->h_sval);
		} else if (l_key == 0) {
			if (!hdeleted[pos]) {
					/* We found an empty slot that was not deleted, we can stop
					 * the search here. If there was no former available position
					 * that could have stored `key', we set `l_available_pos'
					 * to `pos', otherwise we preserve the existing value of
					 * `l_available_pos' and exit the loop. */
				if (l_available_pos == (size_t) -1) {
					l_available_pos = pos;
				}
				break;
			} else if (l_available_pos == (size_t) -1) {
					/* We found an empty slot that was deleted. We store that position
					 * in `l_available_pos'. In the event we cannot find `key',
					 * we will use `l_available_pos' position for computing our result. */
				l_available_pos = pos;
			}
		}
	}

	if (l_available_pos != (size_t) -1) {
		hkeys[l_available_pos] = key;
		return ((char *) ht->h_values) + (l_available_pos * ht->h_sval);
	} else {
			/* Table is full and we could not find `key'. */
		return NULL;
	}
}

/*
doc:	<routine name="ht_safe_force" return_type="int" export="shared">
doc:		<summary>Put value `val' associated with key `key' in table `ht'. If `ht' is full, we will resize `ht' and try again. If `resizing' failed or if we cannot find a suitable position, a negative value is returned.</summary>
doc:		<param name="ht" type="struct htable *">Table to initialize.</param>
doc:		<param name="key" type="rt_uint_ptr">Key to insert in `ht'.</param>
doc:		<param name="val" type="void *">Value to insert in `ht'.</param>
doc:		<return>0 upon successful insertion, -1 if cannot resize, -2 if cannot insert.</return>
doc:		<thread_safety>Not Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_shared int ht_safe_force (struct htable *ht, rt_uint_ptr key, void * val)
{
	REQUIRE("ht not null", ht);
	REQUIRE("key not null", key);

	if (!(ht_put(ht, key, val))) {		/* Insertion failed => H table full */
			/* Resize the hash table */
		if (ht_resize(ht, ht->h_capacity + (ht->h_capacity / 2))) {
				/* Cannot resize. */
			return -1;
		} else {
				/* Something (...) was rotten, don't know what */
				/* Insertion failed again => Bailing out */
			if (!(ht_put(ht, key, val))) {
					/* Cannot insert. */
				return -2;
			}
		}
	}
		/* Success. */
	return 0;
}

/*
doc:	<routine name="ht_force" export="shared">
doc:		<summary>Put value `val' associated with key `key' in table `ht'. If `ht' is full, we will resize `ht' and try again. If `resizing' failed or if we cannot find a suitable position, an exception is thrown. In other words, it is the same as `ht_safe_force' modulo an exception instead of an error code.</summary>
doc:		<param name="ht" type="struct htable *">Table to initialize.</param>
doc:		<param name="key" type="rt_uint_ptr">Key to insert in `ht'.</param>
doc:		<param name="val" type="void *">Value to insert in `ht'.</param>
doc:		<thread_safety>Not Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_shared void ht_force(struct htable *ht, rt_uint_ptr key, void * val)
{
	int l_error;

	REQUIRE("ht not null", ht);
	REQUIRE("key not null", key);

	l_error = ht_safe_force (ht, key, val);
	if (l_error != 0) {
		if (l_error == -1) {
			eraise ("Hash table resizing failure", EN_FATAL);
		} else {
			CHECK("valid error code", l_error == -2);
			eraise ("Hash table insertion failure", EN_FATAL);
		}
	}
}

/*
doc:	<routine name="ht_put" return_type="void *" export="shared">
doc:		<summary>Put value `val' associated with key `key' in table `ht'. If `ht' is not full, we return the address of the associated value in `ht'.</summary>
doc:		<param name="ht" type="struct htable *">Table to initialize.</param>
doc:		<param name="key" type="rt_uint_ptr">Key to insert in `ht'.</param>
doc:		<param name="val" type="void *">Value to insert in `ht'.</param>
doc:		<return>Address of value in `ht' if inserted, NULL otherwise.</return>
doc:		<thread_safety>Not Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_shared void * ht_put(struct htable *ht, rt_uint_ptr key, void * val)
{
	void *l_val;

	REQUIRE("ht not null", ht);
	REQUIRE("key not null", key);

	l_val = ht_first(ht, key);

	if (l_val) {
			/* We found a free position for `key' so let's copy `val' in it. */
		memcpy (l_val, val, ht->h_sval);
	}

	return l_val;
}

/*
doc:	<routine name="ht_remove" export="shared">
doc:		<summary>Remove `key' if present from `ht'.</summary>
doc:		<param name="ht" type="struct htable *">Table to initialize.</param>
doc:		<param name="key" type="rt_uint_ptr">Key to remove from `ht'.</param>
doc:		<thread_safety>Not Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_shared void ht_remove(struct htable *ht, rt_uint_ptr key)
{
	size_t pos;		/* Position in H table */
	size_t l_capacity;		/* Size of H table */
	rt_uint_ptr *hkeys;		/* Array of keys */
	char *hdeleted;
	size_t tmp_try = 0;	/* Records number of attempts */
	size_t inc;		/* Loop increment */
	rt_uint_ptr l_key;

	REQUIRE("ht not null", ht);
	REQUIRE("key not null", key);

	/* Initializations */
	l_capacity = ht->h_capacity;
	hkeys = ht->h_keys;
	hdeleted = ht->h_deleted;

	/* Jump from one hashed position to another until we find a free entry or
	 * we reached the end of the table.
	 */
	inc = 1 + (key % (l_capacity - 1));
	for (pos = key % l_capacity; tmp_try < l_capacity; tmp_try++, pos = (pos + inc) % l_capacity) {
		l_key = hkeys[pos];
		if (l_key == key) {
			hkeys[pos] = 0L;
			ht->h_deleted[pos] = (char) 1;
			return;
		} else if ((l_key == 0L) && (!hdeleted[pos])) {
				/* There is no key and it is not a deleted position, so we can
				 * stop our search here. */
			return;
		}
	}
}

/*
doc:	<routine name="ht_resize" return_type="int" export="shared">
doc:		<summary>Resize `ht' to accomodate `new_size' many elements.</summary>
doc:		<param name="ht" type="struct htable *">Table to resize.</param>
doc:		<param name="new_size" type="size_t">New size. If smaller than existing size, no resizing is done.</param>
doc:		<return>0 if resizing was Ok, -1 otherwise.</return>
doc:		<thread_safety>Not Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_shared int ht_resize(struct htable *ht, size_t new_size)
{
	size_t l_capacity;				/* Size of old H table */
	size_t sval;				/* Size of an H table item */
	rt_uint_ptr *key;			/* To loop over keys */
	void * val, *l_value;		/* To loop over values */
	struct htable new_ht;

	REQUIRE("ht not null", ht);

	l_capacity = ht->h_capacity;
	if (l_capacity >= new_size) {
		return -1;	/* Requested size is no bigger than what we have. */
	}
	sval = ht->h_sval;
	if (-1 == ht_create(&new_ht, l_capacity * 2, sval)) {
		return -1;		/* Extension of H table failed */
	}

	key = ht->h_keys;				/* Start of array of keys */
	val = ht->h_values;				/* Start of array of values */

	/* Now loop over the whole table, inserting each item in the new one */
	for (; l_capacity > 0; l_capacity--, key++, val = (char *) val + sval) {
		if (*key) {
			l_value = ht_first(&new_ht, *key);
			CHECK("Item found", l_value);
			memcpy (l_value, val, sval);
		}
	}

	/* Free old H table and set H table descriptor */
	ht_release(ht);
	memcpy (ht, &new_ht, sizeof(struct htable));

	return 0;		/* Extension was ok */
}

/*
doc:	<routine name="ht_release" export="shared">
doc:		<summary>Free memory used internally by `ht'.</summary>
doc:		<param name="ht" type="struct htable *">Table to initialize.</param>
doc:		<thread_safety>Not Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_shared void ht_release (struct htable *ht)
{
	REQUIRE("ht not null", ht);

		/* Free hash table arrays. */
	eif_free(ht->h_values);
	eif_free(ht->h_keys);
	eif_free(ht->h_deleted);
	ht->h_values = NULL;
	ht->h_keys = NULL;
	ht->h_deleted = NULL;
}

/*
doc:	<routine name="ht_free" export="shared">
doc:		<summary>Free memory used internally by `ht' and `ht' itself assuming it was allocated by the runtime memory routines (i.e. not `eif_malloc' or `eif_calloc'.</summary>
doc:		<param name="ht" type="struct htable *">Table to initialize.</param>
doc:		<thread_safety>Not Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_shared void ht_free(struct htable *ht)
{
	REQUIRE("ht not null", ht);

		/* Free hash table arrays and descriptor */
	ht_release (ht);
	eif_rt_xfree((char *) ht);
}

/*
doc:</file>
*/
