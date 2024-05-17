#ifndef __CLI_DEBUGGER_H_
#define __CLI_DEBUGGER_H_

#include "eif_eiffel.h"
#include <windows.h>
#include <ole2.h>

#include "cli_debugger_callback_id.h"

#ifdef __cplusplus
extern "C" {
#endif

struct CorDbgCallbackInfo_item {
	union {
		IUnknown* itu_ptr;
		EIF_INTEGER itu_int;
	};
};

struct CorDbgCallbackInfo {
	Callback_ids callback_id;
	struct CorDbgCallbackInfo_item * items;
};
extern struct CorDbgCallbackInfo * dbg_cb_info;
extern void clear_dbg_cb_info();
extern void reset_dbg_cb_info();
#define CLEAR_DBG_CB_INFO clear_dbg_cb_info();
#define RESET_DBG_CB_INFO reset_dbg_cb_info();
#define SET_DBG_CB_INFO_CALLBACK_ID(v) dbg_cb_info->callback_id = v;
#define SET_DBG_CB_INFO_POINTER(index,v) dbg_cb_info->items[index - 1].itu_ptr = v;
#define SET_DBG_CB_INFO_INTEGER(index,v) dbg_cb_info->items[index - 1].itu_int = v;
#define SET_DBG_CB_INFO_DWORD(index,v) dbg_cb_info->items[index - 1].itu_int = v;
#define SET_DBG_CB_INFO_BOOL(index,v) dbg_cb_info->items[index - 1].itu_int = v;
#define DBG_CB_INFO_POINTER_ITEM(index) dbg_cb_info->items[index - 1].itu_ptr
#define DBG_CB_INFO_INTEGER_ITEM(index) dbg_cb_info->items[index - 1].itu_int

extern EIF_INTEGER dbg_timer_id ();
extern EIF_BOOLEAN dbg_is_synchronizing();
extern void dbg_init_synchro(HWND hWnd);
extern void dbg_notify_from_estudio(char*);
extern void dbg_terminate_synchro ();

extern void dbg_enable_estudio_callback (EIF_OBJECT estudio_cb_obj, EIF_POINTER estudio_cb_event);

extern void dbg_start_timer();
extern void dbg_stop_timer();
extern void dbg_restore_cb_notification_state ();
extern EIF_INTEGER dbg_continue (void*, BOOL);
extern void dbg_process_evaluation (void*, void*, EIF_INTEGER);
extern void dbg_begin_callback(Callback_ids);
extern void dbg_finish_callback(Callback_ids);

extern void CALLBACK dbg_timer_callback (HWND hwnd, UINT uMsg, UINT idEvent, DWORD dwTime);

#ifdef __cplusplus
}
#endif

#endif
