/*
	description:	"SCOOP support."
	date:		"$Date$"
	revision:	"$Revision: 96304 $"
	copyright:	"Copyright (c) 2014-2015, Eiffel Software.",
			"Copyright (c) 2014 Scott West <scott.gregory.west@gmail.com>"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

#ifndef _GLOBAL_H
#define _GLOBAL_H

#include "processor.hpp"
#include "rt_identifier_set.h"

class processor_registry
{
public:
  processor_registry ();

  ~processor_registry () {
	rt_identifier_set_deinit (&this->free_pids);
	RT_TRACE (eif_pthread_cond_destroy (this->all_done_cv));
	RT_TRACE (eif_pthread_mutex_destroy (this->all_done_mutex));
  }

  processor* create_fresh (EIF_REFERENCE obj);

  processor* operator[] (EIF_SCP_PID pid);

  void return_processor (processor* proc);

  /* GC activities */
public:
  void enumerate_live ();

  void mark_all (MARKER marking);

  void unmark (EIF_SCP_PID pid);

  void wait_for_all();

  void request_gc (int * fingerprint);

private:
	/*
	 * Although the procs array is accessed by several threads,
	 * it is not necessary to synchronize the access. There are several
	 * properties that make it unnecessary:
	 * 
	 * Data race freedom:
	 * - A new value is inserted by the creator thread after it received
	 *   a new unique PID from the free_pids set. 
	 * - After creation, the field remains constant.
	 * - The value is reset to NULL only by the thread behind the specified
	 *   processor ID, after the garbage collector concluded that it is no
	 *   longer referenced anywhere.
	 * - The uniqueness of PIDs is guaranteed by the free_pids set. A new 
	 *   ID has to be acquired before adding an entry in 'procs', and it
	 *   can only be released after resetting 'procs' to NULL.
	 * 
	 * Visibility:
	 * - Generally, x86 has strong visibility guarantees, and by creating
	 *   initializing the processor object before adding it to 'procs'
	 *   any other thread can see a consistent view.
	 * - The update to the procs array itself is visible in the garbage collector,
	 *   because the creator thread synchronizes with the GC thread prior to a cycle.
	 * - The same applies during removal of a processor.
	 * - Between the creator thread and the spawned thread, visibility is guaranteed
	 *   because of the thread creation operation.
	 * - In between processors, visibility is guaranteed because the creator first
	 *   has to publish the root object of the new processor, and as soon as this
	 *   object is visible by other threads the update is visible as well, thanks
	 *   to the visibility guarantees of x86.
	 */
  processor* procs [RT_MAX_SCOOP_PROCESSOR_COUNT];

  volatile EIF_INTEGER_32 processor_count;
  
  struct rt_identifier_set free_pids;

  /* GC */
private:
  void clear_from_caches (processor *proc);

  /* end of life notification */
private:
  volatile bool all_done;
  EIF_MUTEX_TYPE* all_done_mutex;
  EIF_COND_TYPE* all_done_cv;
};

void call_on (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid, void* data);

extern processor_registry registry;

#endif
