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

//CorDebugManagedCallback------------------------------------------------------------------


rt_public EIF_POINTER new_cordebug_managed_callback ()
	/* Create new instance of ICorDebugManagedCallback */
{
	//HRESULT hr;
	DebuggerManagedCallback *icdmcb = new DebuggerManagedCallback();

//	hr = CoCreateInstance (CLSID_CorDebug, NULL,
//		CLSCTX_INPROC_SERVER, IID_ICorDebugManagedCallback, (void **) & icdmcb);
//
//	CHECK (hr, "Could not create ICorDebugManagedCallback")

	return icdmcb;
}

////////////////////////////////////////////////////////////////////////////


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


HRESULT DebuggerManagedCallback::initialize_callback( 
			EIF_OBJECT callback_object,
			EIF_POINTER a_cb_breakpoint ,             
			EIF_POINTER a_cb_step_complete ,          
			EIF_POINTER a_cb_break ,                  
			EIF_POINTER a_cb_exception ,             
			EIF_POINTER a_cb_eval_complete ,          
			EIF_POINTER a_cb_eval_exception ,         
			EIF_POINTER a_cb_create_process ,         
			EIF_POINTER a_cb_exit_process ,           
			EIF_POINTER a_cb_create_thread ,          
			EIF_POINTER a_cb_exit_thread ,            
			EIF_POINTER a_cb_load_module ,            
			EIF_POINTER a_cb_unload_module ,          
			EIF_POINTER a_cb_load_class ,             
			EIF_POINTER a_cb_unload_class ,           
			EIF_POINTER a_cb_debugger_error ,         
			EIF_POINTER a_cb_log_message ,            
            EIF_POINTER a_cb_log_switch ,
			EIF_POINTER a_cb_create_app_domain ,      
			EIF_POINTER a_cb_exit_app_domain ,        
			EIF_POINTER a_cb_load_assembly ,          
			EIF_POINTER a_cb_unload_assembly ,        
			EIF_POINTER a_cb_control_ctrap ,          
			EIF_POINTER a_cb_name_change ,            
			EIF_POINTER a_cb_update_module_symbols ,  
			EIF_POINTER a_cb_edit_and_continue_remap ,
			EIF_POINTER a_cb_breakpoint_set_error
		) 
{
	m_callback_adopted_object 		= eif_adopt (callback_object);
	m_cb_breakpoint 				= a_cb_breakpoint;
	m_cb_step_complete 				= a_cb_step_complete;
	m_cb_break 						= a_cb_break;
	m_cb_exception 					= a_cb_exception;
	m_cb_eval_complete 				= a_cb_eval_complete;
	m_cb_eval_exception 			= a_cb_eval_exception;
	m_cb_create_process 			= a_cb_create_process;
	m_cb_exit_process 				= a_cb_exit_process;
	m_cb_create_thread 				= a_cb_create_thread;
	m_cb_exit_thread 				= a_cb_exit_thread;
	m_cb_load_module 				= a_cb_load_module;
	m_cb_unload_module 				= a_cb_unload_module;
	m_cb_load_class 				= a_cb_load_class;
	m_cb_unload_class 				= a_cb_unload_class;
	m_cb_debugger_error 			= a_cb_debugger_error;
	m_cb_log_message 				= a_cb_log_message;
	m_cb_log_switch 				= a_cb_log_switch;
	m_cb_create_app_domain 			= a_cb_create_app_domain;
	m_cb_exit_app_domain 			= a_cb_exit_app_domain;
	m_cb_load_assembly 				= a_cb_load_assembly;
	m_cb_unload_assembly 			= a_cb_unload_assembly;
	m_cb_control_ctrap 				= a_cb_control_ctrap;
	m_cb_name_change 				= a_cb_name_change;
	m_cb_update_module_symbols 		= a_cb_update_module_symbols;
	m_cb_edit_and_continue_remap 	= a_cb_edit_and_continue_remap;
	m_cb_breakpoint_set_error 		= a_cb_breakpoint_set_error  ;


//	(FUNCTION_CAST (void, (EIF_REFERENCE)) callback_f) (eif_access (obj));

// 	DBGTRACE("[ManagedCallback] initialize_callback");
    return (S_OK);
};

