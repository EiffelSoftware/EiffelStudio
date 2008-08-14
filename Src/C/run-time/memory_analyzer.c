/*
	description: "Memory Analyzer"
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
doc:<file name="memory_analyzer.c" header="eif_memory_analyzer.h" version="$Id$" summary="Memory Analyzer">
*/

#include "eif_memory.h"
#include "rt_traverse.h"
#include "rt_garcol.h"
#include "rt_types.h"

rt_public EIF_REFERENCE eif_once_objects_of_result_type(EIF_INTEGER result_type) 
	/* All once objects held by the system */
{
	RT_GET_CONTEXT
	EIF_REFERENCE Result;
	EIF_REFERENCE ref;
	union overhead *zone;
	struct obj_array l_found;
	struct obj_array *l_found_p;
	struct stack *l_once_set;

	struct stchunk* s;
	EIF_REFERENCE *object, o_ref;
	int done = 0;
	int l_thread_once_set = 0;
	int i = 0;
	int j = 0;
	int l_threads_count = 0;
	rt_uint_ptr n;
	char gc_stopped;

	/* Lock global once mutex. */
#ifdef EIF_THREADS
	EIF_ASYNC_SAFE_LW_MUTEX_LOCK(eif_global_once_set_mutex, "Could not lock global once mutex");
#endif

#ifndef EIF_THREADS
	l_once_set = &once_set;
#else
#ifdef ISE_GC
	l_threads_count = once_set_list.count;
	l_once_set = &global_once_set;
#else
	l_once_set = NULL;
#endif
#endif

		/* Initialize structure that will hold found objects */
	l_found.count = 0;
	l_found.capacity = 64;
	l_found.area = malloc (sizeof (EIF_REFERENCE) * l_found.capacity);
	l_found.index = -1;
	l_found_p = &l_found;

	while (l_once_set)
	{
		for (s = l_once_set->st_hd, done = 0; s && !done; s = s->sk_next) {
			object = s->sk_arena;
			if (s != l_once_set->st_cur) {
				n = s->sk_end - object;
			} else {
				n = l_once_set->st_top - object;
				done = 1;
			}

			for ( ; n > 0 ; n--, object++) {
#ifndef EIF_THREADS
#ifdef WORKBENCH
				o_ref = *object;
#else
				o_ref = *(EIF_REFERENCE *) *object;
#endif
#else
				if (l_thread_once_set){
					o_ref = *object;
				} else {
					o_ref = *(EIF_REFERENCE *) *object;
				}
#endif
				if (o_ref) {
					l_found_p->index = l_found_p->index + 1;

					if (l_found_p->index >= l_found_p->capacity) {
						l_found_p->capacity = l_found_p->capacity * 2;
						l_found_p->area = realloc (l_found_p->area, sizeof (EIF_REFERENCE) * (l_found_p->capacity));
					}
					l_found_p->area [l_found_p->index] = o_ref;
					l_found_p->count = l_found_p->count + 1;
				}
			}
		}

#ifndef EIF_THREADS
		l_once_set = NULL;
#else
#ifdef ISE_GC
		if (j < l_threads_count) {
			l_once_set = once_set_list.threads.sstack[j++];
			l_thread_once_set = 1;
		} else {
			l_once_set = NULL;
		}
#else
		l_once_set = NULL;
#endif
#endif
	}

	/* Unlock global once mutex */
#ifdef EIF_THREADS
	EIF_ASYNC_SAFE_LW_MUTEX_UNLOCK(eif_global_once_set_mutex, "Could not unlock global once mutex");
#endif

		/* Now `l_found' is properly populated so let's create
		 * SPECIAL objects of type `result_type' that we will return.
		 * We turn off GC since we do not want objects to be moved. */
	gc_stopped = !eif_gc_ison();
	eif_gc_stop();

	Result = spmalloc (CHRPAD ((rt_uint_ptr) l_found.count * (rt_uint_ptr) sizeof (EIF_REFERENCE)) + LNGPAD(2), EIF_FALSE);
	zone = HEADER (Result);
	ref = Result + (zone->ov_size & B_SIZE) - LNGPAD (2);
	zone->ov_flags |= EO_REF;
	zone->ov_dftype = (EIF_TYPE_INDEX) result_type;
	zone->ov_dtype = To_dtype((EIF_TYPE_INDEX) result_type);
	*(EIF_INTEGER *) ref = l_found.count;
	*(EIF_INTEGER *) (ref + sizeof (EIF_INTEGER)) = sizeof (EIF_REFERENCE);

		/* Now, populate `Result' with content of `l_found'. Since we just
		 * created a new Eiffel objects. */
	for (i = 0 ; i < l_found.count ; i++) {

			/* Store object in `Result'. */
		*((EIF_REFERENCE*) Result + i) = l_found.area [i];
		RTAR(Result, l_found.area [i]);
	}

	free (l_found.area);

		/* Let's turn back the GC on */
	if (!gc_stopped) eif_gc_run();

	return Result;
}

/*
doc:</file>
*/
