#ifndef __PE_DEBUGGER_H_
#define __PE_DEBUGGER_H_

#include "eif_eiffel.h"
#include <windows.h>

#ifdef __cplusplus
extern "C" {
#endif

extern EIF_POINTER new_cordebug ();

extern EIF_INTEGER dbg_timer_id ();
extern void dbg_start_timer();
extern void dbg_stop_timer();
extern void dbg_timer_callback();
extern void dbg_debugger_before_callback(char *);
extern void dbg_debugger_after_callback(char *);

#ifdef __cplusplus
}
#endif

#endif
