#include <objbase.h>

#include <eif_lmalloc.h>

#include "cli_debugger.h"
#include "cli_debugger_callback_id.h"
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
//const IID IID_ICorDebug2 = {0xECCCCF2E, 0xB286, 0x4b3e, 0xA983, 0x86, 0x0A, 0x87, 0x93, 0xD1, 0x05};

const IID IID_ICorDebugController = {0x3d6f5f62,0x7538,0x11d3,0x8d,0x5b,0x00,0x10,0x4b,0x35,0xe7,0xef};
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


/*
//////////////////////////////////////////////////
/// Variables Declaration                      ///
//////////////////////////////////////////////////
*/

rt_private Callback_ids dbg_last_callback_id;
rt_private HANDLE estudio_thread_handle;
rt_private DWORD estudio_thread_id;
rt_private BOOL dbg_start_timer_requested;
rt_private bool dbg_estudio_notification_processing;

rt_private UINT dbg_timer;
rt_private EIF_OBJECT estudio_callback_object;
rt_private EIF_POINTER estudio_callback_event;


/*  Interlocked protection */
#define LOCKED_VALUE(a) InterlockedExchangeAdd ((LONG*) &a, 0)
#define LOCKED_SET_VALUE(a,v) InterlockedExchange ((LONG*) &a, v)
#define LOCKED_INCREMENT_VALUE(a) InterlockedIncrement ((LONG*) &a)
#define LOCKED_VALUE_IS_EQUAL(a,v) (InterlockedExchangeAdd ((LONG*) &a, 0) == v)
#define LOCKED_VALUE_IS_NOT_EQUAL(a,v) (InterlockedExchangeAdd ((LONG*) &a, 0) != v)

rt_private UINT dbg_keep_synchro;
#define LOCKED_DBG_KEEP_SYNCHRO LOCKED_SET_VALUE(dbg_keep_synchro, 1)
#define LOCKED_DBG_STOP_SYNCHRO LOCKED_SET_VALUE(dbg_keep_synchro, 0)
#define LOCKED_DBG_SYNCHRO_IS_ON LOCKED_VALUE_IS_EQUAL(dbg_keep_synchro, 1)
#define LOCKED_DBG_SYNCHRO_IS_OFF LOCKED_VALUE_IS_EQUAL(dbg_keep_synchro, 0)

rt_private volatile LONG dbg_state ;
#define LOCKED_DBG_STATE_VALUE LOCKED_VALUE(dbg_state)
#define LOCKED_DBG_STATE_IS_EQUAL(v) (LOCKED_VALUE_IS_EQUAL(dbg_state, v))
#define LOCKED_DBG_STATE_IS_NOT_EQUAL(v) (LOCKED_VALUE_IS_NOT_EQUAL(dbg_state, v))
#define LOCKED_DBG_STATE_SET_VALUE(v) LOCKED_SET_VALUE(dbg_state, v)
#define LOCKED_DBG_STATE_INCREMENT  LOCKED_INCREMENT_VALUE(dbg_state)

rt_private void reset_variables() {
	/* Reset variables used in the synchro */
	LOCKED_DBG_STATE_SET_VALUE (0);
	dbg_last_callback_id = CB_NONE;
	dbg_start_timer_requested = false;
	LOCKED_DBG_KEEP_SYNCHRO;
	dbg_estudio_notification_processing = false;
}

#define OUTSIDE_ESTUDIO_THREAD (estudio_thread_id != GetCurrentThreadId())

/*
//////////////////////////////////////////////////
/// Tracing debug output                       ///
//////////////////////////////////////////////////
*/

#ifdef ASSERTIONS

	/* Error message for exceptions */
rt_private char message [1024];
rt_private void raise_error (HRESULT hr, char *msg)
	/* Raise an Eiffel exception */
{
	sprintf (message, "0x%x: %s", hr, msg);
	eraise (message, EN_PROG);
}
#endif

