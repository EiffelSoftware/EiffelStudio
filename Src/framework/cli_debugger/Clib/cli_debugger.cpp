#include <objbase.h>

#include <eif_lmalloc.h>

#include "cli_cordebug.h"
#include "cli_debugger.h"
#include "cli_debugger_callback_id.h"
#include "cli_common.h"


#ifdef _cplusplus
extern "C" {
#endif


/*
 * Private function declaration
 */
rt_private EIF_INTEGER dbg_icdc_continue (void*, BOOL);

/*
//////////////////////////////////////////////////
/// Variables Declaration                      ///
//////////////////////////////////////////////////
*/

rt_private HANDLE estudio_thread_handle;
rt_public DWORD estudio_thread_id;

rt_private EIF_OBJECT estudio_callback_object;
rt_private EIF_POINTER estudio_callback_event;


/*  Interlocked protection */

rt_private Callback_ids dbg_last_callback_id;
#define LOCKED_DBG_CB_ID_VALUE LOCKED_VALUE(dbg_last_callback_id)
#define LOCKED_DBG_CB_ID_SET_VALUE(v) LOCKED_SET_VALUE(dbg_last_callback_id, v)
#define LOCKED_DBG_CB_ID_IS_EQUAL(v) LOCKED_VALUE_IS_EQUAL(dbg_last_callback_id, v)

rt_private UINT dbg_timer;
#define LOCKED_DBG_TIMER_VALUE LOCKED_VALUE(dbg_timer)
#define LOCKED_DBG_TIMER_IS_SET LOCKED_VALUE_IS_NOT_EQUAL(dbg_timer,0)
#define LOCKED_DBG_TIMER_IS_NOT_SET LOCKED_VALUE_IS_EQUAL(dbg_timer,0)
#define LOCKED_DBG_TIMER_SET_VALUE(v) LOCKED_SET_VALUE(dbg_timer, v)

rt_private BOOL dbg_start_timer_requested;
#define LOCKED_DBG_START_TIMER_REQUESTED LOCKED_VALUE(dbg_start_timer_requested)
#define LOCKED_DBG_START_TIMER_REQUEST LOCKED_SET_VALUE(dbg_start_timer_requested, true)
#define LOCKED_DBG_START_TIMER_RESET LOCKED_SET_VALUE(dbg_start_timer_requested, false)

rt_private BOOL dbg_exit_process_occurred;
#define LOCKED_DBG_EXIT_PROCESS_OCCURRED LOCKED_VALUE(dbg_exit_process_occurred)
#define LOCKED_DBG_EXIT_PROCESS_NOTIFY LOCKED_SET_VALUE(dbg_exit_process_occurred, true)
#define LOCKED_DBG_EXIT_PROCESS_RESET LOCKED_SET_VALUE(dbg_exit_process_occurred, false)

rt_private BOOL dbg_estudio_notification_processing;
#define INSIDE_ESTUDIO_NOTIFICATION LOCKED_VALUE(dbg_estudio_notification_processing)
#define OUTSIDE_ESTUDIO_NOTIFICATION !INSIDE_ESTUDIO_NOTIFICATION
#define LOCKED_ES_NOTIFICATION_START LOCKED_SET_VALUE(dbg_estudio_notification_processing, true)
#define LOCKED_ES_NOTIFICATION_STOP LOCKED_SET_VALUE(dbg_estudio_notification_processing, false)

rt_private BOOL dbg_estudio_evaluation_processing;
#define LOCKED_ES_EVALUATION_START LOCKED_SET_VALUE(dbg_estudio_evaluation_processing, true)
#define LOCKED_ES_EVALUATION_STOP LOCKED_SET_VALUE(dbg_estudio_evaluation_processing, false)

rt_private BOOL dbg_callback_processing;
#define LOCKED_CALLBACK_PROCESSING LOCKED_VALUE(dbg_callback_processing)
#define LOCKED_CALLBACK_START LOCKED_SET_VALUE(dbg_callback_processing, true)
#define LOCKED_CALLBACK_STOP LOCKED_SET_VALUE(dbg_callback_processing, false)

rt_private UINT dbg_keep_synchro;
#define LOCKED_DBG_KEEP_SYNCHRO LOCKED_SET_VALUE(dbg_keep_synchro, 1)
#define LOCKED_DBG_STOP_SYNCHRO LOCKED_SET_VALUE(dbg_keep_synchro, 0)
#define LOCKED_DBG_SYNCHRO_IS_ON LOCKED_VALUE_IS_EQUAL(dbg_keep_synchro, 1)
#define LOCKED_DBG_SYNCHRO_IS_OFF LOCKED_VALUE_IS_EQUAL(dbg_keep_synchro, 0)

rt_private void reset_variables() {
	/* Reset variables used in the synchro */
	LOCKED_DBG_STATE_SET_VALUE(0);
	LOCKED_DBG_CB_ID_SET_VALUE(CB_NONE);
	LOCKED_DBG_START_TIMER_RESET;
	LOCKED_DBG_KEEP_SYNCHRO;
	LOCKED_DBG_EXIT_PROCESS_RESET;
	LOCKED_ES_NOTIFICATION_STOP;
}

#define INSIDE_ESTUDIO_THREAD (estudio_thread_id == GetCurrentThreadId())
#define OUTSIDE_ESTUDIO_THREAD (estudio_thread_id != GetCurrentThreadId())

/*
//////////////////////////////////////////////////
/// Tracing debug output                       ///
//////////////////////////////////////////////////
*/

#ifdef EIF_ASSERTIONS

	/* Error message for exceptions */
rt_private char message [1024];
rt_private void raise_error (HRESULT hr,char *pref, char *msg)
	/* Raise an Eiffel exception */
{
	sprintf (message, "%s 0x%x: %s", pref, hr, msg);
	eraise (message, EN_PROG);
}
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

/*
//////////////////////////////////////////////////
/// Synchro info                               ///
//////////////////////////////////////////////////
*/

rt_private HWND dbg_hWnd_for_timer;
rt_public struct CorDbgCallbackInfo * dbg_cb_info;

rt_public void clear_dbg_cb_info() {
	DBGTRACE("[CB] clear Cb Info ");

	dbg_cb_info->callback_id = (Callback_ids) 0;

	dbg_cb_info->items[0].itu_ptr = NULL;
	dbg_cb_info->items[1].itu_ptr = NULL;
	dbg_cb_info->items[2].itu_ptr = NULL;
	dbg_cb_info->items[3].itu_ptr = NULL;
}
rt_public void reset_dbg_cb_info() {
	if (dbg_cb_info != NULL) {
		clear_dbg_cb_info();
	} else {
		DBGTRACE("[CB] create Cb Info ");
		dbg_cb_info = (struct CorDbgCallbackInfo*) CoTaskMemAlloc ( sizeof (struct CorDbgCallbackInfo));
		dbg_cb_info->items = (struct CorDbgCallbackInfo_item*) CoTaskMemAlloc ( 4 * sizeof (struct CorDbgCallbackInfo_item));
	}
}

/*
//////////////////////////////////////////////////
/// Synchro managing using SuspendThread       ///
//////////////////////////////////////////////////
*/

rt_private void dbg_close_estudio_thread_handle () {
	DBGTRACE_PTR("[ES] CloseHandle of thread : handle = ", estudio_thread_handle);
	CloseHandle (estudio_thread_handle);
	estudio_thread_handle = (HANDLE) 0;
}

rt_public void dbg_init_estudio_thread_handle () {
	HANDLE pseudo_th_hdl;
	BOOL fSuccess;

	RESET_DBG_CB_INFO;

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

#ifdef DBGTRACE_ENABLED
rt_private void dbg_suspend_estudio_thread () {
	DWORD result;
	result = SuspendThread (estudio_thread_handle);
	ENSURE((result == (DWORD) 0), "Error during dbg_suspend_estudio_thread");
}

rt_private void dbg_resume_estudio_thread () {
	DWORD result;
	result = ResumeThread (estudio_thread_handle);
	ENSURE((result > (DWORD) 0), "Error during dbg_resume_estudio_thread");
}
#endif

#define DBG_INIT_ESTUDIO_THREAD_HANDLE dbg_init_estudio_thread_handle ()
#define DBG_CLOSE_ESTUDIO_THREAD_HANDLE dbg_close_estudio_thread_handle ()

#ifdef DBGTRACE_ENABLED
#define DBG_SUSPEND_ESTUDIO_THREAD dbg_suspend_estudio_thread ();
#define DBG_RESUME_ESTUDIO_THREAD  dbg_resume_estudio_thread ();
#else
#define DBG_SUSPEND_ESTUDIO_THREAD SuspendThread(estudio_thread_handle)
#define DBG_RESUME_ESTUDIO_THREAD ResumeThread (estudio_thread_handle)
#endif


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
	DBGTRACE2("[ES] From ES ", str);
}

rt_public void dbg_init_synchro (HWND hWnd) {
	/* Initialize synchronisation */
	dbg_hWnd_for_timer = hWnd;
#ifdef DBGTRACE_ENABLED
	trace_init();
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
	dbg_hWnd_for_timer = NULL;
	DBGTRACE("[Synchro|ES] Terminate Synchro: done");
}

rt_public void dbg_enable_estudio_callback (EIF_OBJECT estudio_cb_obj, EIF_POINTER estudio_cb_event) {
	estudio_callback_object	= eif_adopt (estudio_cb_obj);
	estudio_callback_event	= estudio_cb_event;
}

rt_private void dbg_trigger_estudio_callback_event (Callback_ids cb_id) {
	/* Enable callback notification for EC exit */
	REQUIRE(INSIDE_ESTUDIO_THREAD, "notification inside in eStudio thread !!")
	LOCKED_ES_NOTIFICATION_START;
	if (estudio_callback_event != NULL) {
		(FUNCTION_CAST (void, (EIF_REFERENCE, Callback_ids)) estudio_callback_event) (eif_access (estudio_callback_object), cb_id);
	}
	LOCKED_ES_NOTIFICATION_STOP;
}

#define DBG_NOTIFY_ESTUDIO(cb_id)  \
	DBGTRACE2("[Synchro] Notify EC : START :", Callback_name(cb_id)); \
	dbg_trigger_estudio_callback_event (cb_id); \
	DBGTRACE2("[Synchro] Notify EC : END :", Callback_name(cb_id));

/*
///////////////////////////////////////////////////////////
/// dbg_debugger_... operation                          ///
///////////////////////////////////////////////////////////
*/

rt_public EIF_INTEGER dbg_continue (void* icdc, BOOL a_f_is_out_of_band) {
	HRESULT hr;
	REQUIRE(INSIDE_ESTUDIO_THREAD, "notification inside in eStudio thread !!")
	DBGTRACE("[???] start dbg_continue");
	if ((INSIDE_ESTUDIO_NOTIFICATION) || (OUTSIDE_ESTUDIO_THREAD)) {
		DBGTRACE("[???] Request a Start timer");
		LOCKED_DBG_START_TIMER_REQUEST;
	} else {
		dbg_start_timer();
	}
	hr = dbg_icdc_continue (icdc, a_f_is_out_of_band);
	return hr;
}

rt_private EIF_INTEGER dbg_icdc_continue (void* icdc, BOOL a_f_is_out_of_band) {
	HRESULT hr;
	hr = ((ICorDebugController*)icdc)->Continue (a_f_is_out_of_band);
	DBGTRACE_HR("[???] ICorDebugController->Continue(..) = ", (HRESULT)hr);
	return hr;
}

/*
///////////////////////////////////////////////////
/// Timer and cie ...                           ///
///////////////////////////////////////////////////
*/

rt_public EIF_INTEGER dbg_timer_id () {
	/* Timer ID */
	return (EIF_INTEGER) LOCKED_DBG_TIMER_VALUE;
}

rt_public void dbg_start_timer () {
	/* Start synchro Timer */
	REQUIRE(LOCKED_DBG_TIMER_IS_NOT_SET, "timer is zero")
	REQUIRE(INSIDE_ESTUDIO_THREAD, "timer started in eStudio thread !! (Bad)")
	REQUIRE(OUTSIDE_ESTUDIO_NOTIFICATION, "Outside eStudio Notification")
	DBGTRACE("[???] START timer");
#ifdef DBGTRACE_ENABLED
	once_enter_ec_cb = 0;
	once_enter_cb = 0;
#endif
	LOCKED_DBG_START_TIMER_RESET;
	LOCKED_DBG_TIMER_SET_VALUE ((LONG) SetTimer (dbg_hWnd_for_timer, (UINT_PTR) 12345678 /* ignored with HWnd NULL */, 10 /* millisecond */, (TIMERPROC) dbg_timer_callback) );

	DBGTRACE_DWORD("[???] timer started = ", LOCKED_DBG_TIMER_VALUE);
	ENSURE(LOCKED_DBG_TIMER_IS_SET, "dbg_timer created")
}

rt_public void dbg_stop_timer () {
	/* Stop synchro Timer */
	BOOL hr;
	REQUIRE (LOCKED_DBG_TIMER_IS_SET, "timer not zero")
	DBGTRACE("[???] STOP timer");
	hr = KillTimer (dbg_hWnd_for_timer, LOCKED_DBG_TIMER_VALUE);
	LOCKED_DBG_TIMER_SET_VALUE (0);

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
	REQUIRE(LOCKED_DBG_STATE_IS_EQUAL (5),"is at end of evaluation processing")
	LOCKED_DBG_STATE_SET_VALUE (4);
}

/*
///////////////////////////////////////////////////////////
/// dbg_timer_callback :: EC running                    ///
///////////////////////////////////////////////////////////
*/
rt_public void CALLBACK dbg_timer_callback (HWND hwnd, UINT uMsg, UINT idEvent, DWORD dwTime) {
	Callback_ids cb_id;
	DBGTRACE_DWORD("[ES] enter timer callback = ", idEvent);
	if (LOCKED_DBG_STATE_IS_NOT_EQUAL (1)) {
		/* <not 1> */
#ifdef DBGTRACE_ENABLED
		if (once_enter_ec_cb == 0) {
			DBGTRACE("[ES] waiting for callback event");
			once_enter_ec_cb = (once_enter_ec_cb + 1) % 100;
		}
#endif
		return;
	} else {
		/* <1> Callback occurred and Dbg is waiting */
		dbg_stop_timer ();
		cb_id = (Callback_ids) LOCKED_DBG_CB_ID_VALUE;
		DBGTRACE("[ES] will give hand to dbg and SUSPEND itself");
		/* <2> Give hand to dbg */
		LOCKED_DBG_STATE_INCREMENT;
		/* <3> */
		DBG_SUSPEND_ESTUDIO_THREAD;
		/* <4> */
		DBG_NOTIFY_ESTUDIO(cb_id);

		if (LOCKED_DBG_STATE_IS_EQUAL (4)) {
			DBGTRACE("[ES] exit timer action and unlock dbg ");
			if (LOCKED_DBG_SYNCHRO_IS_ON) {
				if (LOCKED_DBG_START_TIMER_REQUESTED) {
					/* safe: dbg_state is 4, then the timer will wait for it to be 1 */
					dbg_start_timer ();
					LOCKED_DBG_STATE_SET_VALUE (0); /* Reset */
				}
				else {
					DBGTRACE("[ES] start timer Not Requested !!");
					LOCKED_DBG_STATE_INCREMENT; /* Give hand to cb */
					DBGTRACE("[ES] exit timer callback (timer is off) !!");
				}
			}
			else {
				LOCKED_DBG_STATE_INCREMENT;
				DBGTRACE("[ES] exit timer callback WITHOUT continue synchro !!");
			}
		} /* Otherwise, this means an eval forced the priority */
		else {
			DBGTRACE("[ES] exit timer callback WITHOUT unlocking dbg, already done !!");
		}
	}
	DBGTRACE_DWORD("[ES] exit timer callback = ", idEvent);
}

/*
///////////////////////////////////////////////////////////
///   dbg_process_evaluation   :: EC evaluation         ///
///////////////////////////////////////////////////////////
*/

#define WAIT_UNTIL_ESTUDIO_THREAD_SUSPENDED Sleep (2)

#define DBG_EVALUATION_WITH_MAXIMUM_DURATION
#ifdef DBG_EVALUATION_WITH_MAXIMUM_DURATION
rt_private time_t dbgEval_start_time_t;
rt_private void dbg_set_eval_start_time () {
	DBGTRACE("[ES::Eval] START eval timeout");
	dbgEval_start_time_t=time(NULL);
	DBGTRACE_DWORD("[ES::Eval] start timeout =", dbgEval_start_time_t);
}
rt_private BOOL dbg_check_eval_timeout (EIF_INTEGER timeout) {
	time_t delay;
	time_t t;
	t=time(NULL);
	delay = t - dbgEval_start_time_t;
	DBGTRACE_HR("[ES::Eval] check timeout =", (int) delay);
	return (delay > timeout);
}
#endif

rt_public void dbg_process_evaluation (void *icdeval, void* icdc, EIF_INTEGER timeout) {
	/* process evaluation on icdeval */

	/*** Local  ***/
	Callback_ids cb_id, old_cb_id;
    HRESULT hr = S_OK;
	BOOL eval_callback_proceed;
#ifdef DBGTRACE_ENABLED
	UINT once_enter;
#endif

	/*** Require  ***/
	REQUIRE(LOCKED_DBG_TIMER_IS_NOT_SET, "Timer disabled (context = evaluating)")
	REQUIRE(!LOCKED_CALLBACK_PROCESSING, "No callback processing")

	/*** Do  ***/
	if (LOCKED_DBG_EXIT_PROCESS_OCCURRED) {
		DBGTRACE("[ES::Eval] EXIT_PROCESS occurred previously => evaluation not possible");
		return;
	}

	LOCKED_ES_EVALUATION_START;
	DBGTRACE("[ES::Eval] START evaluation");

	if (LOCKED_DBG_STATE_IS_EQUAL (4)) {
		/* We are in notification processing
		 * we need evaluation functionalities
		 * so we force the priority and overtake the estudio unlocking */
		DBGTRACE("[ES::Eval] estudio into NOTIFY, eval forced, then estudio will end right away");
		LOCKED_DBG_STATE_INCREMENT;
	}

	/* Initialize data
	 * at begining we don't care about past */
	eval_callback_proceed = false;

	old_cb_id = (Callback_ids) LOCKED_DBG_CB_ID_VALUE;
	LOCKED_DBG_CB_ID_SET_VALUE(CB_NONE);

	/* Process the evaluation : */
	DBGTRACE_HR("[ES::Eval] Start effective evaluation: ICorDebugController->Continue(false) = ", (HRESULT)hr);

	hr = dbg_icdc_continue (icdc, false);
	if (hr < 0) {
		eval_callback_proceed = true;
		LOCKED_DBG_CB_ID_SET_VALUE(old_cb_id);
#ifdef DBG_EVALUATION_WITH_MAXIMUM_DURATION
	} else {
		dbg_set_eval_start_time();
#endif
	}

	while (!eval_callback_proceed) {
		/* While we haven't reach "eval callback", and proceed it  */

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

#ifdef DBG_EVALUATION_WITH_MAXIMUM_DURATION
			/* if timeout <= 0 , this mean we evaluate with no timeout */
			if ((timeout > 0) && (dbgEval_start_time_t > 0)) {
				if (dbg_check_eval_timeout (timeout)) {
					dbgEval_start_time_t = 0;
					hr = ((ICorDebugEval*)icdeval)->Abort();
					DBGTRACE_HR("[ES::Eval] abort evaluation hr=", (HRESULT)hr);
					CHECKHR (hr == 0, hr, "ICorDebugEval->Abort failed")
				}
			}
#endif
			Sleep (1);
		}

		/* now check if last callback is about evaluating
		 * only now, after synchronized with debugger, otherwise we may missed one */
		cb_id = (Callback_ids) LOCKED_DBG_CB_ID_VALUE;
		DBGTRACE2("[ES::Eval] LastCallback = ", Callback_name(cb_id));
		switch (cb_id) {
			case CB_EVAL_COMPLETE:
			case CB_EVAL_EXCEPTION:
				eval_callback_proceed = true;
				DBGTRACE("[ES::Eval] Eval Callback Occured ");
				break;
			case CB_EXIT_PROCESS:
				eval_callback_proceed = true;
				DBGTRACE("[ES::Eval] ExitProcess Callback Occured !!!");
				break;
			case CB2_EXCEPTION:
			case CB_EXCEPTION:
				eval_callback_proceed = false;
				DBGTRACE("[ES::Eval] Exception Callback Occured ");
				break;
			case CB_DEBUGGER_ERROR:
			case CB_BREAK:
				eval_callback_proceed = true;
				break;
			case CB_NONE:
				eval_callback_proceed = false;
				break;
			default:
				eval_callback_proceed = false;
				DBGTRACE_HR("[ES::Eval] Callback Events Occured (non stopping since evaluation)", (HRESULT)hr);
				break;
		}
		/* if eval callback occurred, we must exit after this loop
		 * but we need to do this at least once */

		DBGTRACE("[ES::Eval] will give hand to dbg and SUSPEND itself");
		LOCKED_DBG_STATE_INCREMENT;
		DBG_SUSPEND_ESTUDIO_THREAD;

		/* EC's thread has been suspended And resumed by dbg's thread */
		if (cb_id == CB_NONE) {
			cb_id = old_cb_id;
			LOCKED_DBG_CB_ID_SET_VALUE(cb_id);
		}
		DBG_NOTIFY_ESTUDIO(cb_id);

		DBGTRACE("[ES::Eval] call back finished");
		LOCKED_DBG_STATE_INCREMENT;
		DBGTRACE("[ES::Eval] eval finished");
	}
	DBGTRACE("[ES::Eval] LAST CALLBACK = EVAL Done !!!");

	/*** Ensure ***/
	ENSURE(eval_callback_proceed, "Last callback is be about evaluation")
	/*** End  ***/
	LOCKED_ES_EVALUATION_STOP;
}

