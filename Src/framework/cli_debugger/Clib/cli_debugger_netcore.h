#ifndef __CLI_DEBUGGER_NETCORE_H_
#define __CLI_DEBUGGER_NETCORE_H_

#include "eif_eiffel.h"
#include <windows.h>
#include <ole2.h>

#include "cli_cordebug.h"
#include "cli_debugger_headers.h"
#include "cli_debugger_callback_id.h"

#ifdef __cplusplus
extern "C" {
#endif

extern EIF_INTEGER initialize_debug_session (LPWSTR a_command_line, LPVOID a_env, LPCWSTR a_curr_dir, PDWORD a_proc_id, EIF_OBJECT cb_obj, EIF_POINTER cb_fct);
extern void* get_icor_debug();

#ifdef __cplusplus
}
#endif

#endif
