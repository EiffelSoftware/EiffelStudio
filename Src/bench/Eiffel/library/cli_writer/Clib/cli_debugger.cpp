#include <objbase.h>

#include "cli_debugger.h"
#include "cli_debugger_callback_id.h"
#include <objbase.h>
#include <cor.h>

#include <cordebug.h>

#include <mscoree.h>

#ifdef _cplusplus
extern "C" {
#endif


/**********************/
/* IID_ .. constants  */
/**********************/

const CLSID CLSID_CorDebug = {0x6fef44d0,0x39e7,0x4c77,0xbe,0x8e,0xc9,0xf8,0xcf,0x98,0x86,0x30};
//const CLSID CLSID_EmbeddedCLRCorDebug = {0x211f1254,0xbc7e,0x4af5,0xb9,0xaa,0x06,0x73,0x08,0xd8,0x3d,0xd1};
//const IID IID_ICorDebugManagedCallback = {0x3d6f5f60,0x7538,0x11d3,0x8d,0x5b,0x00,0x10,0x4b,0x35,0xe7,0xef};
//const IID IID_ICorDebugUnmanagedCallback = {0x5263E909,0x8CB5,0x11d3,0xBD,0x2F,0x00,0x00,0xF8,0x08,0x49,0xBD};
const IID IID_ICorDebug = {0x3d6f5f61,0x7538,0x11d3,0x8d,0x5b,0x00,0x10,0x4b,0x35,0xe7,0xef};
//const IID IID_ICorDebugController = {0x3d6f5f62,0x7538,0x11d3,0x8d,0x5b,0x00,0x10,0x4b,0x35,0xe7,0xef};
//const IID IID_ICorDebugAppDomain = {0x3d6f5f63,0x7538,0x11d3,0x8d,0x5b,0x00,0x10,0x4b,0x35,0xe7,0xef};
//const IID IID_ICorDebugAssembly = {0xdf59507c,0xd47a,0x459e,0xbc,0xe2,0x64,0x27,0xea,0xc8,0xfd,0x06};
//const IID IID_ICorDebugProcess = {0x3d6f5f64,0x7538,0x11d3,0x8d,0x5b,0x00,0x10,0x4b,0x35,0xe7,0xef};
//const IID IID_ICorDebugBreakpoint = {0xCC7BCAE8,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
const IID IID_ICorDebugFunctionBreakpoint = {0xCC7BCAE9,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
const IID IID_ICorDebugModuleBreakpoint = {0xCC7BCAEA,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
const IID IID_ICorDebugValueBreakpoint = {0xCC7BCAEB,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugStepper = {0xCC7BCAEC,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugRegisterSet = {0xCC7BCB0B,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugThread = {0x938c6d66,0x7fb6,0x4f69,0xb3,0x89,0x42,0x5b,0x89,0x87,0x32,0x9b};
//const IID IID_ICorDebugChain = {0xCC7BCAEE,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugFrame = {0xCC7BCAEF,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
const IID IID_ICorDebugILFrame = {0x03E26311,0x4F76,0x11d3,0x88,0xC6,0x00,0x60,0x97,0x94,0x54,0x18};
const IID IID_ICorDebugNativeFrame = {0x03E26314,0x4F76,0x11d3,0x88,0xC6,0x00,0x60,0x97,0x94,0x54,0x18};
//const IID IID_ICorDebugModule = {0xdba2d8c1,0xe5c5,0x4069,0x8c,0x13,0x10,0xa7,0xc6,0xab,0xf4,0x3d};
//const IID IID_ICorDebugFunction = {0xCC7BCAF3,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugCode = {0xCC7BCAF4,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugClass = {0xCC7BCAF5,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugEval = {0xCC7BCAF6,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugValue = {0xCC7BCAF7,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
const IID IID_ICorDebugGenericValue = {0xCC7BCAF8,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
const IID IID_ICorDebugReferenceValue = {0xCC7BCAF9,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
const IID IID_ICorDebugHeapValue = {0xCC7BCAFA,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
const IID IID_ICorDebugObjectValue = {0x18AD3D6E,0xB7D2,0x11d2,0xBD,0x04,0x00,0x00,0xF8,0x08,0x49,0xBD};
const IID IID_ICorDebugBoxValue = {0xCC7BCAFC,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
const IID IID_ICorDebugStringValue = {0xCC7BCAFD,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
const IID IID_ICorDebugArrayValue = {0x0405B0DF,0xA660,0x11d2,0xBD,0x02,0x00,0x00,0xF8,0x08,0x49,0xBD};
//const IID IID_ICorDebugContext = {0xCC7BCB00,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugEnum = {0xCC7BCB01,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugObjectEnum = {0xCC7BCB02,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugBreakpointEnum = {0xCC7BCB03,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugStepperEnum = {0xCC7BCB04,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugProcessEnum = {0xCC7BCB05,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugThreadEnum = {0xCC7BCB06,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugFrameEnum = {0xCC7BCB07,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugChainEnum = {0xCC7BCB08,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugModuleEnum = {0xCC7BCB09,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugValueEnum = {0xCC7BCB0A,0x8A68,0x11d2,0x98,0x3C,0x00,0x00,0xF8,0x08,0x34,0x2D};
//const IID IID_ICorDebugErrorInfoEnum = {0xF0E18809,0x72B5,0x11d2,0x97,0x6F,0x00,0xA0,0xC9,0xB4,0xD5,0x0C};
//const IID IID_ICorDebugAppDomainEnum = {0x63ca1b24,0x4359,0x4883,0xbd,0x57,0x13,0xf8,0x15,0xf5,0x87,0x44};
//const IID IID_ICorDebugAssemblyEnum = {0x4a2a1ec9,0x85ec,0x4bfb,0x9f,0x15,0xa8,0x9f,0xdf,0xe0,0xfe,0x83};
//const IID IID_ICorDebugEditAndContinueErrorInfo = {0x8D600D41,0xF4F6,0x4cb3,0xB7,0xEC,0x7B,0xD1,0x64,0x94,0x40,0x36};
//const IID IID_ICorDebugEditAndContinueSnapshot = {0x6DC3FA01,0xD7CB,0x11d2,0x8A,0x95,0x00,0x80,0xC7,0x92,0xE5,0xD8};


/****************************************/

rt_private BOOL dbg_last_callback_is_about_eval;
rt_private Callback_ids dbg_last_callback_id;
rt_private HANDLE estudio_thread_handle;
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
  fprintf(out,"%s <HR=%d>\n",
					mesg,
					hr
					);
  fclose(out);
}
rt_public void trace_event_dbg_dword (char* mesg,DWORD dw)
{
  FILE *out;
  out=fopen("eif_debugger.out","a+");
  fprintf(out,"%s %d \n",
					mesg,
					dw
					);
  fclose(out);
}
#endif

#ifdef DBGTRACE_ENABLED
#define DBGTRACE(msg) trace_event(msg);
#define DBGTRACE2(msg,msg2) trace_event(msg, msg2);
#define DBGTRACE_HR(msg1,hr) trace_event_dbg_hr(msg1, hr);
#define DBGTRACE_DWORD(msg1,dw) trace_event_dbg_dword(msg1, dw);
#else
#define DBGTRACE(msg)
#define DBGTRACE2(msg,msg2)
#define DBGTRACE_HR(msg,hr)
#define DBGTRACE_DWORD(msg,dw)
#endif

////////////////////////////////////////////////////////////////////////////


/**************************************************************************/
/* Synchronisation */

rt_private UINT once_enter_cb;
rt_private UINT once_enter_ec_cb;
rt_private UINT dbg_timer;


rt_public void dbg_init_estudio_thread_handle () {
	HANDLE pseudo_th_hdl;
	BOOL fSuccess;

	pseudo_th_hdl = GetCurrentThread();

	fSuccess = DuplicateHandle(
			GetCurrentProcess(),
			GetCurrentThread(),
			GetCurrentProcess(),
			&estudio_thread_handle,
			THREAD_SUSPEND_RESUME,
			FALSE,
			DUPLICATE_SAME_ACCESS);
	CHECK(fSuccess = 0, "Ensure: DuplicateHandle failed !!")
}

rt_public void dbg_suspend_estudio_thread () {
	DWORD result;
 	HANDLE thread_hdl;
	thread_hdl = estudio_thread_handle;


	DBGTRACE_HR("[Debugger] going to suspend eStudio Thread : handle = ", (HRESULT)thread_hdl);/*D*/
	result = SuspendThread (thread_hdl);
	DBGTRACE_DWORD("[Debugger] SuspendThread : result = ", result); /*D*/
}

rt_public void dbg_resume_estudio_thread () {
	DWORD result;
 	HANDLE thread_hdl;
	thread_hdl = estudio_thread_handle;

	DBGTRACE("[Debugger] going to resume eStudio Thread");/*D*/
	DBGTRACE_HR("[Debugger] thread_hdl : handle = ", (HRESULT)thread_hdl);/*D*/
	result = ResumeThread (thread_hdl);
	DBGTRACE_DWORD ("[Debugger] ResumeThread : result = ", result); /*D*/
}

#define DBG_INIT_ESTUDIO_THREAD_HANDLE dbg_init_estudio_thread_handle ()
#define DBG_SUSPEND_ESTUDIO_THREAD dbg_suspend_estudio_thread ()
#define DBG_RESUME_ESTUDIO_THREAD  dbg_resume_estudio_thread ()

//#define DBG_SUSPEND_ESTUDIO_THREAD 
//#define DBG_RESUME_ESTUDIO_THREAD


	// Timer ID for dbg synchro

//rt_private LONG dbg_state;
	// default: 0
	// 1 : ec is waiting for dbg
	// 2 : dbg has starting his processing, ec is waiting for dbg to finish
	// 3 : dbg is done, dbg waiting

rt_public void dbg_init_synchro () {
	DBG_INIT_ESTUDIO_THREAD_HANDLE;
}

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

///////////////////////////////////////////////////////////
/// dbg_timer_callback :: eStudio running               ///
///////////////////////////////////////////////////////////

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
		DBG_SUSPEND_ESTUDIO_THREAD;
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

///////////////////////////////////////////////////////////
/// dbg_lock_and_wait_callback :: eStudio evaluation    ///
///////////////////////////////////////////////////////////

rt_public void dbg_lock_and_wait_callback () {
	/*** Local  ***/
	UINT once_enter;
	BOOL eval_callback_proceed;
	/*** Require  ***/
	CHECK (dbg_timer != 0, "Require : Timer should be disable in this context (evaluating)")
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
		DBGTRACE2("[EVAL] LastCallback = ", Callback_name(dbg_last_callback_id));
		eval_callback_proceed = dbg_last_callback_is_about_eval;
		// if eval callback occured, we must exit after this loop 
		// but we need to do this at least once

		DBGTRACE("?EVAL? - [Debugger|EC] call back arrived, dbg waiting");/*D*/
		InterlockedIncrement (&dbg_state);
		DBG_SUSPEND_ESTUDIO_THREAD;
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


///////////////////////////////////////////////////////////
/// dbg_debugger_..._callback :: .NET Dbg Callback      ///
///////////////////////////////////////////////////////////

rt_public void dbg_debugger_before_callback (Callback_ids callback_id, BOOL is_eval_callback) {
	dbg_last_callback_id = callback_id;
	if (is_eval_callback) { DBGTRACE("<< is_eval_callback  >>"); }/*D*/
	dbg_last_callback_is_about_eval = is_eval_callback;
	DBGTRACE("<<<<<<<<<<<<<<<<<<<<<<<<");/*D*/
	DBGTRACE2("CALLBACK = ", Callback_name(callback_id));/*D*/
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

rt_public void dbg_debugger_after_callback (Callback_ids callback_id) {
	DBGTRACE2("EXECUTE = ", Callback_name(callback_id));/*D*/
	DBGTRACE("7 - [Debugger|DBG] finish execution callback");/*D*/
//<2>---< come back from callback >------------------------------//
	InterlockedIncrement (&dbg_state);
//<3>---< give back the hand to ec >-----------------------------//
	// Callback done

	DBG_RESUME_ESTUDIO_THREAD;

	DBGTRACE("8 - [Debugger|DBG] exit callback");/*D*/
	DBGTRACE(">>>>>>>>>>>>>>>>>>>>>>>>");/*D*/
}

/**************************************************************************/
/* ICorDebug  */

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

#ifdef _cplusplus
}
#endif