HRESULT DebuggerManagedCallback::CreateProcess(ICorDebugProcess *pProcess)
{
//	DBGTRACE("[ManagedCallback] CreateProcess");
	dbg_debugger_before_callback (CB_CREATE_PROCESS, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugProcess*)) m_cb_create_process) (eif_access (m_callback_adopted_object), pProcess);
	dbg_debugger_after_callback (CB_CREATE_PROCESS);
    return (S_OK);
}

HRESULT DebuggerManagedCallback::ExitProcess(ICorDebugProcess *pProcess)
{
//	DBGTRAC);
	dbg_debugger_before_callback (CB_EXIT_PROCESS, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugProcess*)) m_cb_exit_process) (eif_access (m_callback_adopted_object), pProcess);
	dbg_debugger_after_callback (CB_EXIT_PROCESS);
    return (S_OK);
}

/*
 * CreateAppDomain is called when an app domain is created.
 */
HRESULT DebuggerManagedCallback::CreateAppDomain(ICorDebugProcess *pProcess,
                                          ICorDebugAppDomain *pAppDomain)
{
//	DBGTRACE("[ManagedCallback] CreateAppDomain ");
	dbg_debugger_before_callback (CB_CREATE_APP_DOMAIN, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugProcess*, ICorDebugAppDomain*)) m_cb_create_app_domain) (eif_access (m_callback_adopted_object), pProcess, pAppDomain);
	dbg_debugger_after_callback (CB_CREATE_APP_DOMAIN);
    return S_OK;
}

/*
 * ExitAppDomain is called when an app domain exits.
 */
HRESULT DebuggerManagedCallback::ExitAppDomain(ICorDebugProcess *pProcess,
                                        ICorDebugAppDomain *pAppDomain)
{
	dbg_debugger_before_callback (CB_EXIT_APP_DOMAIN, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugProcess*, ICorDebugAppDomain*)) m_cb_exit_app_domain) (eif_access (m_callback_adopted_object), pProcess, pAppDomain);
// 	DBGTRACE("[ManagedCallback] ExitAppDomain");
	dbg_debugger_after_callback (CB_EXIT_APP_DOMAIN);
    return S_OK;
}


/*
 * LoadAssembly is called when a CLR module is successfully
 * loaded. 
 */
HRESULT DebuggerManagedCallback::LoadAssembly(ICorDebugAppDomain *pAppDomain,
                                       ICorDebugAssembly *pAssembly)
{
	dbg_debugger_before_callback (CB_LOAD_ASSEMBLY, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugAssembly*)) m_cb_load_assembly) (eif_access (m_callback_adopted_object), pAppDomain, pAssembly);
// 	DBGTRACE("[ManagedCallback] LoadAssembly");
	dbg_debugger_after_callback (CB_LOAD_ASSEMBLY);
    return S_OK;
}

/*
 * UnloadAssembly is called when a CLR module (DLL) is unloaded. The module 
 * should not be used after this point.
 */
HRESULT DebuggerManagedCallback::UnloadAssembly(ICorDebugAppDomain *pAppDomain,
                                         ICorDebugAssembly *pAssembly)
{
	dbg_debugger_before_callback (CB_UNLOAD_ASSEMBLY, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugAssembly*)) m_cb_unload_assembly) (eif_access (m_callback_adopted_object), pAppDomain, pAssembly);
// 	DBGTRACE("[ManagedCallback] UnloadAssembly");
	dbg_debugger_after_callback (CB_UNLOAD_ASSEMBLY);
    return S_OK;
}


HRESULT DebuggerManagedCallback::Breakpoint(ICorDebugAppDomain *pAppDomain,
                                     ICorDebugThread *pThread, 
                                     ICorDebugBreakpoint *pBreakpoint)
{
	dbg_debugger_before_callback (CB_BREAKPOINT, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugThread*, ICorDebugBreakpoint*)) m_cb_breakpoint) (eif_access (m_callback_adopted_object), pAppDomain, pThread, pBreakpoint);
