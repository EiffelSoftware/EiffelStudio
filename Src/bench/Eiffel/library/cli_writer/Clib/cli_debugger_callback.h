#ifndef __PE_DEBUGGER_CALLBACK_H_
#define __PE_DEBUGGER_CALLBACK_H_

#include "eif_eiffel.h"
#include <windows.h>
#include "cli_headers.h"



#ifdef __cplusplus
extern "C" {
#endif

extern EIF_POINTER new_cordebug_managed_callback ();


#ifdef __cplusplus
}
#endif

#define COM_METHOD HRESULT STDMETHODCALLTYPE

#ifdef __cplusplus
class DebuggerManagedCallback : public ICorDebugManagedCallback
{
public:    
    DebuggerManagedCallback() : m_refCount(0)
    {
    }

    // 
    // IUnknown
    //

    ULONG STDMETHODCALLTYPE AddRef() 
    {
        return (InterlockedIncrement((long *) &m_refCount));
    }

    ULONG STDMETHODCALLTYPE Release() 
    {
        long refCount = InterlockedDecrement(&m_refCount);
        if (refCount == 0)
            delete this;

        return (refCount);
    }

    COM_METHOD QueryInterface(REFIID riid, void **ppInterface)
    {
        if (riid == IID_IUnknown)
            *ppInterface = (IUnknown *) this;
        else if (riid == IID_ICorDebugManagedCallback)
            *ppInterface = (ICorDebugManagedCallback *) this;
        else
            return (E_NOINTERFACE);

        this->AddRef();
        return (S_OK);
    }


    // 
    // ICorDebugManagedCallback
    //

    COM_METHOD CreateProcess(ICorDebugProcess *pProcess);
    COM_METHOD ExitProcess(ICorDebugProcess *pProcess);
    COM_METHOD DebuggerError(ICorDebugProcess *pProcess,
                             HRESULT errorHR,
                             DWORD errorCode);

	COM_METHOD CreateAppDomain(ICorDebugProcess *pProcess,
							ICorDebugAppDomain *pAppDomain); 

	COM_METHOD ExitAppDomain(ICorDebugProcess *pProcess,
						  ICorDebugAppDomain *pAppDomain); 

	COM_METHOD LoadAssembly(ICorDebugAppDomain *pAppDomain,
						 ICorDebugAssembly *pAssembly);

	COM_METHOD UnloadAssembly(ICorDebugAppDomain *pAppDomain,
						   ICorDebugAssembly *pAssembly);

	COM_METHOD Breakpoint( ICorDebugAppDomain *pAppDomain,
					    ICorDebugThread *pThread, 
					    ICorDebugBreakpoint *pBreakpoint);

	COM_METHOD StepComplete( ICorDebugAppDomain *pAppDomain,
						  ICorDebugThread *pThread,
						  ICorDebugStepper *pStepper,
						  CorDebugStepReason reason);

	COM_METHOD Break( ICorDebugAppDomain *pAppDomain,
				   ICorDebugThread *thread);

	COM_METHOD Exception( ICorDebugAppDomain *pAppDomain,
					   ICorDebugThread *pThread,
					   BOOL unhandled);

	COM_METHOD EvalComplete( ICorDebugAppDomain *pAppDomain,
                               ICorDebugThread *pThread,
                               ICorDebugEval *pEval);

	COM_METHOD EvalException( ICorDebugAppDomain *pAppDomain,
                                ICorDebugThread *pThread,
                                ICorDebugEval *pEval);

	COM_METHOD CreateThread( ICorDebugAppDomain *pAppDomain,
						  ICorDebugThread *thread);

	COM_METHOD ExitThread( ICorDebugAppDomain *pAppDomain,
					    ICorDebugThread *thread);

	COM_METHOD LoadModule( ICorDebugAppDomain *pAppDomain,
					    ICorDebugModule *pModule);

	COM_METHOD UnloadModule( ICorDebugAppDomain *pAppDomain,
						  ICorDebugModule *pModule);

	COM_METHOD LoadClass( ICorDebugAppDomain *pAppDomain,
					   ICorDebugClass *c);

	COM_METHOD UnloadClass( ICorDebugAppDomain *pAppDomain,
						 ICorDebugClass *c);

	COM_METHOD LogMessage(ICorDebugAppDomain *pAppDomain,
                      ICorDebugThread *pThread,
					  LONG lLevel,
					  WCHAR *pLogSwitchName,
					  WCHAR *pMessage);

