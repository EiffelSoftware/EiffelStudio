#include <objbase.h>

#include "cli_debugger.h"
#include <objbase.h>
#include <cor.h>

#include <cordebug.h>

#include <mscoree.h>

#ifdef _cplusplus
extern "C" {
#endif

rt_private BOOL dbg_last_callback_is_about_eval;

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
//rt_private pthread_mutex_t trace_mutex;

rt_private LONG dbg_msg_displayed_index;
rt_public void trace_event (char* mesg)
{
  FILE *out;

  dbg_msg_displayed_index = dbg_msg_displayed_index + 1;

  out=fopen("eif_debugger.out","a+");
  fprintf(out,"%d - <%d|%d>%s\n",
		  			dbg_msg_displayed_index, 
					dbg_state, 
					dbg_last_callback_is_about_eval,  
					mesg
					);
  fclose(out);
}
rt_public void trace_event (char* mesg, char* mesg2)
{
  FILE *out;

  dbg_msg_displayed_index = dbg_msg_displayed_index + 1;
  out=fopen("eif_debugger.out","a+");
  fprintf(out,"%d - <%d|%d>%s %s\n",
		  			dbg_msg_displayed_index, 
					dbg_state, 
					dbg_last_callback_is_about_eval,  
					mesg, mesg2
					);
  fclose(out);
}
rt_public void trace_event_dbg_hr (char* mesg,HRESULT hr)
{
  FILE *out;
  out=fopen("eif_debugger.out","a+");
  fprintf(out,"<HR=%d> %s \n",
					hr,
					mesg
					);
  fclose(out);
}
#endif

#ifdef DBGTRACE_ENABLED
#define DBGTRACE(msg) trace_event(msg);
#define DBGTRACE2(msg,msg2) trace_event(msg, msg2);
#define DBGTRACE_HR(msg1,hr) trace_event_dbg_hr(msg1, hr);
#else
#define DBGTRACE(msg)
#define DBGTRACE2(msg,msg2)
#define DBGTRACE_HR(msg,hr)
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

//	CHECK (hr, "Could not create ICorDebug")

	DBGTRACE_HR("@@@ [DEBUGGER] New ICorDebug ", hr);

	CHECK ((((hr == S_OK) || (hr == S_FALSE)) ? 0 : 1), "Could not create ICorDebug");
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
	CHECK (dbg_timer != 0, "Require: timer = 0 (OFF)")
	DBGTRACE("[Debugger] start timer");/*D*/
	dbg_state = 0;
#ifdef DBGTRACE_ENABLED	/*D*/
	once_enter_ec_cb = 0;/*D*/
	once_enter_cb = 0;/*D*/
#endif	/*D*/
	dbg_timer = SetTimer (NULL, 0 /* ignored with HWnd NULL */, 
			10 /* millisecond */, (TIMERPROC) dbg_timer_callback);
	CHECK (dbg_timer == 0, "Could not create dbg_timer")
}

rt_public void dbg_stop_timer () {
	BOOL hr;
	CHECK (dbg_timer == 0, "Require: timer /= 0 (ON)")
	DBGTRACE("[Debugger] stop timer");/*D*/
	hr = KillTimer (NULL, dbg_timer);
	dbg_timer = 0;

#ifdef DBGTRACE_ENABLED	/*D*/
	once_enter_ec_cb = 0;/*D*/
	once_enter_cb = 0;/*D*/
#endif	/*D*/

	CHECK (hr == 0, "Could not kill dbg_timer")
}

