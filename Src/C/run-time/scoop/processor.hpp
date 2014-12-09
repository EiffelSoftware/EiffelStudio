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

#ifndef _PROCESSOR_H
#define _PROCESSOR_H
#include <memory>
#include <vector>
#include <queue>
#include "qoq.hpp"
#include "eif_utils.hpp"
#include "private_queue.hpp"
#include "req_grp.hpp"
#include "spsc.hpp"
#include "eveqs.h"
#include "notify_token.hpp"
#include "queue_cache.hpp"

/* A specialized version of <spsc> that is for notification.
 *
 * The use of <spsc> allows notifications to not be lost, although
 * of course it can only be used between a single receiver and sender
 * at one time.
 */
struct notifier : spsc <notify_message> {

  /* Wait for a new notification
   */
  notify_message wait ()
  {
    notify_message msg;
    this->pop(msg, 64);
    return msg;
  }

  /* Awaken the waiter rudely.
   *
   * Here, rudely means that the supplier of the current query is
   * now dirty.
   */
  void rude_awake()
  {
    this->push(notify_message(notify_message::e_dirty));
  }

  /* Regular (non-callback, non-rude) wakeup.
   *
   * This wakeup is for results, for example.
   */
  void result_awake ()
  {
    this->push(notify_message());
  }

  /* A callback wakeup.
   *
   * This means that the waiting is due to lock passing, and this is
   * actually a call from one of the suppliers that we passed our
   * callstack to.
   */
  void callback_awake (processor* client, call_data *call)
  {
    this->push(notify_message(notify_message::e_callback, client, call));
  }

};

/* The SCOOP logical unit of processing.
 *
 * The processor is responsible for receiving calls, executing them, and
 * notifying clients of changes.
 */
class processor
{

public:
  /* Construct a new processor.
   * @_pid the processor ID that will be used to identify this processor
   *       to the Eiffel runtime
   * @_has_backing_thread whether the processor alreadyd has a backing thread,
   *                      normally this is false, but for the root processor
   *                      it will already be true.
   *
   * The new processor will usually not yet have a thread backing it.
   */
  processor(EIF_SCP_PID _pid,
            bool _has_backing_thread = false);

  ~processor();

  /* The main loop of the processor.
   *
   * Normally this will be called when the thread spawns but here we expose it
   * so that it may be called externally for the root thread (whose thread is
   * the main thread of the program, and thus already exists).
   */
  void application_loop();

  /* Send a shutdown message.
   *
   * Sending a shutdown message will cause the thread to shutdown when it
   * receives it. It will only receive it after it has processed the other
   * requests in its <qoq>, so it may not take effect immediately.
   */
  void shutdown();

public:
  /* The cache of private queues.
   */
  queue_cache cache;

  /* Process a call on this processor.
   * @client the client of the call
   * @call the call to execute.
   */
  void
  operator()(processor *client, call_data* call);

public:
  /* The queue of queues.
   * 
   * This will be used by private queues to add new calls for this processor
   * to apply.
   */
  mpscq <qoq_item> qoq;
  recursive_mutex_type qoq_mutex;

public:
  /* A stack of <req_grp>s.
   * 
   * The vector here is used as a stack, which mirrors the processors locked
   * in the real call stack.
   */
  std::vector <req_grp> group_stack;

public:
  /* Register another processors <notify_token>.
   * @token the token to add to this processor.
   *
   * These list of tokens will be notified in some way when this the heap
   * protected by this processor may have changed. This is used to implement
   * notification for things like wait conditions.
   */
  void register_notify_token(notify_token token);

  /* Notify token for wait conditions.
   * 
   * This will be used as an argument to other <processor>'s
   * <register_notify_token>.
   */
  notify_token my_token;

private:
  std::queue <notify_token> token_queue;
  void notify_next(processor *);


public:

  /* Has a client.
   * 
   * This is used to prevent an active
   * processor, which may not have any references to it, from being collected.
   */
  bool has_client;

  /* Marks the processor's <priv_queues>
   * @mark The specific marking routine.
   */
  void mark (marker_t mark);

public:
  /* A result notifier.
   * 
   * This is the notifier that this processor will wait on when
   * it asks another processor for a result.
   */
  notifier result_notify;

public:
  /* Ask the Eiffel runtime to make a new thread for this processor.
   */
  void spawn();
  
  /* Has an associated thread.
   * 
   * True if this processor has a thread spawned to back it.
   */
  volatile bool has_backing_thread;

  /* Notifier for startup.
   *
   * Lets the constructing thread know that the backing
   * thread for this processor has been spawned.
   * It is important for GC that the thread that requested this processor
   * to spawn a thread doesn't proceed until it has been constructed.
   */
  notifier startup_notify;

  /* The processor ID.
   */
  EIF_SCP_PID pid;

public:
  /* New private queue.
   *
   * @return a new private queue whose supplier is this processor.
   */
  priv_queue*
  new_priv_queue();

private:
  std::vector<priv_queue*> private_queue_cache;
  mutex_type cache_mutex;

private:
  /* Clients that we have to notify that we didn't do what they wanted.
   */
  std::set<processor*> dirty_for_set;

  /* The current message we have.
   * 
   * This call in here will be traced during marking.
   */
  pq_message current_msg;


  /* A vacuous pointer object to satisfy the Eiffel runtime's requirement
   * for an object to be the "current" object for a thread.
   */
  shared_ptr_type <void *> parent_obj;

  /* Try to execute a call from the private queue.
   * @pq private queue to take the call from
   * @call the call to apply
   */
  bool try_call (call_data *call);

  void process_priv_queue(priv_queue*);

};


#endif // _PROCESSOR_H
