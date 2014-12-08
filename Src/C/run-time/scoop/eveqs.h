/* * EVE/Qs - A new runtime for the EVE SCOOP implementation
 * Copyright (C) 2014 Scott West <scott.gregory.west@gmail.com>
 *
 * This file is part of EVE/Qs.
 *
 * EVE/Qs is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * EVE/Qs is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with EVE/Qs.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _EVEQS_H
#define _EVEQS_H

#include "eif_portable.h"

#ifndef EIF_WINDOWS
#	include <stdint.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif
  typedef uint16_t spid_t;


  // 
  // Request chain operations
  //

  // RTS_RC (o) - create request group for o
  void
  eveqs_req_grp_new (spid_t client_pid);

  // RTS_RD (o) - delete chain (release locks?)
  void
  eveqs_req_grp_delete (spid_t client_pid);

  // RTS_RF (o) - wait condition fails
  void
  eveqs_req_grp_wait (spid_t client_pid);

  // RTS_RS (c, s) - add supplier s to current group for c
  void
  eveqs_req_grp_add_supplier (spid_t client_pid, spid_t supplier_pid);

  // RTS_RW (o) - sort all suppliers in the group and get exclusive access
  void
  eveqs_req_grp_lock (spid_t client_pid);

  // for RTS_OU
  int
  eveqs_is_uncontrolled (spid_t client_pid, spid_t supplier_pid);

  //
  // Processor creation
  //

  // RTS_PA
  void
  eveqs_processor_fresh (void *);

  //
  // Call logging
  //

  int
  eveqs_is_uncontrolled(spid_t client_pid, spid_t supplier_pid);

  // eif_log_call
  void
  eveqs_call_on (spid_t client_pid, spid_t supplier_pid, void* data);

  int
  eveqs_is_synced_on (spid_t client_pid, spid_t supplier_pid);

  //
  // Callback from garbage collector to indicate that the
  // processor isn't used anymore.
  //
  void
  eveqs_unmarked(spid_t pid);

  void
  eveqs_enumerate_live ();

  void
  eveqs_mark_all (char* (*marker)(char**));

#ifdef __cplusplus
}
#endif
#endif /* _EVEQS_H */