/*
///////////////////////////////////////////////////////////
/// dbg_debugger_..._callback :: .NET Dbg Callback      ///
///////////////////////////////////////////////////////////
*/
rt_public void dbg_begin_callback (Callback_ids callback_id) {
	REQUIRE(!LOCKED_CALLBACK_PROCESSING, "No other callback processing")
	LOCKED_DBG_CB_ID_SET_VALUE (callback_id);
	DBGTRACE2("[CB] ENTER CALLBACK = ", Callback_name(callback_id));
	LOCKED_CALLBACK_START;
	/* It is not possible to have 2 callbacks at the same time,
	 * since it is supposed to be in the same thread ...  */

	if (LOCKED_DBG_SYNCHRO_IS_OFF) {
		/* In this case, even if the debugging is killed, i.e: synchro is OFF,
		 * a callback is received (most probably ExitProcess),
		 * then to clean everything up, we will skip all ES specific processing
		 * until dbg_finish_callback ... processing */
		return; /* Exit current feature */
	}
#ifdef DBGTRACE_ENABLED
	once_enter_cb = 0;
#endif
	while (LOCKED_DBG_STATE_IS_EQUAL (4)) {
		/* <4> Wait for ec to finish */
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
	/* we set it again, in case this is unset by dbg_stop_timer
	 * Let's tell the timer we are ready 						*/
	DBGTRACE("2 - [CB] enter dbg callback");
	LOCKED_DBG_STATE_SET_VALUE (1);

	/* <1> give hand to ec */
	DBGTRACE("3 - [CB] now s=1, it is ec's turn");
#ifdef DBGTRACE_ENABLED
	once_enter_cb = 0;
#endif
	if (LOCKED_DBG_SYNCHRO_IS_OFF) { /* We are terminating debugging .. */
		LOCKED_DBG_STATE_SET_VALUE (2);

		DBGTRACE("3.3 - [CB] now s=2, we by pass ec's turn, because dbg_keep_synchro == 0");
	} else {
		while (LOCKED_DBG_STATE_IS_EQUAL (1)) {
			/* <1> Wait for ec to finish */
			if (callback_id == CB_CREATE_PROCESS) {
				/* Special case here to let EiffelStudio debugger to have time
				 * to refresh itself before starting debugging. */
				Sleep (100);
			}
			/* Dbg wait for the Ec to call back
			 * no sleep for a spinlock (active waiting) */
#ifdef DBGTRACE_ENABLED
			if (once_enter_cb == 0) {
				DBGTRACE("3.5 - [CB] wait at entrance door");
				once_enter_cb = (once_enter_cb + 1) % 500;
			}
#endif
		}
	}
	/* <2> ec is waiting */
	LOCKED_DBG_STATE_INCREMENT;
	/* <3> ec is waiting */
	WAIT_UNTIL_ESTUDIO_THREAD_SUSPENDED;
	DBGTRACE2("5 - [CB] start exec callback :", Callback_name(callback_id));
	/* Executing callback, then come back to dbg_debugger_after_callback */
}

rt_public void dbg_finish_callback (Callback_ids callback_id) {
	/* <3> come back from callback */
	DBGTRACE2("6 - [CB] end exec callback : ", Callback_name(callback_id));
	if (callback_id == CB_EXIT_PROCESS) {
		LOCKED_DBG_EXIT_PROCESS_NOTIFY;
	}
	if (LOCKED_DBG_SYNCHRO_IS_OFF) {
		LOCKED_DBG_STATE_SET_VALUE(0);
	} else {
		/* <4> give back the hand to ec */
		LOCKED_DBG_STATE_INCREMENT;
		DBGTRACE("7 - [CB] RESUME ES");
		DBG_RESUME_ESTUDIO_THREAD;
	}

	DBGTRACE2("8 - [CB] EXIT CALLBACK = ", Callback_name(callback_id));
	/* Callback done */
	LOCKED_CALLBACK_STOP;
}

#ifdef _cplusplus
}
#endif
