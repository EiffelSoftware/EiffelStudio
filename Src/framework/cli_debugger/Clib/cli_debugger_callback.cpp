#include "cli_debugger.h"
#include "cli_debugger_callback.h"
#include "cli_debugger_callback_id.h"

#include <objbase.h>
#include <cor.h>

#include <cordebug.h>

#include <mscoree.h>

#ifdef _cplusplus
extern "C" {
#endif

const IID IID_ICorDebugManagedCallback = {0x3d6f5f60,0x7538,0x11d3,0x8d,0x5b,0x00,0x10,0x4b,0x35,0xe7,0xef};
const IID IID_ICorDebugUnmanagedCallback = {0x5263E909,0x8CB5,0x11d3,0xBD,0x2F,0x00,0x00,0xF8,0x08,0x49,0xBD};
const IID IID_ICorDebugManagedCallback2 = {0x250E5EEA,0xDB5C,0x4C76,0xB6,0xF3,0x8C,0x46,0xF1,0x2E,0x32,0x03};

#ifdef DBGTRACE_ENABLED
rt_public void trace_event_cb (char* mesg)
{
  FILE *out;
  out=fopen("eif_debugger.out","a+");
  fprintf(out,"%s\n",mesg);
  fclose(out);
}
rt_public void trace_event_cb_hr (char* mesg,HRESULT hr)
{
  FILE *out;
  out=fopen("eif_debugger.out","a+");
  fprintf(out,"<HR=%d> %s \n",
					hr,
					mesg
					);
  fclose(out);
}

#define DBGTRACE(msg) trace_event_cb(msg);
#define DBGTRACE_HR(msg,hr) trace_event_cb_hr(msg,hr);
#else
#define DBGTRACE(msg)
#define DBGTRACE_HR(msg)
#endif

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
feature -- COM specific
*/

#ifdef EIF_ASSERTIONS
rt_private void raise_error (HRESULT hr, char *msg)
	/* Raise an Eiffel exception */
{
	sprintf (message, "0x%x: %s", hr, msg);
	eraise (message, EN_PROG);
}
#endif


#ifdef _DEBUG
	#define RELEASE(iptr)               \
	    {                               \
	        _ASSERTE(iptr);             \
	        iptr->Release();            \
	        iptr = NULL;                \
	    }

	#define VERIFY(stmt) _ASSERTE((stmt))

#else

	#define RELEASE(iptr)               \
	    iptr->Release();

	#define VERIFY(stmt) (stmt)

#endif // _DEBUG


/* ///////////////////////////////////
 * //   Managed ...                 //
 * /////////////////////////////////// */

HRESULT DebuggerManagedCallback::CreateProcess(ICorDebugProcess *pProcess)
{
	dbg_begin_callback (CB_CREATE_PROCESS);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_CREATE_PROCESS);
	SET_DBG_CB_INFO_POINTER(1, pProcess);
//	DBGTRACE("[ManagedCallback] CreateProcess");
	dbg_finish_callback (CB_CREATE_PROCESS);
    return (S_OK);
}

HRESULT DebuggerManagedCallback::ExitProcess(ICorDebugProcess *pProcess)
{
	dbg_begin_callback (CB_EXIT_PROCESS);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_EXIT_PROCESS);
	SET_DBG_CB_INFO_POINTER(1, pProcess);
//	DBGTRACE("[ManagedCallback] ExitProcess");
	dbg_finish_callback (CB_EXIT_PROCESS);
    return (S_OK);
}

/*
 * CreateAppDomain is called when an app domain is created.
 */
HRESULT DebuggerManagedCallback::CreateAppDomain(ICorDebugProcess *pProcess,
                                          ICorDebugAppDomain *pAppDomain)
{
	HRESULT hr;
	dbg_begin_callback (CB_CREATE_APP_DOMAIN);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_CREATE_APP_DOMAIN);
	SET_DBG_CB_INFO_POINTER(1, pProcess);
	SET_DBG_CB_INFO_POINTER(2, pAppDomain);

	/* This has to be performed during callback processing, not after 
	 * or while the debuggee is stopped */

	hr = pAppDomain->Attach();
	CHECKHR ((((hr == S_OK) || (hr == S_FALSE)) ? 0 : 1), hr, "Could not attach debugger to AppDomain");

//	DBGTRACE("[ManagedCallback] CreateAppDomain ");
	dbg_finish_callback (CB_CREATE_APP_DOMAIN);
    return S_OK;
}

/*
 * ExitAppDomain is called when an app domain exits.
 */