#ifdef ASSERTIONS
rt_private void raise_error (HRESULT hr, char *msg); /* Raise error */
#define CHECK(hr,msg) if (hr) raise_error (hr, msg);
#define CHECKHR(cond, hr, msg) if (cond) raise_error (hr, msg);
#else
#define CHECK(hr,msg)
#define CHECKHR(cond,hr,msg)
#endif


/*
////////////////////////////////////////////////////////////////////////////
*/
#ifdef DBGTRACE_ENABLED
#define CLI_MUTEX_TYPE	CRITICAL_SECTION
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

rt_private CLI_MUTEX_TYPE *trace_mutex;

/*
#define LOCK_DEBUG_OUTPUT_ACCESS 
#define UNLOCK_DEBUG_OUTPUT_ACCESS 
#define CLI_MUTEX_CREATE(m,msg) 
#define CLI_MUTEX_DESTROY(m,msg)
*/

rt_private LONG dbg_msg_displayed_index;
rt_public void trace_event (char* mesg)
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
rt_public void trace_event (char* mesg, char* mesg2)
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
rt_public void trace_event_dbg_hr (char* mesg,HRESULT hr)
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
rt_public void trace_event_dbg_dword (char* mesg,DWORD dw)
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

#ifdef DBGTRACE_ENABLED
rt_private UINT once_enter_cb;
rt_private UINT once_enter_ec_cb;
#endif




/*
//////////////////////////////////////////////////
/// Synchro managing using SuspendThread       ///
//////////////////////////////////////////////////
*/

rt_private void dbg_close_estudio_thread_handle () {
	DBGTRACE_HR("[ES] CloseHandle of thread : handle = ", (HRESULT)estudio_thread_handle);	
	CloseHandle (estudio_thread_handle);
}

rt_public void dbg_init_estudio_thread_handle () {
	HANDLE pseudo_th_hdl;
	BOOL fSuccess;

	pseudo_th_hdl = GetCurrentThread();
	estudio_thread_id = GetCurrentThreadId();

	if (estudio_thread_handle != NULL) {
		dbg_close_estudio_thread_handle();
	}
	estudio_thread_handle = (HANDLE) 0;

	fSuccess = DuplicateHandle(
			GetCurrentProcess(),
			GetCurrentThread(),
			GetCurrentProcess(),
			&estudio_thread_handle,
			THREAD_SUSPEND_RESUME,
			FALSE,
			DUPLICATE_SAME_ACCESS);
	CHECK(fSuccess == 0, "Ensure: DuplicateHandle failed !!")
}

rt_private void dbg_suspend_estudio_thread () {
	DWORD result;
	result = SuspendThread (estudio_thread_handle);
}

rt_private void dbg_resume_estudio_thread () {
	DWORD result;
	result = ResumeThread (estudio_thread_handle);
}
#define DBG_INIT_CRITICAL_SECTION	dbg_init_critical_section ()
#define DBG_INIT_ESTUDIO_THREAD_HANDLE dbg_init_estudio_thread_handle ()
#define DBG_CLOSE_ESTUDIO_THREAD_HANDLE dbg_close_estudio_thread_handle ()
#define DBG_SUSPEND_ESTUDIO_THREAD dbg_suspend_estudio_thread ()
#define DBG_RESUME_ESTUDIO_THREAD  dbg_resume_estudio_thread ()
/*
#define DBG_SUSPEND_ESTUDIO_THREAD 
#define DBG_RESUME_ESTUDIO_THREAD
*/

/*
//////////////////////////////////////////////////
/// Synch initialization and estudio callback  ///
//////////////////////////////////////////////////
*/

rt_public EIF_BOOLEAN dbg_is_synchronizing () {
	/* Are we still synchronizing ? */
	return EIF_TEST(LOCKED_DBG_SYNCHRO_IS_ON);
}
rt_public void dbg_notify_from_estudio (char * str) {
#ifdef DBGTRACE_ENABLED
	DBGTRACE2("[ES] From ES ", str);
#endif
}

