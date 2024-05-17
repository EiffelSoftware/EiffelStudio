#ifndef __CLI_DEBUGGER_FRAMEWORK_H_
#define __CLI_DEBUGGER_FRAMEWORK_H_

#include "eif_eiffel.h"
#include <windows.h>
#include <ole2.h>
#include <mscoree.h>

#include <eif_lmalloc.h>
#include "cli_cordebug.h"
#include "cli_debugger_headers.h"
#include "cli_debugger_callback_id.h"
#include "cli_common.h"

#ifdef __cplusplus
extern "C" {
#endif

extern EIF_INTEGER get_cordebug (LPWSTR a_dbg_version, EIF_POINTER ** );

#ifdef __cplusplus
}
#endif

#endif
