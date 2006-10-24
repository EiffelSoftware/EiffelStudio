#ifndef __PE_DEBUGGER_CALLBACK_H_
#define __PE_DEBUGGER_CALLBACK_H_

#include "eif_eiffel.h"
#include <windows.h>
#include "cli_debugger_headers.h"



#ifdef __cplusplus
extern "C" {
#endif

extern EIF_POINTER new_cordebug_managed_callback ();


#ifdef __cplusplus
}
#endif

#define COM_METHOD HRESULT STDMETHODCALLTYPE

#ifdef __cplusplus

#ifndef __ICorDebugMDA_INTERFACE_DEFINED__
#define __ICorDebugMDA_INTERFACE_DEFINED__
typedef 
enum CorDebugMDAFlags
    {	MDA_FLAG_SLIP	= 0x2
    } 	CorDebugMDAFlags;


EXTERN_C const IID IID_ICorDebugMDA;
class ICorDebugMDA : public IUnknown
    {
    public:
        virtual HRESULT STDMETHODCALLTYPE GetName( 
            /* [in] */ ULONG32 cchName,
            /* [out] */ ULONG32 *pcchName,
            /* [length_is][size_is][out] */ WCHAR szName[  ]) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE GetDescription( 
            /* [in] */ ULONG32 cchName,
            /* [out] */ ULONG32 *pcchName,
            /* [length_is][size_is][out] */ WCHAR szName[  ]) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE GetXML( 
            /* [in] */ ULONG32 cchName,
            /* [out] */ ULONG32 *pcchName,
            /* [length_is][size_is][out] */ WCHAR szName[  ]) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE GetFlags( 
            /* [in] */ CorDebugMDAFlags *pFlags) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE GetOSThreadId( 
            /* [out] */ DWORD *pOsTid) = 0;
        
    };
#endif

/* ------------------------------------------------------------------------- *
 * DebuggerUnmanagedCallback2
 * ------------------------------------------------------------------------- */

#ifndef __ICorDebugManagedCallback2_INTERFACE_DEFINED__
#define __ICorDebugManagedCallback2_INTERFACE_DEFINED__
typedef enum CorDebugExceptionCallbackType
{
	DEBUG_EXCEPTION_FIRST_CHANCE = 1,        /* Fired when exception thrown */
	DEBUG_EXCEPTION_USER_FIRST_CHANCE = 2,   /* Fired when search reaches first user code */
	DEBUG_EXCEPTION_CATCH_HANDLER_FOUND = 3, /* Fired if & when search finds a handler */
	DEBUG_EXCEPTION_UNHANDLED = 4            /* Fired if search doesnt find a handler */
} CorDebugExceptionCallbackType;


typedef enum CorDebugExceptionFlags
{
	DEBUG_EXCEPTION_CAN_BE_INTERCEPTED = 0x0001 /* Indicates interceptable exception */
} CorDebugExceptionFlags;


typedef enum CorDebugExceptionUnwindCallbackType
{
	DEBUG_EXCEPTION_UNWIND_BEGIN = 1, /* Fired at the beginning of the unwind */
	DEBUG_EXCEPTION_INTERCEPTED = 2   /* Fired after an exception has been intercepted */
} CorDebugExceptionUnwindCallbackType;


