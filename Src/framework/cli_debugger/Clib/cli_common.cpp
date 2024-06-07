#include <stdio.h>

#include <eif_lmalloc.h>
#include "cli_common.h"

#ifdef _cplusplus
extern "C" {
#endif

/* Debugging info */
rt_private BOOL m_dbg_is_netcore = FALSE;
rt_public BOOL is_netcore_debugging() {
	return m_dbg_is_netcore;
};
rt_public void set_is_netcore_debugging(BOOL v) {
	m_dbg_is_netcore = v;
}

/*
//////////////////////////////////////////////////
/// Tracing debug output                       ///
//////////////////////////////////////////////////
*/

#ifdef DBGTRACE_ENABLED
#define CLI_MUTEX_TYPE	CRITICAL_SECTION

rt_private CLI_MUTEX_TYPE *trace_mutex;
rt_private LONG dbg_msg_displayed_index;

#define CLI_MUTEX_CREATE(m,msg) \
		if (m == NULL) { 	\
    	m = (CLI_MUTEX_TYPE *) eif_malloc (sizeof(CLI_MUTEX_TYPE)); \
		InitializeCriticalSection(m);	\
		}
#define CLI_MUTEX_LOCK(m,msg) \
		EnterCriticalSection(m)
#define CLI_MUTEX_UNLOCK(m,msg) \
		LeaveCriticalSection(m)
#define CLI_MUTEX_DESTROY(m,msg) \
		DeleteCriticalSection(m); \
		eif_free(m)

#define LOCK_DEBUG_OUTPUT_ACCESS CLI_MUTEX_LOCK(trace_mutex, "")
#define UNLOCK_DEBUG_OUTPUT_ACCESS CLI_MUTEX_UNLOCK(trace_mutex, "")

rt_public void trace_init ()
{
	CLI_MUTEX_CREATE(trace_mutex, "");
}
rt_public void trace_event (const char* mesg)
{
  FILE *out;

  LOCK_DEBUG_OUTPUT_ACCESS;
  dbg_msg_displayed_index = dbg_msg_displayed_index + 1;

  out=fopen("eif_debugger.out","a+");
  fprintf(out,"%d:%d - <%d>%s\n",
		  			dbg_msg_displayed_index,
					GetCurrentThreadId(),
					LOCKED_DBG_STATE_VALUE,
					mesg
					);
  fclose(out);
  UNLOCK_DEBUG_OUTPUT_ACCESS;
}
rt_public void trace_event (const char* mesg, const char* mesg2)
{
  FILE *out;

  LOCK_DEBUG_OUTPUT_ACCESS;
  dbg_msg_displayed_index = dbg_msg_displayed_index + 1;
  out=fopen("eif_debugger.out","a+");
  fprintf(out,"%d:%d - <%d>%s %s\n",
		  			dbg_msg_displayed_index,
					GetCurrentThreadId(),
					LOCKED_DBG_STATE_VALUE,
					mesg, mesg2
					);
  fclose(out);
  UNLOCK_DEBUG_OUTPUT_ACCESS;
}
rt_public void trace_event_dbg_hr (const char* mesg, HRESULT hr)
{
  FILE *out;
  LOCK_DEBUG_OUTPUT_ACCESS;
  dbg_msg_displayed_index = dbg_msg_displayed_index + 1;
  out=fopen("eif_debugger.out","a+");
  fprintf(out,"%d:%d - <%d>%s %d\n",
		  			dbg_msg_displayed_index,
		  			GetCurrentThreadId(),
					LOCKED_DBG_STATE_VALUE,
					mesg,
					hr
					);
  fclose(out);
  UNLOCK_DEBUG_OUTPUT_ACCESS;
}
rt_public void trace_event_dbg_dword (const char* mesg, DWORD dw)
{
  FILE *out;
  LOCK_DEBUG_OUTPUT_ACCESS;
  dbg_msg_displayed_index = dbg_msg_displayed_index + 1;
  out=fopen("eif_debugger.out","a+");
  fprintf(out,"%d:%d - <%d>%s %d \n",
		  			dbg_msg_displayed_index,
		  			GetCurrentThreadId(),
					LOCKED_DBG_STATE_VALUE,
					mesg,
					dw
					);
  fclose(out);
  UNLOCK_DEBUG_OUTPUT_ACCESS;
}

rt_public void trace_event_dbg_pointer (const char* mesg, void* p)
{
  FILE *out;
  LOCK_DEBUG_OUTPUT_ACCESS;
  dbg_msg_displayed_index = dbg_msg_displayed_index + 1;
  out=fopen("eif_debugger.out","a+");
  fprintf(out,"%d:%d - <%d>%s %p \n",
		  			dbg_msg_displayed_index,
		  			GetCurrentThreadId(),
					LOCKED_DBG_STATE_VALUE,
					mesg,
					p
					);
  fclose(out);
  UNLOCK_DEBUG_OUTPUT_ACCESS;
}

#endif

#ifdef _cplusplus
}
#endif

