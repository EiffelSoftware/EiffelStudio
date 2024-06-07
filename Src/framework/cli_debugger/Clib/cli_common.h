#ifndef __CLI_COMMON_H_
#define __CLI_COMMON_H_

#include <objbase.h>

#ifdef _cplusplus
extern "C" {
#endif

extern BOOL is_netcore_debugging();
extern void set_is_netcore_debugging(BOOL v);

/* Do not compile with assertions, by default. */
#ifdef ISE_USE_ASSERT
#define EIF_ASSERTIONS
#endif
#ifndef EIF_ASSERTIONS
#define NDEBUG
#endif

/*  Interlocked protection */
#ifdef EIF_WINDOWS
#define LOCKED_VALUE(a) InterlockedExchangeAdd ((LONG*) &a, 0)
#define LOCKED_SET_VALUE(a,v) InterlockedExchange ((LONG*) &a, v)
#define LOCKED_INCREMENT_VALUE(a) InterlockedIncrement ((LONG*) &a)
#else
	/* See https://gcc.gnu.org/onlinedocs/gcc-4.4.3/gcc/Atomic-Builtins.html#Atomic-Builtins */
#define LOCKED_VALUE(a) a
#define LOCKED_SET_VALUE(a,v) a = v
#define LOCKED_INCREMENT_VALUE(a) a = a + 1
#endif

#define LOCKED_VALUE_IS_EQUAL(a,v) (LOCKED_VALUE(a) == v)
#define LOCKED_VALUE_IS_NOT_EQUAL(a,v) (LOCKED_VALUE(a) != v)

rt_private volatile LONG dbg_state ;
#define LOCKED_DBG_STATE_VALUE LOCKED_VALUE(dbg_state)
#define LOCKED_DBG_STATE_IS_EQUAL(v) (LOCKED_VALUE_IS_EQUAL(dbg_state, v))
#define LOCKED_DBG_STATE_IS_NOT_EQUAL(v) (LOCKED_VALUE_IS_NOT_EQUAL(dbg_state, v))
#define LOCKED_DBG_STATE_SET_VALUE(v) LOCKED_SET_VALUE(dbg_state, v)
#define LOCKED_DBG_STATE_INCREMENT  LOCKED_INCREMENT_VALUE(dbg_state)

#ifdef DBGTRACE_ENABLED

extern void trace_init ();
extern void trace_event (const char* mesg);
extern void trace_event (const char* mesg, const char* mesg2);
extern void trace_event_dbg_hr (const char* mesg,HRESULT hr);
extern void trace_event_dbg_dword (const char* mesg,DWORD dw);
extern void trace_event_dbg_pointer (const char* mesg, void* p);
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


#ifdef EIF_ASSERTIONS
	/* Error message for exceptions */
rt_private char message [1024];
	/* Raise an Eiffel exception */
#define raise_error(hr,pref,msg) { sprintf (message, "%s 0x%x: %s", pref, hr, msg); eraise (message, EN_PROG); }
#define CHECK(hr,msg) if (hr) raise_error (hr, "check", msg);
#define CHECKHR(cond, hr, msg) if (cond) raise_error (hr, "check", msg);
#define REQUIRE(cond,msg) if (!cond) raise_error (-1, "require", msg);
#define ENSURE(cond,msg) if (!cond) raise_error (-1, "ensure", msg);
#else
#define CHECK(hr,msg)
#define CHECKHR(cond,hr,msg)
#define REQUIRE(cond,msg)
#define ENSURE(cond,msg)
#endif

#ifdef _cplusplus
}
#endif

#endif // __CLI_COMMON_H_
