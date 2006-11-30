/*
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"

*/

/* Timer-related routines which are called from Eiffel. */

#include <eif_eiffel.h>
#include <signal.h>
#include <errno.h>
#include "unix_os.h"

void (* old_handler) (int);	/* Signal handler installed by ISE Eiffel */

EIF_POINTER current_expired_field = NULL;	
				/* Pointer to `is_expired' field of virtual
				   interval timer which is currently using 
				   the system interval timer */

/* Set `current_expired_field' to `f' */

void pass_current_timer_to_c (EIF_POINTER f) {
  current_expired_field = f;
}

/* Set `current_expired_field' to NULL */

void pass_void_timer_to_c (void) {
  current_expired_field = NULL;
}

void set_boolean_value(EIF_POINTER addr, EIF_BOOLEAN val) {
  * (EIF_BOOLEAN *) addr = val;
}

EIF_BOOLEAN boolean_value(EIF_POINTER addr) {
  return * (EIF_BOOLEAN *) addr;
}

/* Handler for SIGALARM signal */

void sigalrm_handler (int sig) {
  
  /* First set `is_expired' attribute in `current_interval_timer' */
  
  if (current_expired_field != NULL) {
    set_boolean_value(current_expired_field, EIF_TRUE);
  }
  
  /* Then call ISE's signal handler */
  
  (*old_handler) (sig);
}

void record_original_alarm_signal_handler (void) {
  int rc;
  struct sigaction action;

  rc = sigaction(SIGALRM, NULL, &action);
  if (rc == -1) {
    eraise(error_description(errno), EN_SYS);
  }
  old_handler = action.sa_handler;
}

void set_original_alarm_signal_handler (void) {
  (void) signal(SIGALRM, old_handler);
}

void set_new_alarm_signal_handler (void) {
  (void) signal(SIGALRM, &sigalrm_handler);
}