rt_public void dbg_init_synchro () {
	/* Initialize synchronisation */
#ifdef DBGTRACE_ENABLED
	CLI_MUTEX_CREATE(trace_mutex, "");
#endif
	DBG_INIT_ESTUDIO_THREAD_HANDLE;
	reset_variables ();
}
rt_public void dbg_terminate_synchro () {
	/* Terminate synchronisation */
	DBGTRACE("[Synchro|ES] Terminate Synchro : start");
	CHECK (dbg_timer != 0, "Require: timer = 0 (OFF)")
	LOCKED_DBG_STOP_SYNCHRO;
	/* Release dbg in case dbg is waiting and stucked */
	LOCKED_DBG_STATE_SET_VALUE (2); 
	DBGTRACE("[Synchro|ES] Terminate Synchro: done");
}

rt_public void dbg_enable_estudio_callback (EIF_OBJECT estudio_cb_obj, EIF_POINTER estudio_cb_event) {
	estudio_callback_object	= eif_adopt (estudio_cb_obj);
	estudio_callback_event	= estudio_cb_event;
}

#define INSIDE_ESTUDIO_NOTIFICATION dbg_estudio_notification_processing

rt_private void dbg_trigger_estudio_callback_event () {
	/* Enable callback notification for EC exit */
	dbg_estudio_notification_processing = true;
	if (estudio_callback_event != NULL) {
		(FUNCTION_CAST (void, (EIF_REFERENCE)) estudio_callback_event) (eif_access (estudio_callback_object));
	}
	dbg_estudio_notification_processing = false;
}

#define DBG_NOTIFY_ESTUDIO  \
	dbg_trigger_estudio_callback_event ();


/*
///////////////////////////////////////////////////////////
/// dbg_debugger_... operation                          ///
///////////////////////////////////////////////////////////
*/

rt_public EIF_INTEGER dbg_continue (void* icdc, BOOL a_f_is_out_of_band) {
	HRESULT hr;
	if ((INSIDE_ESTUDIO_NOTIFICATION) || (OUTSIDE_ESTUDIO_THREAD)) {
		dbg_start_timer_requested = true;
	} else {
		dbg_start_timer();
	}
	hr = ((ICorDebugController*)icdc)->Continue (a_f_is_out_of_band);
	DBGTRACE_HR("[???] ICorDebugController->Continue(false) = ", (HRESULT)hr);
	return hr;
}

/*
///////////////////////////////////////////////////
/// Timer and cie ...                           ///
///////////////////////////////////////////////////
*/

rt_public EIF_INTEGER dbg_timer_id () {
	/* Timer ID */
	return (EIF_INTEGER) dbg_timer;
}

rt_public void dbg_start_timer () {
	/* Start synchro Timer */
	CHECK (dbg_timer != 0, "Require: timer = 0 (OFF)")
	CHECK ( OUTSIDE_ESTUDIO_THREAD, "timer started in callback thread !! BAD")
	CHECK (dbg_estudio_notification_processing == true, "Require: dbg_estudio_notification_processing = false (OFF)")
	DBGTRACE("[???] START timer");
#ifdef DBGTRACE_ENABLED
	once_enter_ec_cb = 0;
	once_enter_cb = 0;
#endif
	dbg_start_timer_requested = false;
	dbg_timer = SetTimer (NULL, 0 /* ignored with HWnd NULL */, 
			10 /* millisecond */, (TIMERPROC) dbg_timer_callback);

	DBGTRACE_DWORD("[???] timer started = ", dbg_timer);
	CHECK (dbg_timer == 0, "Could not create dbg_timer")
}

rt_public void dbg_stop_timer () {
	/* Stop synchro Timer */
	BOOL hr;
	CHECK (dbg_timer == 0, "Require: timer /= 0 (ON)")
	DBGTRACE("[???] STOP timer");
	hr = KillTimer (NULL, dbg_timer);
	dbg_timer = 0;

#ifdef DBGTRACE_ENABLED
	once_enter_ec_cb = 0;
	once_enter_cb = 0;
#endif

	CHECK (hr == 0, "Could not kill dbg_timer")
}

