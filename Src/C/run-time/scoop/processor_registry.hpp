//
// EVE/Qs - A new runtime for the EVE SCOOP implementation
// Copyright (C) 2014 Scott West <scott.gregory.west@gmail.com>
//
// This file is part of EVE/Qs.
//
// EVE/Qs is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// EVE/Qs is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with EVE/Qs.  If not, see <http://www.gnu.org/licenses/>.
//

#ifndef _GLOBAL_H
#define _GLOBAL_H

#include "mpmc.hpp"
#include "processor.hpp"

#define MAX_PROCS 1024

class pid_set
{
public:
  pid_set()
  {
    size_ = 0;
    for (int i = 0; i < MAX_PROCS; i++)
      {
	proc_set [i] = false;
      }
  }

  void add (spid_t pid)
  {
    bool expected = false;
    if (proc_set [pid].compare_exchange_strong (expected, true))
      {
	size_++;
      }
  }

  bool has (spid_t pid)
  {
    return proc_set [pid];
  }

  bool erase (spid_t pid)
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
  atomic_bool_type proc_set [MAX_PROCS];
};


class processor_registry
{
public:
  processor_registry ();

  processor*
  create_fresh (void* obj);

  processor*
  operator[] (spid_t pid);

  void
  return_processor (processor* proc);

  // GC activities
public:
  void
  enumerate_live ();

  void
  mark_all (marker_t mark);

  void
  unmark (spid_t pid);

  void
  wait_for_all();

private:
  processor* procs[MAX_PROCS];
  pid_set used_pids;
  mpmc_bounded_queue<spid_t> free_pids;

  // GC
private:
  atomic_bool_type is_marking;
  void clear_from_caches (processor *proc);

private:
  conditional_mutex_type need_pid_mutex;
  condition_variable_type need_pid_cv;

  // end of life notification
private:
  bool all_done;
  conditional_mutex_type all_done_mutex;
  condition_variable_type all_done_cv;
};

void
call_on (spid_t client_pid, spid_t supplier_pid, void* data);


extern processor_registry registry;



#endif // _GLOBAL_H
