/*
	description: "Urgent memory chunk handling."
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
doc:<file name="urgent.c" header="rt_urgent.h" version="$Id$" summary="Urgent memory chunk handling">
doc:	<summary>The purpose of urgent memory is to let the run-time get some memory in situations where the garbage collector cannot be called. A typical use would be getting a small chunk to let one of the internal stacks grow. Given that the overhead of the urgent memory is really small, it is allocated even if the package is optimized for memory.</summary>
*/

#include "eif_portable.h"
#include "rt_urgent.h"
#include "eif_malloc.h"
#ifdef EIF_THREADS
#include "eif_globals.h"
#endif /* EIF_THREADS */

/* Urgent memory chunks are held in an array. The urgent_index variable gives
 * the index in urgent_mem[] which holds the address of a free chunk of memory.
 * This index is decreased each time the run-time requests a chunk, and it
 * reaches -1 when the array has no more chunks in stock.
 */
/*
doc:	<attribute name="urgent_mem" return_type="char * [URGENT_NBR]" export="private">
doc:		<summary>Array of holding urgent chunks. The `urgent_index' variable gives the index in `urgent_mem' which holds the address of a free chunk of memory. This index is decreased each time the run-time requests a chunk, and it reaches -1 when the array has no more chunks in stock.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>A simple mutex seems enough.</fixme>
doc:	</attribute>
*/
rt_private char *urgent_mem[URGENT_NBR];

/*
doc:	<attribute name="urgent_index" return_type="int" export="private">
doc:		<summary>Last index with free chunk. The `urgent_index' variable gives the index in `urgent_mem' which holds the address of a free chunk of memory. This index is decreased each time the run-time requests a chunk, and it reaches -1 when the array has no more chunks in stock.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>A simple mutex seems enough.</fixme>
doc:	</attribute>
*/
rt_private int urgent_index = -1;

/* Getting and releasing chunks */
rt_shared void ufill(void);			/* Get as many chunks as possible */
rt_shared char *uchunk(void);			/* Urgent allocation of a stack chunk */

/* Compiled with -DTEST, we turn on DEBUG if not already done */
#ifdef TEST
#ifndef DEBUG
#define DEBUG	1		/* Highest debug level */
#endif
#endif

rt_shared void ufill(void)
{
	/* Fill in the urgent chunk array as far as possible. At the time this
	 * routine is called, it is safe to call the GC if we get short in memory,
	 * hence we may call cmalloc directly.
	 */

	int i;					/* Location to be filled in */
	char *chunk;				/* Allocated chunk */

	for (i = urgent_index + 1; i < URGENT_NBR; i++) {
		chunk = cmalloc(URGENT_CHUNK);	/* Attempt allocation */
		if (chunk == (char *) 0)		/* Could not get memory */
			break;
		urgent_mem[i] = chunk;			/* Record chunk for later perusal */
	}

	urgent_index = i - 1;				/* Points on last available chunk */
}

rt_shared char *uchunk(void)
{
	/* Get an urgent chunk for stack growing. It would not be sane to allocate
	 * memory for an Eiffel object from this urgent stock, so be it--RAM.
	 * The function returns the address of the next free block of memory
	 * available, or NULL if there is none available. The chunk is suitable
	 * for immediate use: it  has to be split in two parts, one small header
	 * structure and the arena where data are stored.
	 */
	
	char *ret;
	if (urgent_index > 0)					/* A free chunk is available */
	{
		ret = urgent_mem[urgent_index--];	/* Return its address */
		return ret;
	}

	return (char *) 0;			/* No chunk is available */
}

/*
doc:</file>
*/