rt_public void dbg_restore_cb_notification_state () {
	/* Restore callback notification state
	 *
	 * In case of evaluation during callback notification
	 * we need to give back the hand to the normal estudio notification
	 * termination. This will avoid unexpected dbg_start_timer ()
	 * 
	 */
	DBGTRACE("[???] restore cb notification state");
	CHECK (LOCKED_DBG_STATE_IS_NOT_EQUAL (5),"Require: end of evaluation processing")
	LOCKED_DBG_STATE_SET_VALUE (4);
}

/*
///////////////////////////////////////////////////////////
/// dbg_timer_callback :: EC running               ///
///////////////////////////////////////////////////////////
*/
rt_public void CALLBACK dbg_timer_callback (HWND hwnd, UINT uMsg, UINT idEvent, DWORD dwTime) {
	DBGTRACE("[ES] enter timer action");
	if (LOCKED_DBG_STATE_IS_NOT_EQUAL (1)) {
//<not 1>---------------------------------------------------------//
#ifdef DBGTRACE_ENABLED
		if (once_enter_ec_cb == 0) {
			DBGTRACE("[ES] waiting for callback event");
			once_enter_ec_cb = (once_enter_ec_cb + 1) % 100;
		}
#endif
		return;
	} else {
//<1>---< dbg waiting >------------------------------------------//
		dbg_stop_timer ();
		DBGTRACE("[ES] will give hand to dbg and SUSPEND itself");
//<2>---< give hand to dbg >-------------------------------------//
		LOCKED_DBG_STATE_INCREMENT;
		DBG_SUSPEND_ESTUDIO_THREAD;
//<4>------------------------------------------------------------//
		DBGTRACE("[Synchro|ES] Notify EC : START");
		DBG_NOTIFY_ESTUDIO;
		DBGTRACE("[Synchro|ES] Notify EC : END");

		if (LOCKED_DBG_STATE_IS_EQUAL (4)) {
			DBGTRACE("[ES] exit timer action and unlock dbg ");
			LOCKED_DBG_STATE_INCREMENT;
			if (LOCKED_DBG_SYNCHRO_IS_ON) {
				LOCKED_DBG_STATE_SET_VALUE (0);
				if (dbg_start_timer_requested) {
					dbg_start_timer ();
				}
#ifdef DBGTRACE_ENABLED
				else {
					DBGTRACE("[ES] start timer Not Requested !!");
				}
#endif
			}
#ifdef DBGTRACE_ENABLED
			else {
				DBGTRACE("[ES] exit timer callback WITHOUT continue synchro !!");
			}
#endif
		} // Otherwise, this means an eval forced the priority
#ifdef DBGTRACE_ENABLED
		else {
			DBGTRACE("[ES] exit timer callback WITHOUT unlocking dbg, already done !!");
		}
#endif
	}
}

/*
///////////////////////////////////////////////////////////
/// dbg_lock_and_wait_callback :: EC evaluation    ///
///////////////////////////////////////////////////////////
*/

