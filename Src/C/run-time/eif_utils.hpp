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

#ifndef _EIF_UTILS_H
#define _EIF_UTILS_H
#include "eif_macros.h"

// #define EIF_USE_STD_MUTEX
#ifdef EIF_USE_STD_MUTEX
#	include <mutex>
#	include <condition_variable>
		/* Standard mutexes and locks on them. */
	typedef std::mutex mutex_type;
	typedef std::unique_lock<mutex_type> unique_lock_type;

		/* Recursive mutexes. */
	typedef std::recursive_mutex recursive_mutex_type;

		/* Condition variabnles, mutexes and locks that can be used with condition variables. */
	typedef std::mutex conditional_mutex_type;
	typedef std::unique_lock <conditional_mutex_type> conditional_unique_lock_type;
	typedef std::condition_variable condition_variable_type;
#else
#	include "concurrency/rt_mutex.hpp"
#	include "concurrency/rt_unique_lock.hpp"
#	include "concurrency/rt_condition_variable.hpp"

		/* Standard mutexes and locks on them. */
	typedef eiffel_run_time::mutex mutex_type;
	typedef eiffel_run_time::unique_lock <mutex_type> unique_lock_type;

		/* Recursive mutexes. */
		/* The default implementation supports recursive mutexes. */
	typedef mutex_type recursive_mutex_type;

		/* Condition variabnles, mutexes and locks that can be used with condition variables. */
	typedef eiffel_run_time::mutex conditional_mutex_type;
	typedef eiffel_run_time::unique_lock<conditional_mutex_type> conditional_unique_lock_type;
	typedef eiffel_run_time::condition_variable condition_variable_type;
#endif

// #define EIF_USE_STD_ATOMIC
#ifdef EIF_USE_STD_ATOMIC
#	include <atomic>
#	define atomic_var_init ATOMIC_VAR_INIT (0)
	typedef std::atomic_int	atomic_int_type;
	typedef std::atomic<bool> atomic_bool_type;
	typedef std::atomic<size_t> atomic_size_t_type;
#	define atomic_type std::atomic
#	define memory_order_release_const std::memory_order_release
#	define memory_order_relaxed_const std::memory_order_relaxed
#	define memory_order_acquire_const std::memory_order_acquire
#	define memory_order_seq_cst_const std::memory_order_seq_cst
#	define memory_barrier() atomic_thread_fence (memory_order_seq_cst_const)
#else
#	include "concurrency/rt_atomic.hpp"
#	define atomic_var_init {0}
	typedef eiffel_run_time::atomic_int atomic_int_type;
	typedef eiffel_run_time::atomic_bool atomic_bool_type;
	typedef eiffel_run_time::atomic_size_t atomic_size_t_type;
#	define atomic_type eiffel_run_time::atomic
#	define memory_order_release_const eiffel_run_time::memory_order_release
#	define memory_order_relaxed_const eiffel_run_time::memory_order_relaxed
#	define memory_order_acquire_const eiffel_run_time::memory_order_acquire
#	define memory_order_seq_cst_const eiffel_run_time::memory_order_seq_cst
#	define memory_barrier() EIF_MEMORY_BARRIER
#endif

// #define EIF_USE_STD_SHARED_PTR
#ifdef EIF_USE_STD_SHARED_PTR
#	include <memory>
#	define shared_ptr_type std::shared_ptr
#	define make_shared_function std::make_shared
#else
#	include "concurrency/rt_shared_ptr.hpp"
#	define shared_ptr_type eiffel_run_time::shared_ptr
#	define make_shared_function eiffel_run_time::make_shared
#endif

typedef EIF_REFERENCE marker_t(EIF_REFERENCE *);

void
mark_call_data(marker_t mark, call_data* call);

class eif_block_token
{
public:
  eif_block_token ()
  {
    EIF_ENTER_C;
  }

  ~eif_block_token()
  {
    EIF_EXIT_C;
    RTGC;
  }
};


class eif_lock : eif_block_token, public conditional_unique_lock_type
{
public:
  eif_lock (conditional_mutex_type &mutex) :
    eif_block_token (),
    conditional_unique_lock_type (mutex)
  {}
};

#endif // _EIF_UTILS_H