typedef DWORD CONNID;
EXTERN_C const IID IID_ICorDebugManagedCallback2;


    MIDL_INTERFACE("250E5EEA-DB5C-4C76-B6F3-8C46F12E3203")
	
    ICorDebugManagedCallback2 : public IUnknown
    {
    public:
        virtual HRESULT STDMETHODCALLTYPE FunctionRemapOpportunity( 
            /* [in] */ ICorDebugAppDomain *pAppDomain,
            /* [in] */ ICorDebugThread *pThread,
            /* [in] */ ICorDebugFunction *pOldFunction,
            /* [in] */ ICorDebugFunction *pNewFunction,
            /* [in] */ ULONG32 oldILOffset) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CreateConnection( 
            /* [in] */ ICorDebugProcess *pProcess,
            /* [in] */ CONNID dwConnectionId,
            /* [in] */ WCHAR *pConnName) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE ChangeConnection( 
            /* [in] */ ICorDebugProcess *pProcess,
            /* [in] */ CONNID dwConnectionId) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE DestroyConnection( 
            /* [in] */ ICorDebugProcess *pProcess,
            /* [in] */ CONNID dwConnectionId) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE Exception( 
            /* [in] */ ICorDebugAppDomain *pAppDomain,
            /* [in] */ ICorDebugThread *pThread,
            /* [in] */ ICorDebugFrame *pFrame,
            /* [in] */ ULONG32 nOffset,
            /* [in] */ CorDebugExceptionCallbackType dwEventType,
            /* [in] */ DWORD dwFlags) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE ExceptionUnwind( 
            /* [in] */ ICorDebugAppDomain *pAppDomain,
            /* [in] */ ICorDebugThread *pThread,
            /* [in] */ CorDebugExceptionUnwindCallbackType dwEventType,
            /* [in] */ DWORD dwFlags) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE FunctionRemapComplete( 
            /* [in] */ ICorDebugAppDomain *pAppDomain,
            /* [in] */ ICorDebugThread *pThread,
            /* [in] */ ICorDebugFunction *pFunction) = 0;
        virtual HRESULT STDMETHODCALLTYPE MDANotification( 
            /* [in] */ ICorDebugController *pController,
            /* [in] */ ICorDebugThread *pThread,
            /* [in] */ ICorDebugMDA *pMDA) = 0;
        
    };

#endif

/* ------------------------------------------------------------------------- *
 * DebuggerUnmanagedCallback
 * ------------------------------------------------------------------------- */

class DebuggerManagedCallback : public ICorDebugManagedCallback, public ICorDebugManagedCallback2
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
            *ppInterface = (IUnknown*)(ICorDebugManagedCallback*)this;
        else if (riid == IID_ICorDebugManagedCallback)
            *ppInterface = (ICorDebugManagedCallback *) this;
        else if (riid == IID_ICorDebugManagedCallback2)
            *ppInterface = (ICorDebugManagedCallback2 *) this;
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
    
	/* --------------------------------------------------------------- *
	 * ICorDebugManagedCallback2 routines
	 * --------------------------------------------------------------- */

    COM_METHOD FunctionRemapOpportunity(ICorDebugAppDomain *pAppDomain,
                                     ICorDebugThread *pThread,
                                     ICorDebugFunction *pOldFunction,
                                     ICorDebugFunction *pNewFunction,
                                     ULONG32 oldILOffset);

    /*
     * CreateConnection is called when a new connection is created.
     */
    COM_METHOD CreateConnection(ICorDebugProcess *pProcess,
                             CONNID dwConnectionId,
                             WCHAR *pConnName);

    /*
     * ChangeConnection is called when a connection's set of tasks changes.
     */
    COM_METHOD ChangeConnection(ICorDebugProcess *pProcess,
                             CONNID dwConnectionId );

    /*
     * DestroyConnection is called when a connection is ended.
     */
    COM_METHOD DestroyConnection(ICorDebugProcess *pProcess,
                              CONNID dwConnectionId );




    /*
     * Exception is called at various points during the search phase of the
     * exception-handling process.  The exception being processed can be
     * retrieved from the ICorDebugThread.
     */

    COM_METHOD Exception(ICorDebugAppDomain *pAppDomain,
                       ICorDebugThread *pThread,
                       ICorDebugFrame *pFrame,
                       ULONG32 nOffset,
                       CorDebugExceptionCallbackType dwEventType,
                       DWORD dwFlags );



    /*
     * ExceptionUnwind is called at various points during the unwind phase
     * of the exception-handling process.
     */
    COM_METHOD ExceptionUnwind(ICorDebugAppDomain *pAppDomain,
                             ICorDebugThread *pThread,
                             CorDebugExceptionUnwindCallbackType dwEventType,
                             DWORD dwFlags );
    /*
     * FunctionRemapComplete is fired whenever execution switches over to a new version of a function.
     * At this point steppers can be added to that new version of the function, and no sooner.
     *
     */
    COM_METHOD FunctionRemapComplete(ICorDebugAppDomain *pAppDomain,
                                     ICorDebugThread *pThread,
                                     ICorDebugFunction *pFunction);


	COM_METHOD MDANotification(/* [in] */ ICorDebugController *pController,
								/* [in] */ ICorDebugThread *pThread,
								/* [in] */ ICorDebugMDA *pMDA);

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