// 	DBGTRACE ("Breakpoint");
	dbg_debugger_after_callback (CB_BREAKPOINT);
    return S_OK;
}


HRESULT DebuggerManagedCallback::StepComplete(ICorDebugAppDomain *pAppDomain,
                                       ICorDebugThread *pThread,
                                       ICorDebugStepper *pStepper,
                                       CorDebugStepReason reason)
{
	dbg_debugger_before_callback (CB_STEP_COMPLETE, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugThread*, ICorDebugStepper*, CorDebugStepReason)) m_cb_step_complete) (eif_access (m_callback_adopted_object), pAppDomain, pThread, pStepper, reason);

//	FIXME jfiat [21/03/2003]
// 	DBGTRACE("[ManagedCallback] StepComplete");
	dbg_debugger_after_callback (CB_STEP_COMPLETE);
    return S_OK;
}

HRESULT DebuggerManagedCallback::Break(ICorDebugAppDomain *pAppDomain,
                                ICorDebugThread *pThread)
{
	dbg_debugger_before_callback (CB_BREAK, true);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugThread*)) m_cb_break) (eif_access (m_callback_adopted_object), pAppDomain, pThread);
// 	DBGTRACE("[ManagedCallback] Break");
	dbg_debugger_after_callback (CB_BREAK);
    return S_OK;
}

HRESULT DebuggerManagedCallback::Exception(ICorDebugAppDomain *pAppDomain,
                                    ICorDebugThread *pThread,
                                    BOOL unhandled)
{
	dbg_debugger_before_callback (CB_EXCEPTION, true);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugThread*, BOOL)) m_cb_exception) (eif_access (m_callback_adopted_object), pAppDomain, pThread, unhandled);
// 	DBGTRACE("[ManagedCallback] Exception");
	dbg_debugger_after_callback (CB_EXCEPTION);
    return S_OK;
}


HRESULT DebuggerManagedCallback::EvalComplete(ICorDebugAppDomain *pAppDomain,
                                       ICorDebugThread *pThread,
                                       ICorDebugEval *pEval)
{
	dbg_debugger_before_callback (CB_EVAL_COMPLETE, true);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugThread*, ICorDebugEval*)) m_cb_eval_complete) (eif_access (m_callback_adopted_object), pAppDomain, pThread, pEval);
// 	DBGTRACE("[ManagedCallback] EvalComplete");
	dbg_debugger_after_callback (CB_EVAL_COMPLETE);
    return S_OK;
}

HRESULT DebuggerManagedCallback::EvalException(ICorDebugAppDomain *pAppDomain,
                                        ICorDebugThread *pThread,
                                        ICorDebugEval *pEval)
{
	dbg_debugger_before_callback (CB_EVAL_EXCEPTION, true);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugThread*, ICorDebugEval*)) m_cb_eval_exception) (eif_access (m_callback_adopted_object), pAppDomain, pThread, pEval);
// 	DBGTRACE("[ManagedCallback] EvalException");
	dbg_debugger_after_callback (CB_EVAL_EXCEPTION);
    return S_OK;
}


HRESULT DebuggerManagedCallback::CreateThread(ICorDebugAppDomain *pAppDomain,
                                       ICorDebugThread *pThread)
{
	dbg_debugger_before_callback (CB_CREATE_THREAD, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugThread*)) m_cb_create_thread) (eif_access (m_callback_adopted_object), pAppDomain, pThread);
// 	DBGTRACE("[ManagedCallback] CreateThread");
	dbg_debugger_after_callback (CB_CREATE_THREAD);
    return S_OK;
}


HRESULT DebuggerManagedCallback::ExitThread(ICorDebugAppDomain *pAppDomain,
                                     ICorDebugThread *pThread)
{
	dbg_debugger_before_callback (CB_EXIT_THREAD, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugThread*)) m_cb_exit_thread) (eif_access (m_callback_adopted_object), pAppDomain, pThread);
// 	DBGTRACE("[ManagedCallback] ExitThread");
	dbg_debugger_after_callback (CB_EXIT_THREAD);
    return S_OK;
}

