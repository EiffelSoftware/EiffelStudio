#ifndef _child_h_
#define _child_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_WIN32
extern STREAM *spawn_child(char *cmd, char *cwd, int handle_meltpath, HANDLE *child_process_handle, DWORD *child_process_id);
#else
extern STREAM *spawn_child(char *cmd, char *cwd, int handle_meltpath, Pid_t *child_pid);
#endif

#ifdef __cplusplus
}
#endif

#endif


