#ifndef __PE_DEBUGGER_H_
#define __PE_DEBUGGER_H_

#include "eif_eiffel.h"
#include <windows.h>

#include "cli_debugger_callback_id.h"

#ifdef __cplusplus
extern "C" {
#endif

extern EIF_INTEGER get_cordebug (LPWSTR a_dbg_version, EIF_POINTER ** );
extern EIF_INTEGER dbg_continue (void*, BOOL);

extern EIF_INTEGER dbg_timer_id ();
extern EIF_BOOLEAN dbg_is_synchronizing();
extern void dbg_init_synchro();
extern void dbg_notify_from_estudio(char*);
extern void dbg_terminate_synchro ();
extern void dbg_disable_next_estudio_notification();

extern void dbg_enable_estudio_callback (EIF_OBJECT estudio_cb_obj, EIF_POINTER estudio_cb_event);

extern void dbg_start_timer();
extern void dbg_stop_timer();
extern void dbg_restore_cb_notification_state ();
extern void CALLBACK dbg_timer_callback (HWND hwnd, UINT uMsg, UINT idEvent, DWORD dwTime);
extern void dbg_lock_and_wait_callback (void*);
extern void dbg_debugger_before_callback(Callback_ids);
extern void dbg_debugger_after_callback(Callback_ids);

#ifdef __cplusplus
}
#endif

#endif
