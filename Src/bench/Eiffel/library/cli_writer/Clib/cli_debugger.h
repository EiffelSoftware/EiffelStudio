#ifndef __PE_DEBUGGER_H_
#define __PE_DEBUGGER_H_

#include "eif_eiffel.h"
#include <windows.h>
#include "cli_debugger_callback_id.h"

#ifdef __cplusplus
extern "C" {
#endif

extern EIF_POINTER new_cordebug ();

extern EIF_INTEGER dbg_timer_id ();
extern void dbg_init_synchro ();

extern void dbg_start_timer();
extern void dbg_stop_timer();
extern void dbg_timer_callback();
extern void dbg_lock_and_wait_callback ();
extern void dbg_debugger_before_callback(Callback_ids, BOOL);
extern void dbg_debugger_after_callback(Callback_ids);

#ifdef __cplusplus
}
#endif

#endif
