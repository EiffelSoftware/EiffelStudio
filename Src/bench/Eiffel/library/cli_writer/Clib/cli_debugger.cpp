#include <objbase.h>

#include "cli_debugger.h"
#include <objbase.h>
#include <cor.h>

#include <cordebug.h>

#include <mscoree.h>

#ifdef _cplusplus
extern "C" {
#endif

rt_private LONG dbg_state;

rt_private char message [1024];
	/* Error message for exceptions */

#ifdef ASSERTIONS
rt_private void raise_error (HRESULT hr, char *msg); /* Raise error */
#define CHECK(hr,msg) if (hr) raise_error (hr, msg);
#else
#define CHECK(hr,msg)
#endif

/*
feature -- COM specific
*/

#ifdef ASSERTIONS
rt_private void raise_error (HRESULT hr, char *msg)
	/* Raise an Eiffel exception */
{
	sprintf (message, "0x%x: %s", hr, msg);
	eraise (message, EN_PROG);
}
#endif



////////////////////////////////////////////////////////////////////////////

#ifdef DBGTRACE_ENABLED
rt_private pthread_mutex_t trace_mutex;

rt_public void trace_event (char* mesg)
{
  FILE *out;

//  WaitForSingleObject (trace_mutex, INFINITE); 
  out=fopen("eif_debugger.out","a+");
  fprintf(out,"<%d>%s\n",dbg_state, mesg);
  fclose(out);
  //ReleaseMutex (trace_mutex);
}
#endif

#ifdef DBGTRACE_ENABLED
#define DBGTRACE(msg) trace_event(msg);
#else
#define DBGTRACE(msg)
#endif

////////////////////////////////////////////////////////////////////////////

//CorDebug------------------------------------------------------------------

rt_public EIF_POINTER new_cordebug ()
	/* Create new instance of ICorDebug */
{
	HRESULT hr;
	ICorDebug *icd;

//    CoInitializeEx(NULL, COINIT_APARTMENTTHREADED);
//COINIT_MULTITHREADED
	

	hr = CoCreateInstance (CLSID_CorDebug, NULL,
		CLSCTX_INPROC_SERVER, IID_ICorDebug, (void **) & icd);

	CHECK (hr, "Could not create ICorDebug")

	return icd;
}

/**************************************************************************/
/* Synchronisation */

rt_private UINT once_enter_cb;
rt_private UINT once_enter_ec_cb;
rt_private UINT dbg_timer;
	// Timer ID for dbg synchro

//rt_private LONG dbg_state;
	// default: 0
	// 1 : ec is waiting for dbg
	// 2 : dbg has starting his processing, ec is waiting for dbg to finish
	// 3 : dbg is done, dbg waiting

rt_public EIF_INTEGER dbg_timer_id () {
	return (EIF_INTEGER) dbg_timer;
}

rt_public void dbg_start_timer () {
	DBGTRACE("[Debugger] start timer");
	dbg_state = 0;
#ifdef DBGTRACE_ENABLED
	once_enter_ec_cb = 0;
	once_enter_cb = 0;
#endif
	dbg_timer = SetTimer (NULL, 0 /* ignored with HWnd NULL */, 10 /* millisecond */, (TIMERPROC) dbg_timer_callback);
	CHECK (dbg_timer == 0, "Could not create dbg_timer")
}

rt_public void dbg_stop_timer () {
	BOOL hr;
	DBGTRACE("[Debugger] stop timer");
	hr = KillTimer (NULL, dbg_timer);
	dbg_timer = 0;

	CHECK (hr == 0, "Could not kill dbg_timer")
}

rt_public void dbg_timer_callback () {
//	DBGTRACE("[Debugger|EC] timer callback");
	if (InterlockedExchangeAdd (&dbg_state, 0) != 1) {
#ifdef DBGTRACE_ENABLED
		if (once_enter_ec_cb == 0) {
			DBGTRACE("1 - [Debugger|EC] ec waiting for dbg_state to be 1");
			once_enter_ec_cb = (once_enter_ec_cb + 1) % 100;
		}
#endif
		return;
	} else {
		DBGTRACE("4 - [Debugger|EC] ec going to wait soon");
		dbg_stop_timer ();
		InterlockedIncrement (&dbg_state);
		DBGTRACE("5 - [Debugger|EC] enter ec waiting");
		while (InterlockedExchangeAdd (&dbg_state, 0) == 2) {
			// ec wait until dbg is done
//			DBGTRACE("[Debugger] ec wait .. sleep(1)");
			Sleep (1); // maybe useless, spinlock instead ..
		}
		DBGTRACE("9 - [Debugger|EC] exit ec waiting");
		InterlockedIncrement (&dbg_state);
		dbg_start_timer (); // dbg_state := 0
	}
}

rt_public void dbg_debugger_before_callback (char* callback_id) {
	DBGTRACE("<<<<<<<<<<<<<<<<<<<<<<<<");
	DBGTRACE(callback_id);
	// It is not possible to have 2 callbacks at the same time, 
	// since it is supposed to be in the same thread ...
	while (InterlockedExchangeAdd (&dbg_state, 0) == 3) {
#ifdef DBGTRACE_ENABLED
		if (once_enter_cb == 0) {
			DBGTRACE("1.5 - [Debugger|DBG] wait at entrance door");
			once_enter_cb = 1;
		}
#endif
	}
	once_enter_cb = 0;
	// Let's tell the timer we are ready
	DBGTRACE("2 - [Debugger|DBG] enter dbg callback");
	InterlockedExchange (&dbg_state, 1);
	DBGTRACE("3 - [Debugger|DBG] now dbg_state is 1, it is ec's turn");
	while (InterlockedExchangeAdd (&dbg_state, 0) == 1) {
		// Dbg wait for the Ec to call back
		// no sleep for a spinlock (active waiting)
//		DBGTRACE("[Debugger|DBG] spinlock :: dbg callback");
	}

	DBGTRACE("6 - [Debugger|DBG] start execution callback");
	// Executing callback code
	// ...
	// and then come back by dbg_debugger_after_callback ...
}

rt_public void dbg_debugger_after_callback (char * callback_id) {
	DBGTRACE(callback_id);
	DBGTRACE("7 - [Debugger|DBG] finish execution callback");
	InterlockedIncrement (&dbg_state);
	// Callback done
	DBGTRACE("8 - [Debugger|DBG] exit callback");
	DBGTRACE(">>>>>>>>>>>>>>>>>>>>>>>>");
}

#ifdef _cplusplus
}
#endif