rt_public void dbg_timer_callback () {
//	DBGTRACE("[Debugger|EC] timer callback");
	if (InterlockedExchangeAdd (&dbg_state, 0) != 1) {
//<not 1>---------------------------------------------------------//
#ifdef DBGTRACE_ENABLED	/*D*/
		once_enter_ec_cb = (once_enter_ec_cb + 1) % 100;/*D*/
		if (once_enter_ec_cb == 0) {/*D*/
//			DBGTRACE("((((((((((((((((((((((((((((((((((((((((((((((((((((");/*D*/
			DBGTRACE("1.-.[Debugger|EC] ec waiting for dbg_state to be 1 ");/*D*/
		}/*D*/
#endif	/*D*/
		return;
	} else {
		once_enter_ec_cb = 0;/*D*/
//<1>---< dbg waiting >------------------------------------------//
		DBGTRACE("4 - [Debugger|EC] ec going to wait soon");/*D*/
		DBGTRACE("4 - [Debugger|EC] ec stop timer");/*D*/
		dbg_stop_timer ();

		DBGTRACE("4 - [Debugger|EC] ec give hand to dbg");/*D*/
		InterlockedIncrement (&dbg_state);
//<2>---< give hand to dbg >-------------------------------------//
		DBGTRACE("4 - [Debugger|EC] ec waiting while dbg_state = 2");/*D*/
		while (InterlockedExchangeAdd (&dbg_state, 0) == 2) {
//<2>---< wait for dbg to be done with execution >---------------//
			// ec wait until dbg is done
#ifdef DBGTRACE_ENABLED	/*D*/
			if (once_enter_ec_cb == 0) {/*D*/
				DBGTRACE("5 - [Debugger|EC] ec wait dbg to be done : dbg_state /= 2");/*D*/
				once_enter_ec_cb = (once_enter_ec_cb + 1) % 100;/*D*/
			}/*D*/
#endif	/*D*/
			Sleep (1); // maybe useless, spinlock instead ..
		}
//<3>------------------------------------------------------------//
		DBGTRACE("9 - [Debugger|EC] exit ec waiting for dbg_state /= 2");/*D*/
		DBGTRACE("))))))))))))))))))))))))))))))))))))))))))))))))))");/*D*/
		InterlockedIncrement (&dbg_state);
		DBGTRACE("9 - [Debugger|EC] ec restart timer");/*D*/
		dbg_start_timer (); // dbg_state := 0
	}
}

rt_public void dbg_lock_and_wait_callback () {
	/*** Local  ***/
	UINT once_enter;
	BOOL eval_callback_proceed;

	/*** Require  ***/
	CHECK (dbg_timer != 0, "Require : Timer should be disable in this context (evaluating)")
	if (dbg_timer == 0) {/*D*/
		DBGTRACE("?EVAL? Timer is OFF => OK");/*D*/
	} else {/*D*/
		DBGTRACE("?EVAL? Timer is ON => ERROR");/*D*/
	}/*D*/

	/*** Do  ***/

	DBGTRACE("?EVAL?========================================");/*D*/
	DBGTRACE("?EVAL? - [Debugger|EC] force wait for callback");/*D*/

	// Initialize data
	// at begining we don't care about past
	eval_callback_proceed = false;


	while (!eval_callback_proceed) {
		// While we haven't reach "eval callback", and proceed it 

		once_enter = 0; /*D*/
		while (InterlockedExchangeAdd (&dbg_state, 0) != 1) {
			if (once_enter == 0) {/*D*/
				DBGTRACE("?EVAL? - [Debugger|EC] waiting for callback begin (state = 1)");/*D*/
				once_enter = 1;/*D*/
			}/*D*/
			Sleep (1);
		}
		
		// now check if last callback is about evaluating
		// only now, after synchronized with debugger, otherwise we may missed one
		eval_callback_proceed = dbg_last_callback_is_about_eval;
		// if eval callback occured, we must exit after this loop 
		// but we need to do this at least once

		DBGTRACE("?EVAL? - [Debugger|EC] call back arrived, dbg waiting");/*D*/
		InterlockedIncrement (&dbg_state);

		once_enter = 0;/*D*/
		while (InterlockedExchangeAdd (&dbg_state, 0) == 2) {
			if (once_enter == 0) {/*D*/
				DBGTRACE("?EVAL? - [Debugger|EC] waiting for callback finished (state = 3)");/*D*/
				once_enter = 1;/*D*/
			}/*D*/
			Sleep (1); // maybe useless, spinlock instead ..
		}
		DBGTRACE("?EVAL? - [Debugger|EC] call back finished");/*D*/
		InterlockedIncrement (&dbg_state);
		DBGTRACE("?EVAL? - [Debugger|EC] eval finished");/*D*/
	}
	DBGTRACE("?EVAL? LAST CALLBACK = EVAL Done !!!");/*D*/

//	dbg_start_timer (); // dbg_state := 0
//	Must be done by Eiffel Side

	/*** Ensure ***/
	CHECK (!dbg_last_callback_is_about_eval, "Ensure : Last callback should be about evaluating")
	/*** End  ***/
}