HRESULT DebuggerManagedCallback::LoadModule( ICorDebugAppDomain *pAppDomain,
                                      ICorDebugModule *pModule)
{
	dbg_debugger_before_callback (CB_LOAD_MODULE, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugModule*)) m_cb_load_module) (eif_access (m_callback_adopted_object), pAppDomain, pModule);
// 	DBGTRACE("[ManagedCallback] LoadModule");
	dbg_debugger_after_callback (CB_LOAD_MODULE);
    return S_OK;
}


HRESULT DebuggerManagedCallback::UnloadModule( ICorDebugAppDomain *pAppDomain,
                      ICorDebugModule *pModule)
{
	dbg_debugger_before_callback (CB_UNLOAD_MODULE, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugModule*)) m_cb_unload_module) (eif_access (m_callback_adopted_object), pAppDomain, pModule);
// 	DBGTRACE("[ManagedCallback] UnloadModule");
	dbg_debugger_after_callback (CB_UNLOAD_MODULE);
    return S_OK;
}


HRESULT DebuggerManagedCallback::LoadClass( ICorDebugAppDomain *pAppDomain,
                   ICorDebugClass *pClass)
{
	dbg_debugger_before_callback (CB_LOAD_CLASS, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugClass*)) m_cb_load_class) (eif_access (m_callback_adopted_object), pAppDomain, pClass);
// 	DBGTRACE("[ManagedCallback] LoadClass");
	dbg_debugger_after_callback (CB_LOAD_CLASS);
    return S_OK;
}


HRESULT DebuggerManagedCallback::UnloadClass( ICorDebugAppDomain *pAppDomain,
                     ICorDebugClass *pClass)
{
	dbg_debugger_before_callback (CB_UNLOAD_CLASS, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugClass*)) m_cb_unload_class) (eif_access (m_callback_adopted_object), pAppDomain, pClass);
// 	DBGTRACE("[ManagedCallback] UnloadClass");
	dbg_debugger_after_callback (CB_UNLOAD_CLASS);
    return S_OK;
}



HRESULT DebuggerManagedCallback::DebuggerError(ICorDebugProcess *pProcess,
                                        HRESULT errorHR,
                                        DWORD errorCode)
{
	dbg_debugger_before_callback (CB_DEBUGGER_ERROR, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugProcess*, HRESULT, DWORD)) m_cb_debugger_error) (eif_access (m_callback_adopted_object), pProcess, errorHR, errorCode);
// 	DBGTRACE("[ManagedCallback] DebuggerError");
	dbg_debugger_after_callback (CB_DEBUGGER_ERROR);
    return (S_OK);
}


HRESULT DebuggerManagedCallback::LogMessage(ICorDebugAppDomain *pAppDomain,
                  ICorDebugThread *pThread,
                  LONG lLevel,
                  WCHAR *pLogSwitchName,
                  WCHAR *pMessage)
{
	dbg_debugger_before_callback (CB_LOG_MESSAGE, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugThread*, LONG, WCHAR*, WCHAR*)) m_cb_log_message) (eif_access (m_callback_adopted_object), pAppDomain, pThread, lLevel, pLogSwitchName, pMessage);
// 	DBGTRACE("[ManagedCallback] LogMessage");
	dbg_debugger_after_callback (CB_LOG_MESSAGE);
    return S_OK;
}


HRESULT DebuggerManagedCallback::LogSwitch(ICorDebugAppDomain *pAppDomain,
                  ICorDebugThread *pThread,
                  LONG lLevel,
                  ULONG ulReason,
                  WCHAR *pLogSwitchName,
                  WCHAR *pParentName)
{
	dbg_debugger_before_callback (CB_LOG_SWITCH, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugThread*, LONG, ULONG,  WCHAR*, WCHAR*)) m_cb_log_switch) (eif_access (m_callback_adopted_object), pAppDomain, pThread, lLevel, ulReason, pLogSwitchName, pParentName);
// 	DBGTRACE("[ManagedCallback] LogSwitch");
	dbg_debugger_after_callback (CB_LOG_SWITCH);
    return S_OK;
}

