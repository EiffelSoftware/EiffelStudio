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
#include <mutex>
#include "eif_macros.h"

#define EIF_USE_STD_MUTEX
#ifdef EIF_USE_STD_MUTEX
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
