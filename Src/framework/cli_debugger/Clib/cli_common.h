#ifndef __CLI_COMMON_H_
#define __CLI_COMMON_H_

#include <objbase.h>

#ifdef _cplusplus
extern "C" {
#endif

/* Do not compile with assertions, by default. */
#ifdef ISE_USE_ASSERT
#define EIF_ASSERTIONS
#endif
#ifndef EIF_ASSERTIONS
#define NDEBUG
#endif

/*  Interlocked protection */
#define LOCKED_VALUE(a) InterlockedExchangeAdd ((LONG*) &a, 0)
#define LOCKED_SET_VALUE(a,v) InterlockedExchange ((LONG*) &a, v)
#define LOCKED_INCREMENT_VALUE(a) InterlockedIncrement ((LONG*) &a)
#define LOCKED_VALUE_IS_EQUAL(a,v) (InterlockedExchangeAdd ((LONG*) &a, 0) == v)
#define LOCKED_VALUE_IS_NOT_EQUAL(a,v) (InterlockedExchangeAdd ((LONG*) &a, 0) != v)

rt_private volatile LONG dbg_state ;
#define LOCKED_DBG_STATE_VALUE LOCKED_VALUE(dbg_state)
#define LOCKED_DBG_STATE_IS_EQUAL(v) (LOCKED_VALUE_IS_EQUAL(dbg_state, v))
#define LOCKED_DBG_STATE_IS_NOT_EQUAL(v) (LOCKED_VALUE_IS_NOT_EQUAL(dbg_state, v))
#define LOCKED_DBG_STATE_SET_VALUE(v) LOCKED_SET_VALUE(dbg_state, v)
#define LOCKED_DBG_STATE_INCREMENT  LOCKED_INCREMENT_VALUE(dbg_state)

#ifdef DBGTRACE_ENABLED

extern void trace_init ();
extern void trace_event (char* mesg);
extern void trace_event (char* mesg, char* mesg2);
extern void trace_event_dbg_hr (char* mesg,HRESULT hr);
extern void trace_event_dbg_dword (char* mesg,DWORD dw);
extern void trace_event_dbg_pointer (char* mesg, void* p);
#endif

#ifdef DBGTRACE_ENABLED
#	 define DBGTRACE(msg) trace_event(msg);
#	 define DBGTRACE2(msg,msg2) trace_event(msg, msg2);
#	 define DBGTRACE_HR(msg1,hr) trace_event_dbg_hr(msg1, hr);
#	 define DBGTRACE_DWORD(msg1,dw) trace_event_dbg_dword(msg1, dw);
#	 define DBGTRACE_PTR(msg,p) trace_event_dbg_pointer(msg, p);
#else
#	 define DBGTRACE(msg)
#	 define DBGTRACE2(msg,msg2)
#	 define DBGTRACE_HR(msg,hr)
#	 define DBGTRACE_DWORD(msg,dw)
#	 define DBGTRACE_PTR(msg,p)
#endif

#ifdef DBGTRACE_ENABLED
rt_private UINT once_enter_cb;
rt_private UINT once_enter_ec_cb;
#endif



#ifdef _cplusplus
}
#endif

#endif // __CLI_COMMON_H_