	COM_METHOD LogSwitch(ICorDebugAppDomain *pAppDomain,
                      ICorDebugThread *pThread,
					  LONG lLevel,
					  ULONG ulReason,
					  WCHAR *pLogSwitchName,
					  WCHAR *pParentName);

    COM_METHOD ControlCTrap(ICorDebugProcess *pProcess);
    
	COM_METHOD NameChange(ICorDebugAppDomain *pAppDomain, 
                          ICorDebugThread *pThread);

    COM_METHOD UpdateModuleSymbols(ICorDebugAppDomain *pAppDomain,
                                   ICorDebugModule *pModule,
                                   IStream *pSymbolStream);
                                   
    COM_METHOD EditAndContinueRemap(ICorDebugAppDomain *pAppDomain,
                                    ICorDebugThread *pThread, 
                                    ICorDebugFunction *pFunction,
                                    BOOL fAccurate);
    COM_METHOD BreakpointSetError(ICorDebugAppDomain *pAppDomain,
                                  ICorDebugThread *pThread,
                                  ICorDebugBreakpoint *pBreakpoint,
                                  DWORD dwError);
    
	//
	// initialize_callback called from Eiffel
	// 
    HRESULT initialize_callback( 
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
			);

	HRESULT terminate_callback() ;

protected:
    long        m_refCount;

	EIF_OBJECT  m_callback_adopted_object;

	EIF_POINTER m_cb_breakpoint ;             
	EIF_POINTER m_cb_step_complete ;          
	EIF_POINTER m_cb_break ;                  
	EIF_POINTER m_cb_exception ;             
	EIF_POINTER m_cb_eval_complete ;          
	EIF_POINTER m_cb_eval_exception ;         
	EIF_POINTER m_cb_create_process ;         
	EIF_POINTER m_cb_exit_process ;           
	EIF_POINTER m_cb_create_thread ;          
	EIF_POINTER m_cb_exit_thread ;            
	EIF_POINTER m_cb_load_module ;            
	EIF_POINTER m_cb_unload_module ;          
	EIF_POINTER m_cb_load_class ;             
	EIF_POINTER m_cb_unload_class ;           
	EIF_POINTER m_cb_debugger_error ;         
	EIF_POINTER m_cb_log_message ;            
	EIF_POINTER m_cb_log_switch ;
	EIF_POINTER m_cb_create_app_domain ;      
	EIF_POINTER m_cb_exit_app_domain ;        
	EIF_POINTER m_cb_load_assembly ;          
	EIF_POINTER m_cb_unload_assembly ;        
	EIF_POINTER m_cb_control_ctrap ;          
	EIF_POINTER m_cb_name_change ;            
	EIF_POINTER m_cb_update_module_symbols ;  
	EIF_POINTER m_cb_edit_and_continue_remap ;
	EIF_POINTER m_cb_breakpoint_set_error;
};


/* ------------------------------------------------------------------------- *
 * DebuggerUnmanagedCallback
 * ------------------------------------------------------------------------- */

class DebuggerUnmanagedCallback : public ICorDebugUnmanagedCallback
{
public:    
    DebuggerUnmanagedCallback() : m_refCount(0)
    {
    }

	//
	// initialize_callback called from Eiffel
	// 
    HRESULT initialize_callback( 
			EIF_OBJECT callback_object,
			EIF_POINTER a_ucb_debug_event
			);

	HRESULT terminate_callback() ;

    // IUnknown
    ULONG STDMETHODCALLTYPE AddRef() 
    {
        return (InterlockedIncrement((long *) &m_refCount));
    }

    ULONG STDMETHODCALLTYPE Release() 
    {
        long refCount = InterlockedDecrement(&m_refCount);
        if (refCount == 0)
            delete this;

        return (refCount);
    }

    COM_METHOD QueryInterface(REFIID riid, void **ppInterface)
    {
        if (riid == IID_IUnknown)
            *ppInterface = (IUnknown*)(ICorDebugUnmanagedCallback*)this;
        else if (riid == IID_ICorDebugUnmanagedCallback)
            *ppInterface = (ICorDebugUnmanagedCallback*) this;
        else
            return (E_NOINTERFACE);

        this->AddRef();
        return (S_OK);
    }

    COM_METHOD DebugEvent(LPDEBUG_EVENT pDebugEvent, BOOL fIsOutOfband);

protected:
    long        m_refCount;

	EIF_OBJECT  m_callback_adopted_object;

	EIF_POINTER m_ucb_debug_event ;             
};

#endif /* __cplusplus */

#endif
