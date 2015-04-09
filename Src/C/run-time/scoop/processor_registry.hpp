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

class pid_set
{
public:
  pid_set()
  {
    size_ = 0;
    for (int i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++)
      {
	proc_set [i] = false;
      }
  }

  void add (EIF_SCP_PID pid)
  {
    bool expected = false;
    if (proc_set [pid].compare_exchange_strong (expected, true))
      {
	size_++;
      }
  }

  bool has (EIF_SCP_PID pid)
  {
    return proc_set [pid];
  }

  bool erase (EIF_SCP_PID pid)
  {
    bool result = proc_set [pid].exchange (false);
    if (result)
      {
	size_--;
      }
    return result;
  }

  size_t size() const 
  {
    return size_;
  }

private:
  atomic_size_t_type size_;
  atomic_bool_type proc_set [RT_MAX_SCOOP_PROCESSOR_COUNT];
};


class processor_registry
{
public:
  processor_registry ();

  ~processor_registry () {
	rt_identifier_set_deinit (&this->free_pids);
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

  volatile int gc_fingerprint;

private:
  processor* procs [RT_MAX_SCOOP_PROCESSOR_COUNT];
  pid_set used_pids;
  struct rt_identifier_set free_pids;

  /* GC */
private:
  atomic_bool_type is_marking;
  void clear_from_caches (processor *proc);

  /* end of life notification */
private:
  bool all_done;
  conditional_mutex_type all_done_mutex;
  condition_variable_type all_done_cv;
};

void call_on (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid, void* data);

extern processor_registry registry;

#endif
