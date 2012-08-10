#include "common.h"
#include "eiffel_ribbon.h"

HRESULT STDMETHODCALLTYPE QueryInterface2(IUICommandHandler *This, REFIID vtblID, void **ppv);
ULONG STDMETHODCALLTYPE AddRef2(IUICommandHandler *This);
ULONG STDMETHODCALLTYPE Release2(IUICommandHandler *This);
HRESULT STDMETHODCALLTYPE Execute(IUICommandHandler *This, UINT nCmdID, UI_EXECUTIONVERB verb, const PROPERTYKEY* key, const PROPVARIANT* ppropvarValue, IUISimplePropertySet* pCommandExecutionProperties);
HRESULT STDMETHODCALLTYPE UpdateProperty(IUICommandHandler *This, UINT nCmdID, REFPROPERTYKEY key, const PROPVARIANT* ppropvarCurrentValue,PROPVARIANT* ppropvarNewValue);

/*	
	IUICommandHandlerVtbl is defined in Uiribbon.h and 
	CINTERFACE symbol stops IntelliSense from 
	complaining about undefined IUICommandHandlerVtbl identifier 
*/
IUICommandHandlerVtbl myCommand_Vtbl = {QueryInterface2,
													AddRef2,
													Release2,
													Execute,
													UpdateProperty
													};
																	
long OutstandingCommandHandlers = 0;
/* IUICommandHandler *g_commandHandler = NULL;	*/ /* Reference to the command handler */

EIF_POINTER c_create_ui_command_handler (EIF_POINTER a_commandHandler)
{
	HRESULT	hr;
	IUICommandHandler *pCommandHandler = NULL;		
	IUICommandHandler ** l_command_handler = (IUICommandHandler **)a_commandHandler;
	/* allocate pApplication */
	pCommandHandler = (IUICommandHandler *)GlobalAlloc(GMEM_FIXED, sizeof(IUICommandHandler));
	if(!pCommandHandler) {
		/* FIXME: raise an exception here? */
	}

	/* Point our pCommandHandler to myCommand_Vtbl that contains standard IUnknown method (QueryInterface,
	 * AddRef, Release) and callback for our IUICommandHandler interface (Execute, UpdateProperty). */
	(IUICommandHandlerVtbl *)pCommandHandler->lpVtbl = &myCommand_Vtbl;

	hr = pCommandHandler->lpVtbl->QueryInterface(pCommandHandler, &IID_IUICommandHandler, l_command_handler);	

	return pCommandHandler;
}

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

/* 	Eiffel function for Ribbon UICommandHandler update property
		Eiffel function call need first parameter as EIF_REFERENCE. */

	if (eiffel_dispatcher) {
		return (EIF_NATURAL_32) ((eiffel_update_property_function) (
#ifndef EIF_IL_DLL
			(EIF_REFERENCE) eif_access (eiffel_dispatcher),
#endif
			(EIF_POINTER) This,
			(EIF_NATURAL_32) nCmdID,
			(EIF_POINTER) key,
			(EIF_POINTER) ppropvarCurrentValue,
			(EIF_POINTER) ppropvarNewValue));
	} else {
		return S_OK;
	}
}

HRESULT STDMETHODCALLTYPE Execute(IUICommandHandler *This, UINT nCmdID, UI_EXECUTIONVERB verb, const PROPERTYKEY* key, const PROPVARIANT* ppropvarValue, IUISimplePropertySet* pCommandExecutionProperties)
{

	/* 	Eiffel function for Ribbon UICommandHandler execute
		Eiffel function call need first parameter as EIF_REFERENCE. */	
	if (eiffel_dispatcher) {
		return (EIF_NATURAL_32) ((eiffel_execute_function) (
#ifndef EIF_IL_DLL
			(EIF_REFERENCE) eif_access (eiffel_dispatcher),
#endif
			(EIF_POINTER) This,
			(EIF_NATURAL_32) nCmdID,
			(EIF_INTEGER) verb,
			(EIF_POINTER) key,
			(EIF_POINTER) ppropvarValue,
			(EIF_POINTER) pCommandExecutionProperties));
	} else {
		return S_OK;
	} 
}