HRESULT DebuggerManagedCallback::ExitAppDomain(ICorDebugProcess *pProcess,
                                        ICorDebugAppDomain *pAppDomain)
{
	dbg_begin_callback (CB_EXIT_APP_DOMAIN);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_EXIT_APP_DOMAIN);
	SET_DBG_CB_INFO_POINTER(1, pProcess);
	SET_DBG_CB_INFO_POINTER(2, pAppDomain);
// 	DBGTRACE("[ManagedCallback] ExitAppDomain");
	dbg_finish_callback (CB_EXIT_APP_DOMAIN);
    return S_OK;
}


/*
 * LoadAssembly is called when a CLR module is successfully
 * loaded. 
 */
HRESULT DebuggerManagedCallback::LoadAssembly(ICorDebugAppDomain *pAppDomain,
                                       ICorDebugAssembly *pAssembly)
{
	dbg_begin_callback (CB_LOAD_ASSEMBLY);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_LOAD_ASSEMBLY);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pAssembly);
// 	DBGTRACE("[ManagedCallback] LoadAssembly");
	dbg_finish_callback (CB_LOAD_ASSEMBLY);
    return S_OK;
}

/*
 * UnloadAssembly is called when a CLR module (DLL) is unloaded. The module 
 * should not be used after this point.
 */
HRESULT DebuggerManagedCallback::UnloadAssembly(ICorDebugAppDomain *pAppDomain,
                                         ICorDebugAssembly *pAssembly)
{
	dbg_begin_callback (CB_UNLOAD_ASSEMBLY);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_UNLOAD_ASSEMBLY);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pAssembly);
// 	DBGTRACE("[ManagedCallback] UnloadAssembly");
	dbg_finish_callback (CB_UNLOAD_ASSEMBLY);
    return S_OK;
}


HRESULT DebuggerManagedCallback::Breakpoint(ICorDebugAppDomain *pAppDomain,
                                     ICorDebugThread *pThread, 
                                     ICorDebugBreakpoint *pBreakpoint)
{
	dbg_begin_callback (CB_BREAKPOINT);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_BREAKPOINT);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
	SET_DBG_CB_INFO_POINTER(3, pBreakpoint);
// 	DBGTRACE ("Breakpoint");
	dbg_finish_callback (CB_BREAKPOINT);
    return S_OK;
}


HRESULT DebuggerManagedCallback::StepComplete(ICorDebugAppDomain *pAppDomain,
                                       ICorDebugThread *pThread,
                                       ICorDebugStepper *pStepper,
                                       CorDebugStepReason reason)
{
	dbg_begin_callback (CB_STEP_COMPLETE);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_STEP_COMPLETE);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
	SET_DBG_CB_INFO_POINTER(3, pStepper);
	SET_DBG_CB_INFO_INTEGER(4, reason);
// 	DBGTRACE("[ManagedCallback] StepComplete");
	dbg_finish_callback (CB_STEP_COMPLETE);
    return S_OK;
}

HRESULT DebuggerManagedCallback::Break(ICorDebugAppDomain *pAppDomain,
                                ICorDebugThread *pThread)
{
	dbg_begin_callback (CB_BREAK);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_BREAK);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
// 	DBGTRACE("[ManagedCallback] Break");
	dbg_finish_callback (CB_BREAK);
    return S_OK;
}

HRESULT DebuggerManagedCallback::Exception(ICorDebugAppDomain *pAppDomain,
                                    ICorDebugThread *pThread,
                                    BOOL unhandled)
{
	HRESULT hr;
	ICorDebugValue *pExceptionValue;

	dbg_begin_callback (CB_EXCEPTION);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_EXCEPTION);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
	SET_DBG_CB_INFO_BOOL(3, unhandled);

	/* This has to be performed during callback processing, not after 
	 * or while the debuggee is stopped */

	hr = pThread->GetCurrentException (&pExceptionValue);
	if (SUCCEEDED(hr)) {
		SET_DBG_CB_INFO_POINTER(4, pExceptionValue);
	}
// 	DBGTRACE("[ManagedCallback] Exception");
	dbg_finish_callback (CB_EXCEPTION);
    return S_OK;
}


HRESULT DebuggerManagedCallback::EvalComplete(ICorDebugAppDomain *pAppDomain,
                                       ICorDebugThread *pThread,
                                       ICorDebugEval *pEval)
{
	dbg_begin_callback (CB_EVAL_COMPLETE);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_EVAL_COMPLETE);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
	SET_DBG_CB_INFO_POINTER(3, pEval);
