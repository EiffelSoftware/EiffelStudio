#include "cli_debugger_callback_id.h"
#ifdef _cplusplus
extern "C" {
#endif



rt_public char* Callback_name (e_callback_id id) {
	switch (id) {
		case CB_BREAKPOINT:
			return "breakpoint";
			break;
		case CB_STEP_COMPLETE:
			return "step_complete";
			break;
		case CB_BREAK:
			return "break";
			break;
		case CB_EXCEPTION:
			return "exception";
			break;
		case CB_EVAL_COMPLETE:
			return "eval_complete";
			break;
		case CB_EVAL_EXCEPTION:
			return "eval_exception";
			break;
		case CB_CREATE_PROCESS:
			return "create_process";
			break;
		case CB_EXIT_PROCESS:
			return "exit_process";
			break;
		case CB_CREATE_THREAD:
			return "create_thread";
			break;
		case CB_EXIT_THREAD:
			return "exit_thread";
			break;
		case CB_LOAD_MODULE:
			return "load_module";
			break;
		case CB_UNLOAD_MODULE:
			return "unload_module";
			break;
		case CB_LOAD_CLASS:
			return "load_class";
			break;
		case CB_UNLOAD_CLASS:
			return "unload_class";
			break;
		case CB_DEBUGGER_ERROR:
			return "debugger_error";
			break;
		case CB_LOG_MESSAGE:
			return "log_message";
			break;
		case CB_LOG_SWITCH:
			return "log_switch";
			break;
		case CB_CREATE_APP_DOMAIN:
			return "create_app_domain";
			break;
		case CB_EXIT_APP_DOMAIN:
			return "exit_app_domain";
			break;
		case CB_LOAD_ASSEMBLY:
			return "load_assembly";
			break;
		case CB_UNLOAD_ASSEMBLY:
			return "unload_assembly";
			break;
		case CB_CONTROL_CTRAP:
			return "control_ctrap";
			break;
		case CB_NAME_CHANGE:
			return "name_change";
			break;
		case CB_UPDATE_MODULE_SYMBOLS:
			return "update_module_symbols";
			break;
		case CB_EDIT_AND_CONTINUE_REMAP:
			return "edit_and_continue_remap";
			break;
		case CB_BREAKPOINT_SET_ERROR:
			return "breakpoint_set_error";
			break;
		default:
			return "unknown callback";
		}
}

#ifdef _cplusplus
}
#endif