rt_public void dbg_lock_and_wait_callback (void* icdc) {
    HRESULT hr = S_OK;
	dbg_last_callback_id = CB_NONE;

	/*** Local  ***/
#ifdef DBGTRACE_ENABLED
	UINT once_enter;
#endif
	BOOL eval_callback_proceed;
	/*** Require  ***/
	CHECK (dbg_timer != 0, "Require : Timer should be disable in this context (evaluating)")
	/*** Do  ***/

	DBGTRACE("[ES::Eval] START evaluation");

	if (LOCKED_DBG_STATE_IS_EQUAL (4)) {
		// We are in notification processing
		// we need evaluation functionalities
		// so we force the priority and overtake the estudio unlocking
		DBGTRACE("[ES::Eval] estudio into NOTIFY, eval forced, then estudio will end right away");
		LOCKED_DBG_STATE_INCREMENT;
	}

	// Initialize data
	// at begining we don't care about past
	eval_callback_proceed = false;

	// Process the evaluation :
	hr = ((ICorDebugController*)icdc)->Continue (false);
	DBGTRACE_HR("[ES::Eval] Start effective evaluation: ICorDebugController->Continue(false) = ", (HRESULT)hr);
	if (hr < 0) { eval_callback_proceed = true; }

	while (!eval_callback_proceed) {
		// While we haven't reach "eval callback", and proceed it 

#ifdef DBGTRACE_ENABLED
		once_enter = 0;
#endif
		while (LOCKED_DBG_STATE_IS_NOT_EQUAL (1)) {
#ifdef DBGTRACE_ENABLED
			if (once_enter == 0) {
				DBGTRACE("[ES::Eval] waiting for callback (s=1)");
				once_enter = (once_enter + 1) % 500;
			}
#endif
			Sleep (1);
		}
		
		/* now check if last callback is about evaluating
		 * only now, after synchronized with debugger, otherwise we may missed one */
		DBGTRACE2("[ES::Eval] LastCallback = ", Callback_name(dbg_last_callback_id));
		switch (dbg_last_callback_id) {
			case CB_EVAL_COMPLETE:
			case CB_EVAL_EXCEPTION:
				eval_callback_proceed = true;
				DBGTRACE("[ES::Eval] Eval Callback Occured ");
				break;
			case CB_EXIT_PROCESS:
				eval_callback_proceed = true;
				DBGTRACE("[ES::Eval] ExitProcess Callback Occured !!!");
				break;
			case CB_DEBUGGER_ERROR:
			case CB_BREAK:
			case CB_EXCEPTION:
				eval_callback_proceed = true;
				DBGTRACE("[ES::Eval] Exception Callback Occured ");
				break;
			default:
				eval_callback_proceed = false;
				DBGTRACE_HR("[ES::Eval] Callback Events Occured (non stopping since evaluation)", (HRESULT)hr);
				break;
		}
		/* if eval callback occured, we must exit after this loop 
		 * but we need to do this at least once */

		DBGTRACE("[ES::Eval] will give hand to dbg and SUSPEND itself");
		LOCKED_DBG_STATE_INCREMENT;
		DBG_SUSPEND_ESTUDIO_THREAD;
		/* EC's thread has been suspended And resumed by dbg's thread */
		DBGTRACE("[ES::Eval] call back finished");
		LOCKED_DBG_STATE_INCREMENT;
		DBGTRACE("[ES::Eval] eval finished");
	}
	DBGTRACE("[ES::Eval] LAST CALLBACK = EVAL Done !!!");

	/*** Ensure ***/
	CHECK (!eval_callback_proceed, "Ensure : Last callback should be about evaluating")
	/*** End  ***/
}

/*
///////////////////////////////////////////////////////////
/// dbg_debugger_..._callback :: .NET Dbg Callback      ///
///////////////////////////////////////////////////////////
*/
rt_public void dbg_debugger_before_callback (Callback_ids callback_id) {
	dbg_last_callback_id = callback_id;
	DBGTRACE2("[CB] ENTER CALLBACK = ", Callback_name(callback_id));
	/* It is not possible to have 2 callbacks at the same time, 
	 * since it is supposed to be in the same thread ...  */
#ifdef DBGTRACE_ENABLED
	once_enter_cb = 0;
#endif
	while (LOCKED_DBG_STATE_IS_EQUAL (4)) {
//<4>---< wait for ec to finish >--------------------------------//
		if (callback_id == CB_CREATE_PROCESS) {
				/* Special case here to let EiffelStudio debugger to have time
				 * to refresh itself before starting debugging. */
			Sleep (100);
		}
#ifdef DBGTRACE_ENABLED
		if (once_enter_cb == 0) {
			DBGTRACE("1.5 - [CB] wait at entrance door");
			once_enter_cb = (once_enter_cb + 1) % 500;
		}
#endif
	}
	// we set it again, in case this is unset by dbg_stop_timer
	// Let's tell the timer we are ready
	DBGTRACE("2 - [CB] enter dbg callback");
	LOCKED_DBG_STATE_SET_VALUE (1);

//<1>---< give hand to ec >--------------------------------------//
	DBGTRACE("3 - [CB] now s=1, it is ec's turn");
#ifdef DBGTRACE_ENABLED
	once_enter_cb = 0;
#endif
	if (LOCKED_DBG_SYNCHRO_IS_OFF) { /* We are terminating debugging .. */
		LOCKED_DBG_STATE_SET_VALUE (2);

		DBGTRACE("3.3 - [CB] now s=2, we by pass ec's turn, because dbg_keep_synchro == 0");
	} else {
		while (LOCKED_DBG_STATE_IS_EQUAL (1)) {
//<1>---< wait for ec to finish >--------------------------------//
			if (callback_id == CB_CREATE_PROCESS) {
					/* Special case here to let EiffelStudio debugger to have time
					 * to refresh itself before starting debugging. */
				Sleep (100);
			}
			// Dbg wait for the Ec to call back
			// no sleep for a spinlock (active waiting)
#ifdef DBGTRACE_ENABLED
			if (once_enter_cb == 0) {
				DBGTRACE("3.5 - [CB] wait at entrance door");
				once_enter_cb = (once_enter_cb + 1) % 500;
			}
#endif
		}
	}
//	DBG_SUSPEND_ESTUDIO_THREAD;
//<2>---< ec waiting >-------------------------------------------//
	LOCKED_DBG_STATE_INCREMENT;
//<3>---< ec waiting >-------------------------------------------//
	DBGTRACE2("5 - [CB] start exec callback :", Callback_name(callback_id));
	// Executing callback code
	// and then come back by dbg_debugger_after_callback ...
}

