
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

