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

protected:
    long        m_refCount;

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

};

#endif /* __cplusplus */

#endif