HRESULT DebuggerManagedCallback::ControlCTrap(ICorDebugProcess *pProcess)
{
	dbg_debugger_before_callback (CB_CONTROL_CTRAP, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugProcess*)) m_cb_control_ctrap) (eif_access (m_callback_adopted_object), pProcess);
// 	DBGTRACE("[ManagedCallback] ControlCTrap");
	dbg_debugger_after_callback (CB_CONTROL_CTRAP);
    return S_OK;
}

HRESULT DebuggerManagedCallback::NameChange(ICorDebugAppDomain *pAppDomain, 
                                     ICorDebugThread *pThread)
{
	dbg_debugger_before_callback (CB_NAME_CHANGE, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugThread*)) m_cb_name_change) (eif_access (m_callback_adopted_object), pAppDomain, pThread);
// 	DBGTRACE("[ManagedCallback] NameChange");
	dbg_debugger_after_callback (CB_NAME_CHANGE);
    return S_OK;
}


HRESULT DebuggerManagedCallback::UpdateModuleSymbols(ICorDebugAppDomain *pAppDomain,
                                              ICorDebugModule *pModule,
                                              IStream *pSymbolStream)
{
	dbg_debugger_before_callback (CB_UPDATE_MODULE_SYMBOLS, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugModule*, IStream*)) m_cb_update_module_symbols) (eif_access (m_callback_adopted_object), pAppDomain, pModule, pSymbolStream);
// 	DBGTRACE("[ManagedCallback] UpdateModuleSymbols");
	dbg_debugger_after_callback (CB_UPDATE_MODULE_SYMBOLS);
    return S_OK;
}

HRESULT DebuggerManagedCallback::EditAndContinueRemap(ICorDebugAppDomain *pAppDomain,
                                               ICorDebugThread *pThread, 
                                               ICorDebugFunction *pFunction,
                                               BOOL fAccurate)
{
	dbg_debugger_before_callback (CB_EDIT_AND_CONTINUE_REMAP, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugThread*, ICorDebugFunction*, BOOL)) m_cb_edit_and_continue_remap) (eif_access (m_callback_adopted_object), pAppDomain, pThread, pFunction, fAccurate);
// 	DBGTRACE("[ManagedCallback] EditAndContinueRemap");
	dbg_debugger_after_callback (CB_EDIT_AND_CONTINUE_REMAP);
    return S_OK;
}

HRESULT DebuggerManagedCallback::BreakpointSetError(ICorDebugAppDomain *pAppDomain,
                                             ICorDebugThread *pThread, 
                                             ICorDebugBreakpoint *pBreakpoint,
                                             DWORD dwError)
{
	dbg_debugger_before_callback (CB_BREAKPOINT_SET_ERROR, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, ICorDebugAppDomain*, ICorDebugThread*, ICorDebugBreakpoint*, DWORD)) m_cb_breakpoint_set_error) (eif_access (m_callback_adopted_object), pAppDomain, pThread, pBreakpoint, dwError);
// 	DBGTRACE("[ManagedCallback] BreakpointSetError");
	dbg_debugger_after_callback (CB_BREAKPOINT_SET_ERROR);
    return S_OK;
}


/* UnManaged ... */

HRESULT DebuggerUnmanagedCallback::initialize_callback( 
			EIF_OBJECT callback_object,
			EIF_POINTER a_ucb_debug_event
		) 
{
	m_callback_adopted_object 	= eif_adopt (callback_object);
	m_ucb_debug_event 			= a_ucb_debug_event;
 	DBGTRACE("[UnManagedCallback] initialize_callback");
    return (S_OK);
};

HRESULT DebuggerUnmanagedCallback::DebugEvent(LPDEBUG_EVENT event,
                                              BOOL fIsOutOfBand)
{
	dbg_debugger_before_callback (CB_DEBUG_EVENT, false);
	(FUNCTION_CAST (void, (EIF_REFERENCE, LPDEBUG_EVENT, BOOL)) m_ucb_debug_event) (eif_access (m_callback_adopted_object), event, fIsOutOfBand);
 	DBGTRACE("[UnManagedCallback] DebugEvent");
	dbg_debugger_after_callback (CB_DEBUG_EVENT);
    return (S_OK);
}

#ifdef _cplusplus
}
#endif

