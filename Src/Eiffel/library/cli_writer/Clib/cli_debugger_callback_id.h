#ifndef __PE_DEBUGGER_CALLBACK_ID_H_
#define __PE_DEBUGGER_CALLBACK_ID_H_

#include "eif_eiffel.h"

//extern const int Cb_exception_id;
//extern const int Cb_breakpoint_id;
//extern const int Cb_step_complete_id;
//extern const int Cb_break_id;
//extern const int Cb_exception_id;
//extern const int Cb_eval_complete_id;
//extern const int Cb_eval_exception_id;
//extern const int Cb_create_process_id;
//extern const int Cb_exit_process_id;
//extern const int Cb_create_thread_id;
//extern const int Cb_exit_thread_id;
//extern const int Cb_load_module_id;
//extern const int Cb_unload_module_id;
//extern const int Cb_load_class_id;
//extern const int Cb_unload_class_id;
//extern const int Cb_debugger_error_id;
//extern const int Cb_log_message_id;
//extern const int Cb_log_switch_id;
//extern const int Cb_create_app_domain_id;
//extern const int Cb_exit_app_domain_id;
//extern const int Cb_load_assembly_id;
//extern const int Cb_unload_assembly_id;
//extern const int Cb_control_ctrap_id;
//extern const int Cb_name_change_id;
//extern const int Cb_update_module_symbols_id;
//extern const int Cb_edit_and_continue_remap_id;
//extern const int Cb_breakpoint_set_error_id;


enum e_callback_id {
/*  0 */	CB_NONE=0,				
/*  1 */	CB_BREAKPOINT,			
/*  2 */	CB_STEP_COMPLETE,		
/*  3 */	CB_BREAK,				
/*  4 */	CB_EXCEPTION,			
/*  5 */	CB_EVAL_COMPLETE,		
/*  6 */	CB_EVAL_EXCEPTION,		
/*  7 */	CB_CREATE_PROCESS,		
/*  8 */	CB_EXIT_PROCESS,		
/*  9 */	CB_CREATE_THREAD,
/* 10 */	CB_EXIT_THREAD,
/* 11 */	CB_LOAD_MODULE,
/* 12 */	CB_UNLOAD_MODULE,
/* 13 */	CB_LOAD_CLASS,
/* 14 */	CB_UNLOAD_CLASS,
/* 15 */	CB_DEBUGGER_ERROR,
/* 16 */	CB_LOG_MESSAGE,
/* 17 */	CB_LOG_SWITCH,
/* 18 */	CB_CREATE_APP_DOMAIN,
/* 19 */	CB_EXIT_APP_DOMAIN,
/* 20 */	CB_LOAD_ASSEMBLY,
/* 21 */	CB_UNLOAD_ASSEMBLY,
/* 22 */	CB_CONTROL_CTRAP,
/* 23 */	CB_NAME_CHANGE,
/* 24 */	CB_UPDATE_MODULE_SYMBOLS,
/* 25 */	CB_EDIT_AND_CONTINUE_REMAP,
/* 26 */	CB_BREAKPOINT_SET_ERROR,

/* 27 */	CB2_FUNCTION_REMAP_OPPORTUNITY,
/* 28 */	CB2_CREATE_CONNECTION,
/* 29 */	CB2_CHANGE_CONNECTION,
/* 30 */	CB2_DESTROY_CONNECTION,
/* 31 */	CB2_EXCEPTION,
/* 32 */	CB2_EXCEPTION_UNWIND,
/* 33 */	CB2_FUNCTION_REMAP_COMPLETE,
/* 34 */	CB2_MDANOTIFICATION,

/* 35 */	CB_DEBUG_EVENT
	};
typedef enum e_callback_id Callback_ids;
extern char* Callback_name (Callback_ids id);

#endif