// 	DBGTRACE("[ManagedCallback] EvalComplete");
	dbg_finish_callback (CB_EVAL_COMPLETE);
    return S_OK;
}

HRESULT DebuggerManagedCallback::EvalException(ICorDebugAppDomain *pAppDomain,
                                        ICorDebugThread *pThread,
                                        ICorDebugEval *pEval)
{
	dbg_begin_callback (CB_EVAL_EXCEPTION);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_EVAL_EXCEPTION);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
	SET_DBG_CB_INFO_POINTER(3, pEval);
// 	DBGTRACE("[ManagedCallback] EvalException");
	dbg_finish_callback (CB_EVAL_EXCEPTION);
    return S_OK;
}


HRESULT DebuggerManagedCallback::CreateThread(ICorDebugAppDomain *pAppDomain,
                                       ICorDebugThread *pThread)
{
	dbg_begin_callback (CB_CREATE_THREAD);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_CREATE_THREAD);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
// 	DBGTRACE("[ManagedCallback] CreateThread");
	dbg_finish_callback (CB_CREATE_THREAD);
    return S_OK;
}


HRESULT DebuggerManagedCallback::ExitThread(ICorDebugAppDomain *pAppDomain,
                                     ICorDebugThread *pThread)
{
	dbg_begin_callback (CB_EXIT_THREAD);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_EXIT_THREAD);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
// 	DBGTRACE("[ManagedCallback] ExitThread");
	dbg_finish_callback (CB_EXIT_THREAD);
    return S_OK;
}

HRESULT DebuggerManagedCallback::LoadModule( ICorDebugAppDomain *pAppDomain,
                                      ICorDebugModule *pModule)
{
	dbg_begin_callback (CB_LOAD_MODULE);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_LOAD_MODULE);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pModule);

	/* This has to be performed during callback processing, not after 
	 * or while the debuggee is stopped */

	pModule->EnableJITDebugging (true, false);
// 	DBGTRACE("[ManagedCallback] LoadModule");
	dbg_finish_callback (CB_LOAD_MODULE);
    return S_OK;
}


HRESULT DebuggerManagedCallback::UnloadModule( ICorDebugAppDomain *pAppDomain,
                      ICorDebugModule *pModule)
{
	dbg_begin_callback (CB_UNLOAD_MODULE);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_UNLOAD_MODULE);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pModule);
// 	DBGTRACE("[ManagedCallback] UnloadModule");
	dbg_finish_callback (CB_UNLOAD_MODULE);
    return S_OK;
}


HRESULT DebuggerManagedCallback::LoadClass( ICorDebugAppDomain *pAppDomain,
                   ICorDebugClass *pClass)
{
	dbg_begin_callback (CB_LOAD_CLASS);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_LOAD_CLASS);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pClass);
// 	DBGTRACE("[ManagedCallback] LoadClass");
	dbg_finish_callback (CB_LOAD_CLASS);
    return S_OK;
}


HRESULT DebuggerManagedCallback::UnloadClass( ICorDebugAppDomain *pAppDomain,
                     ICorDebugClass *pClass)
{
	dbg_begin_callback (CB_UNLOAD_CLASS);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_UNLOAD_CLASS);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pClass);
// 	DBGTRACE("[ManagedCallback] UnloadClass");
	dbg_finish_callback (CB_UNLOAD_CLASS);
    return S_OK;
}



HRESULT DebuggerManagedCallback::DebuggerError(ICorDebugProcess *pProcess,
                                        HRESULT errorHR,
                                        DWORD errorCode)
{
	dbg_begin_callback (CB_DEBUGGER_ERROR);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_DEBUGGER_ERROR);
	SET_DBG_CB_INFO_POINTER(1, pProcess);
	SET_DBG_CB_INFO_INTEGER(2, errorHR);
	SET_DBG_CB_INFO_DWORD(3, errorCode);
// 	DBGTRACE("[ManagedCallback] DebuggerError");
	dbg_finish_callback (CB_DEBUGGER_ERROR);
    return (S_OK);
}


HRESULT DebuggerManagedCallback::LogMessage(ICorDebugAppDomain *pAppDomain,
                  ICorDebugThread *pThread,
                  LONG lLevel,
                  WCHAR *pLogSwitchName,
                  WCHAR *pMessage)
{
	dbg_begin_callback (CB_LOG_MESSAGE);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_LOG_MESSAGE);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
	/* UnUsed Args ... */
// 	DBGTRACE("[ManagedCallback] LogMessage");
	dbg_finish_callback (CB_LOG_MESSAGE);
    return S_OK;
}


