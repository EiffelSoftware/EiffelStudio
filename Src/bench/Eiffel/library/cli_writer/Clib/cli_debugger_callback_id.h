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
	CB_NONE=0,
	CB_BREAKPOINT,
	CB_STEP_COMPLETE,
	CB_BREAK,
	CB_EXCEPTION,
	CB_EVAL_COMPLETE,
	CB_EVAL_EXCEPTION,
	CB_CREATE_PROCESS,
	CB_EXIT_PROCESS,
	CB_CREATE_THREAD,
	CB_EXIT_THREAD,
	CB_LOAD_MODULE,
	CB_UNLOAD_MODULE,
	CB_LOAD_CLASS,
	CB_UNLOAD_CLASS,
	CB_DEBUGGER_ERROR,
	CB_LOG_MESSAGE,
	CB_LOG_SWITCH,
	CB_CREATE_APP_DOMAIN,
	CB_EXIT_APP_DOMAIN,
	CB_LOAD_ASSEMBLY,
	CB_UNLOAD_ASSEMBLY,
	CB_CONTROL_CTRAP,
	CB_NAME_CHANGE,
	CB_UPDATE_MODULE_SYMBOLS,
	CB_EDIT_AND_CONTINUE_REMAP,
	CB_BREAKPOINT_SET_ERROR,

	CB_DEBUG_EVENT
	};
typedef enum e_callback_id Callback_ids;
extern char* Callback_name (Callback_ids id);

#endif