rt_public void dbg_debugger_before_callback (char* callback_id, BOOL is_eval_callback) {
	if (is_eval_callback) { DBGTRACE("<< is_eval_callback  >>"); }/*D*/
	dbg_last_callback_is_about_eval = is_eval_callback;
	DBGTRACE("<<<<<<<<<<<<<<<<<<<<<<<<");/*D*/
	DBGTRACE2("CALLBACK = ", callback_id);/*D*/
	// It is not possible to have 2 callbacks at the same time, 
	// since it is supposed to be in the same thread ...
	while (InterlockedExchangeAdd (&dbg_state, 0) == 3) {
//<3>---< wait for ec to finish >--------------------------------//
#ifdef DBGTRACE_ENABLED	/*D*/
		if (once_enter_cb == 0) {/*D*/
			DBGTRACE("1.5 - [Debugger|DBG] wait at entrance door");/*D*/
			once_enter_cb = 1;/*D*/
		}/*D*/
#endif	/*D*/
	}
	// we set it again, in case this is unset by dbg_stop_timer
	dbg_last_callback_is_about_eval = is_eval_callback;
	once_enter_cb = 0;/*D*/
	// Let's tell the timer we are ready
	DBGTRACE("2 - [Debugger|DBG] enter dbg callback");/*D*/
	InterlockedExchange (&dbg_state, 1);
//<1>---< give hand to ec >--------------------------------------//
	DBGTRACE("3 - [Debugger|DBG] now dbg_state is 1, it is ec's turn");/*D*/
	while (InterlockedExchangeAdd (&dbg_state, 0) == 1) {
//<1>---< wait for ec to finish >--------------------------------//
		// Dbg wait for the Ec to call back
		// no sleep for a spinlock (active waiting)
//		DBGTRACE("[Debugger|DBG] spinlock :: dbg callback");
#ifdef DBGTRACE_ENABLED	/*D*/
		if (once_enter_cb == 0) {/*D*/
			DBGTRACE("1.5 - [Debugger|DBG] wait at entrance door");/*D*/
			once_enter_cb = 1;/*D*/
		}/*D*/
#endif	/*D*/
	}
	once_enter_cb = 0;/*D*/
//<2>---< ec waiting >-------------------------------------------//
	DBGTRACE("6 - [Debugger|DBG] start execution callback");/*D*/
	// Executing callback code
	// ...
	// and then come back by dbg_debugger_after_callback ...
}

rt_public void dbg_debugger_after_callback (char * callback_id) {
	DBGTRACE2("EXECUTE = ", callback_id);/*D*/
	DBGTRACE("7 - [Debugger|DBG] finish execution callback");/*D*/
//<2>---< come back from callback >------------------------------//
	InterlockedIncrement (&dbg_state);
//<3>---< give back the hand to ec >-----------------------------//
	// Callback done
	DBGTRACE("8 - [Debugger|DBG] exit callback");/*D*/
	DBGTRACE(">>>>>>>>>>>>>>>>>>>>>>>>");/*D*/
}

#ifdef _cplusplus
}
#endif
