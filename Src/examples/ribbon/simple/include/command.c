#include "common.h"

HRESULT STDMETHODCALLTYPE QueryInterface2(IUICommandHandler *This, REFIID vtblID, void **ppv);
ULONG STDMETHODCALLTYPE AddRef2(IUICommandHandler *This);
ULONG STDMETHODCALLTYPE Release2(IUICommandHandler *This);
HRESULT STDMETHODCALLTYPE Execute(IUICommandHandler *This, UINT nCmdID, UI_EXECUTIONVERB verb, const PROPERTYKEY* key, const PROPVARIANT* ppropvarValue, IUISimplePropertySet* pCommandExecutionProperties);
HRESULT STDMETHODCALLTYPE UpdateProperty(IUICommandHandler *This, UINT nCmdID, REFPROPERTYKEY key, const PROPVARIANT* ppropvarCurrentValue,PROPVARIANT* ppropvarNewValue);

/*	
	IUIApplicationVtbl is defined in Uiribbon.h and 
	CINTERFACE symbol stops IntelliSense from 
	complaining about undefined IUIApplicationVtbl identifier 
*/
IUICommandHandlerVtbl myCommand_Vtbl = {QueryInterface2,
	AddRef2,
	Release2,
	Execute,
	UpdateProperty
	};
	
long OutstandingCommandHandlers = 0;
//IUICommandHandler *g_commandHandler = NULL;  // Reference to the command handler

HRESULT STDMETHODCALLTYPE QueryInterface2(IUICommandHandler *This, REFIID vtblID, void **ppv)
{
	/* No match */
	if(!IsEqualIID(vtblID, &IID_IUICommandHandler) && !IsEqualIID(vtblID, &IID_IUnknown)) {
		*ppv = 0;
		return(E_NOINTERFACE);
	}

	/* Point our IUICommandHandler interface to our command handler obj */
	*ppv = This;

	/* Ref count */
	This->lpVtbl->AddRef(This);

	return(NOERROR);
}

ULONG STDMETHODCALLTYPE AddRef2(IUICommandHandler *This)
{
	return(InterlockedIncrement(&OutstandingCommandHandlers));
}

ULONG STDMETHODCALLTYPE Release2(IUICommandHandler *This)
{
	return InterlockedDecrement(&OutstandingCommandHandlers);
}

HRESULT STDMETHODCALLTYPE UpdateProperty(IUICommandHandler *This, UINT nCmdID, REFPROPERTYKEY key, const PROPVARIANT* ppropvarCurrentValue,PROPVARIANT* ppropvarNewValue)
{
	printf ("\n IUICommandHandler UpdateProperty in C. Command ID is %d. ", nCmdID);

	return S_OK;
}

HRESULT STDMETHODCALLTYPE Execute(IUICommandHandler *This, UINT nCmdID, UI_EXECUTIONVERB verb, const PROPERTYKEY* key, const PROPVARIANT* ppropvarValue, IUISimplePropertySet* pCommandExecutionProperties)
{
	
	printf ("\n IUICommandHandler Execute in C. Command ID is %d. UI_EXECUTIONVERB is %d.", nCmdID, verb);
	
	return S_OK;
}