rt_public void dbg_debugger_after_callback (Callback_ids callback_id) {
//<3>---< come back from callback >------------------------------//
	DBGTRACE2("6 - [CB] end exec callback : ", Callback_name(callback_id));
//<4>---< give back the hand to ec >-----------------------------//
	LOCKED_DBG_STATE_INCREMENT;
	DBGTRACE("7 - [CB] RESUME ES");
	DBG_RESUME_ESTUDIO_THREAD;

//	DBG_RESUME_ESTUDIO_THREAD; 
	/* Called twice since it is suspended twice */

	DBGTRACE2("8 - [CB] EXIT CALLBACK = ", Callback_name(callback_id));
	// Callback done
}

/**************************************************************************/
/* ICorDebug  */

rt_public EIF_INTEGER get_cordebug (LPWSTR a_dbg_version, EIF_POINTER ** icd)
	/* Create new instance of ICorDebug */
{
	HRESULT hr;
#ifdef DBGTRACE_ENABLED
	CLI_MUTEX_CREATE(trace_mutex, "");
#endif
	
	rt_private FARPROC create_debug_address;
	HMODULE mscoree_module;

	mscoree_module = NULL;
	mscoree_module = LoadLibrary("mscoree.dll");

	create_debug_address = NULL;
	create_debug_address = GetProcAddress (mscoree_module, "CreateDebuggingInterfaceFromVersion");

	if (create_debug_address) {
		/*
		 * from cordebug.idl :
		 *	CorDebugInvalidVersion = 0,
		 *	CorDebugVersion_1_0 = CorDebugInvalidVersion + 1,
		 *	CorDebugVersion_1_1 = CorDebugVersion_1_0 + 1,
		 *	CorDebugVersion_2_0 = CorDebugVersion_1_1 + 1,
		 *
		 */
		hr = (FUNCTION_CAST_TYPE(HRESULT, WINAPI, (int, LPCWSTR, IUnknown**)) create_debug_address)(
					3, /* ie CorDebugLatestVersion */
					a_dbg_version,
					(IUnknown**) icd
				);
		DBGTRACE_HR("[DEBUGGER] CreateDebuggingInterfaceFromVersion : hr = ", hr);
	} else { 
		hr = CoCreateInstance (
					CLSID_CorDebug, 
					NULL,
					CLSCTX_INPROC_SERVER,
					IID_ICorDebug, 
					(void **) icd
				);
		DBGTRACE_HR("[DEBUGGER] CoCreateInstance (.. CorDebug ...) : hr = ", hr);
	}
	
	CHECKHR ((((hr == S_OK) || (hr == S_FALSE)) ? 0 : 1), hr, "Could not create ICorDebug");
	return hr;
}

#ifdef _cplusplus
}
#endif
