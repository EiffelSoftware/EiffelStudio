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

#include "eif_utils.hpp"
#include "eveqs.h"
#include "processor_registry.hpp"
#include "internal.hpp"
#include "private_queue.hpp"
#include "processor.hpp"
#include <algorithm>
#include <eif_posix_threads.h>
#include <eif_threads.h>
#include <stdarg.h>
#include <cassert>

atomic_int_type active_count = atomic_var_init;

processor::processor(spid_t _pid,
                     bool _has_backing_thread) :
  cache (this),
  group_stack (),
  my_token (this),
  token_queue (),
  has_client (true),
  has_backing_thread (_has_backing_thread),
  pid(_pid),
  private_queue_cache(),
  cache_mutex(),
  dirty_for_set(),
  current_msg (),
  parent_obj (std::make_shared<std::nullptr_t>(nullptr))
{
  active_count++;
}

processor::~processor()
{
  for (auto &pq : private_queue_cache)
    {
      delete pq;
    }
}

bool
processor::try_call (call_data *call)
{
  if (true) // Switch this on to catch exceptions
    {
      // This section slows down some benchmarks by 2x. I believe
      // this is due to either some locking in the allocation routines (again)
      // or reloading the thread local variables often.
      bool success;
      GTCX;
      // eif_global_context_t *eif_globals = globals;
      struct ex_vect * EIF_VOLATILE exvect;
      EIF_REFERENCE EIF_VOLATILE saved_except = 0;
      jmp_buf exenv;

      RTXD;
      RTXI(0);

#ifndef WORKBENCH
      exvect = exft();
#endif

      saved_except = RTLA;
      exvect->ex_jbuf = &exenv;

      if (!setjmp(exenv))
	{
	  eif_try_call (call);
	  success = true;
	}
      else
	{
	  exvect = exret(exvect);
	  success = false;
	}
      set_last_exception (saved_except);

      exok();
      RTXE;
      return success;
    }
  else
    {
      // This just shows that the jmp_buf isn't the bottle-neck: this is fast.
      jmp_buf buf;
      if (!setjmp(buf))
	{
	  eif_try_call (call);
	  return true;
	}
      else
	{
	  return false;
	}
    }
}

void
processor::operator()(processor *client, call_data* call)
{
  spid_t sync_pid = call_data_sync_pid (call);

  if (call_data_is_lock_passing (call))
    {
      cache.push (&client->cache);
    }

  bool successful_call = try_call (call);
  if (!successful_call)
    {
      dirty_for_set.insert (client);
    }

  if (call_data_is_lock_passing (call))
    {
      cache.pop ();
    }

  if (sync_pid != NULL_PROCESSOR_ID)
    {
      auto it = dirty_for_set.find (client);

      if (it != dirty_for_set.end())
	{
	  client->result_notify.rude_awake();
	  dirty_for_set.erase (it);
	}
      else
	{
	  client->result_notify.result_awake();
	}
    }

  free (call);
}

void
processor::process_priv_queue(priv_queue *pq)
{
  for (;;)
    {
      pq->pop_msg (current_msg);

      if (current_msg.call == NULL)
        {
          return;
        }

      (*this)(current_msg.client, current_msg.call);

      current_msg.call = NULL;
    }
}


void
spawn_main(char* data, spid_t pid)
{
  processor *proc = registry [pid];
  (void)data;

  proc->startup_notify.result_awake();
  proc->application_loop();
  registry.return_processor (proc);
}


void
processor::spawn()
{
  eif_thr_create_with_attr_new ((char**)parent_obj.get(), // No root object, if this is only
                                                    // passed to spawn_main this is OK
                                (void (*)(char* data, ...)) spawn_main,
                                pid, // Logical PID
                                EIF_TRUE, // We are a processor
                                NULL); // There are no attributes
}

void
processor::register_notify_token (notify_token token)
{
  token_queue.push (token);
}

void
processor::notify_next(processor *client)
{
  auto n = token_queue.size();
  for (auto i = 0U; i < n && !token_queue.empty(); i++)
    {
      auto token = token_queue.front();
      token_queue.pop();

      if (token.client() == client)
        {
          token_queue.push(token);
        }
      else
        {
          token.notify(client);
        }
    }
}

void
processor::application_loop()
{
  has_client = false;
  for (;;)
    {
      qoq_item res;

      // Triggering the collection happens when all
      // processors are idle. This is sufficient for
      // program termination, but not sufficient for
      // freeing threads to let new ones take their
      // place.
      if (--active_count == 0 && qoq.is_empty())
        {
          plsc();
        }

      qoq.pop(res);

      if (!res.is_done)
        {
          active_count++;
          has_client = true;

          process_priv_queue (res.queue);
          notify_next (res.client);

          has_client = false;
        }
      else
        {
          break;
        }
    }
}

void
processor::shutdown()
{
  qoq.push (qoq_item());
}

void
processor::mark(marker_t mark)
{
  if (current_msg.call)
    {
      mark_call_data (mark, current_msg.call);
    }

  for (auto &pq : private_queue_cache)
    {
      pq->mark(mark);
    }
}


priv_queue*
processor::new_priv_queue()
{
  unique_lock_type lk (cache_mutex);
  private_queue_cache.push_back(new priv_queue(this));
  return private_queue_cache.back();
}