HRESULT DebuggerManagedCallback::LogSwitch(ICorDebugAppDomain *pAppDomain,
                  ICorDebugThread *pThread,
                  LONG lLevel,
                  ULONG ulReason,
                  WCHAR *pLogSwitchName,
                  WCHAR *pParentName)
{
	dbg_begin_callback (CB_LOG_SWITCH);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_LOG_SWITCH);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
	/* UnUsed Args ... */
// 	DBGTRACE("[ManagedCallback] LogSwitch");
	dbg_finish_callback (CB_LOG_SWITCH);
    return S_OK;
}

HRESULT DebuggerManagedCallback::ControlCTrap(ICorDebugProcess *pProcess)
{
	dbg_begin_callback (CB_CONTROL_CTRAP);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_CONTROL_CTRAP);
	SET_DBG_CB_INFO_POINTER(1, pProcess);
// 	DBGTRACE("[ManagedCallback] ControlCTrap");
	dbg_finish_callback (CB_CONTROL_CTRAP);
    return S_OK;
}

HRESULT DebuggerManagedCallback::NameChange(ICorDebugAppDomain *pAppDomain, 
                                     ICorDebugThread *pThread)
{
	dbg_begin_callback (CB_NAME_CHANGE);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_NAME_CHANGE);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
// 	DBGTRACE("[ManagedCallback] NameChange");
	dbg_finish_callback (CB_NAME_CHANGE);
    return S_OK;
}


HRESULT DebuggerManagedCallback::UpdateModuleSymbols(ICorDebugAppDomain *pAppDomain,
                                              ICorDebugModule *pModule,
                                              IStream *pSymbolStream)
{
	dbg_begin_callback (CB_UPDATE_MODULE_SYMBOLS);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_UPDATE_MODULE_SYMBOLS);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pModule);
	/* UnUsed args */
// 	DBGTRACE("[ManagedCallback] UpdateModuleSymbols");
	dbg_finish_callback (CB_UPDATE_MODULE_SYMBOLS);
    return S_OK;
}

HRESULT DebuggerManagedCallback::EditAndContinueRemap(ICorDebugAppDomain *pAppDomain,
                                               ICorDebugThread *pThread, 
                                               ICorDebugFunction *pFunction,
                                               BOOL fAccurate)
{
	dbg_begin_callback (CB_EDIT_AND_CONTINUE_REMAP);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_EDIT_AND_CONTINUE_REMAP);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
	SET_DBG_CB_INFO_POINTER(3, pFunction);
	/* UnUsed args */
// 	DBGTRACE("[ManagedCallback] EditAndContinueRemap");
	dbg_finish_callback (CB_EDIT_AND_CONTINUE_REMAP);
    return S_OK;
}

HRESULT DebuggerManagedCallback::BreakpointSetError(ICorDebugAppDomain *pAppDomain,
                                             ICorDebugThread *pThread, 
                                             ICorDebugBreakpoint *pBreakpoint,
                                             DWORD dwError)
{
	dbg_begin_callback (CB_BREAKPOINT_SET_ERROR);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_BREAKPOINT_SET_ERROR);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
	SET_DBG_CB_INFO_POINTER(3, pBreakpoint);
	SET_DBG_CB_INFO_DWORD(4, dwError);
// 	DBGTRACE("[ManagedCallback] BreakpointSetError");
	dbg_finish_callback (CB_BREAKPOINT_SET_ERROR);
    return S_OK;
}


/* ///////////////////////////////////
 * //  ICorDebugManagedCallback2 .. //
 * /////////////////////////////////// */

HRESULT DebuggerManagedCallback::FunctionRemapOpportunity(ICorDebugAppDomain *pAppDomain,
                                     ICorDebugThread *pThread,
                                     ICorDebugFunction *pOldFunction,
                                     ICorDebugFunction *pNewFunction,
                                     ULONG32 oldILOffset)
{
	dbg_begin_callback (CB2_FUNCTION_REMAP_OPPORTUNITY);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB2_FUNCTION_REMAP_OPPORTUNITY);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
	dbg_finish_callback (CB2_FUNCTION_REMAP_OPPORTUNITY);
	return S_OK;
}

    /*
     * CreateConnection is called when a new connection is created.
     */
