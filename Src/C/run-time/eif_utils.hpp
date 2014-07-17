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
	typedef std::mutex mutex_type;
#else
#	include "concurrency/rt_mutex.hpp"
	typedef eiffel_run_time::mutex mutex_type;
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


class eif_lock : eif_block_token, public std::unique_lock <std::mutex>
{
public:
  eif_lock (std::mutex &mutex) :
    eif_block_token (),
    std::unique_lock <std::mutex> (mutex)
  {}
};

#endif // _EIF_UTILS_H