HRESULT DebuggerManagedCallback::CreateConnection(ICorDebugProcess *pProcess,
                             CONNID dwConnectionId,
                             WCHAR *pConnName)
{
	dbg_begin_callback (CB2_CREATE_CONNECTION);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB2_CREATE_CONNECTION);
	SET_DBG_CB_INFO_POINTER(1, pProcess);
	dbg_finish_callback (CB2_CREATE_CONNECTION);
	return S_OK;
}

    /*
     * ChangeConnection is called when a connection's set of tasks changes.
     */
HRESULT DebuggerManagedCallback::ChangeConnection(ICorDebugProcess *pProcess,
                             CONNID dwConnectionId ) 
{
	dbg_begin_callback (CB2_CHANGE_CONNECTION);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB2_CHANGE_CONNECTION);
	SET_DBG_CB_INFO_POINTER(1, pProcess);
	dbg_finish_callback (CB2_CHANGE_CONNECTION);
	return S_OK;
}

    /*
     * DestroyConnection is called when a connection is ended.
     */
HRESULT DebuggerManagedCallback::DestroyConnection(ICorDebugProcess *pProcess,
                              CONNID dwConnectionId )
{
	dbg_begin_callback (CB2_DESTROY_CONNECTION);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB2_DESTROY_CONNECTION);
	SET_DBG_CB_INFO_POINTER(1, pProcess);
	dbg_finish_callback (CB2_DESTROY_CONNECTION);
	return S_OK;
}

    /*
     * Exception is called at various points during the search phase of the
     * exception-handling process.  The exception being processed can be
     * retrieved from the ICorDebugThread.
     */

HRESULT DebuggerManagedCallback::Exception(ICorDebugAppDomain *pAppDomain,
                       ICorDebugThread *pThread,
                       ICorDebugFrame *pFrame,
                       ULONG32 nOffset,
                       CorDebugExceptionCallbackType dwEventType,
                       DWORD dwFlags )
{
	dbg_begin_callback (CB2_EXCEPTION);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB2_EXCEPTION);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
	dbg_finish_callback (CB2_EXCEPTION);
	return S_OK;
}

    /*
     * ExceptionUnwind is called at various points during the unwind phase
     * of the exception-handling process.
     */
HRESULT DebuggerManagedCallback::ExceptionUnwind(ICorDebugAppDomain *pAppDomain,
                             ICorDebugThread *pThread,
                             CorDebugExceptionUnwindCallbackType dwEventType,
                             DWORD dwFlags )
{
	dbg_begin_callback (CB2_EXCEPTION_UNWIND);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB2_EXCEPTION_UNWIND);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
	dbg_finish_callback (CB2_EXCEPTION);
	return S_OK;
}

    /*
     * FunctionRemapComplete is fired whenever execution switches over to a new version of a function.
     * At this point steppers can be added to that new version of the function, and no sooner.
     *
     */
HRESULT DebuggerManagedCallback::FunctionRemapComplete(ICorDebugAppDomain *pAppDomain,
                                     ICorDebugThread *pThread,
                                     ICorDebugFunction *pFunction)
{
	dbg_begin_callback (CB2_FUNCTION_REMAP_COMPLETE);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB2_FUNCTION_REMAP_COMPLETE);
	SET_DBG_CB_INFO_POINTER(1, pAppDomain);
	SET_DBG_CB_INFO_POINTER(2, pThread);
	SET_DBG_CB_INFO_POINTER(3, pFunction);
	dbg_finish_callback (CB2_FUNCTION_REMAP_COMPLETE);
	return S_OK;
}


HRESULT DebuggerManagedCallback::MDANotification(ICorDebugController *pController,
                                     ICorDebugThread *pThread,
                                     ICorDebugMDA *pMDA)
{
	dbg_begin_callback (CB2_MDANOTIFICATION);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB2_MDANOTIFICATION);
	SET_DBG_CB_INFO_POINTER(1, pController);
	SET_DBG_CB_INFO_POINTER(2, pThread);
	dbg_finish_callback (CB2_MDANOTIFICATION);
	return S_OK;
}

/* ///////////////////////////////////
 * // UnManaged ...                 //
 * /////////////////////////////////// */


HRESULT DebuggerUnmanagedCallback::DebugEvent(LPDEBUG_EVENT event,
                                              BOOL fIsOutOfBand)
{
	dbg_begin_callback (CB_DEBUG_EVENT);
	CLEAR_DBG_CB_INFO;
	SET_DBG_CB_INFO_CALLBACK_ID(CB_DEBUG_EVENT);
	/* UnUsed args */
// 	DBGTRACE("[UnManagedCallback] DebugEvent");
	dbg_finish_callback (CB_DEBUG_EVENT);
    return (S_OK);
}

#ifdef _cplusplus
}
#endif

