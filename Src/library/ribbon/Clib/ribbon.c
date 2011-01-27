#include "ribbon.h"

HRESULT STDMETHODCALLTYPE QueryInterface(IUIApplication *This, REFIID vtblID, void **ppv);
ULONG STDMETHODCALLTYPE AddRef(IUIApplication *This);
ULONG STDMETHODCALLTYPE Release(IUIApplication *This);
HRESULT STDMETHODCALLTYPE OnViewChanged(IUIApplication *This, UINT32 viewId, UI_VIEWTYPE typeID, IUnknown *view, UI_VIEWVERB verb, INT32 uReasonCode);
HRESULT STDMETHODCALLTYPE OnCreateUICommand(IUIApplication *This, UINT32 commandId, UI_COMMANDTYPE typeID, IUICommandHandler **commandHandler);
HRESULT STDMETHODCALLTYPE OnDestroyUICommand (IUIApplication *This, UINT32 commandId,  UI_COMMANDTYPE typeID, IUICommandHandler *commandHandler) ;

/*	
	IUIApplicationVtbl is defined in Uiribbon.h and 
	CINTERFACE symbol stops IntelliSense from 
	complaining about undefined IUIApplicationVtbl identifier 
*/
IUIApplicationVtbl myRibbon_Vtbl = {QueryInterface,
	AddRef,
	Release,
	OnViewChanged,
	OnCreateUICommand,
	OnDestroyUICommand};

LONG OutstandingObjects = 0;
IUIFramework *g_pFramework = NULL;  // Reference to the Ribbon framework.
IUIFramework *last_pFramework = NULL;  // Reference to the Ribbon framework when calling "OnCreateUICommand"
IUICommandHandler	*pCommandHandler = NULL;

HRESULT STDMETHODCALLTYPE QueryInterface(IUIApplication *This, REFIID vtblID, void **ppv)
{
	/* No match */
	if(!IsEqualIID(vtblID, &IID_IUIAPPLICATION) && !IsEqualIID(vtblID, &IID_IUnknown)) {
		*ppv = 0;
		return(E_NOINTERFACE);
	}

	/* Point our IUIApplication interface to our ribbon obj */
	*ppv = This;

	/* Ref count */
	This->lpVtbl->AddRef(This);

	return(NOERROR);
}

ULONG STDMETHODCALLTYPE AddRef(IUIApplication *This)
{
	return(InterlockedIncrement(&OutstandingObjects));
}

ULONG STDMETHODCALLTYPE Release(IUIApplication *This)
{
	return InterlockedDecrement(&OutstandingObjects);
}

HRESULT STDMETHODCALLTYPE OnViewChanged(IUIApplication *This, UINT32 viewId, UI_VIEWTYPE typeID, IUnknown *view, UI_VIEWVERB verb, INT32 uReasonCode)
{ 
	return E_NOTIMPL; 
}

HRESULT STDMETHODCALLTYPE OnCreateUICommand(IUIApplication *This, UINT32 commandId, UI_COMMANDTYPE typeID, IUICommandHandler **commandHandler)
{ 

	HRESULT	hr;

	// only create a new command handler if `g_pFramwork' changed since last time
	if (g_pFramework != last_pFramework) 
	{
		last_pFramework = g_pFramework;
		
		/* allocate pApplication */
		pCommandHandler = (IUICommandHandler *)GlobalAlloc(GMEM_FIXED, sizeof(IUICommandHandler));
		if(!pCommandHandler) {
			return(FALSE);
		}

		/*	
		Point our pApplication to myCommand_Vtbl that contains standard IUnknown method (QueryInterface, AddRef, Release)
		and callback for our IUICommandHandler interface (Execute, UpdateProperty).
		*/
		(IUICommandHandlerVtbl *)pCommandHandler->lpVtbl = &myCommand_Vtbl;				

	}

	hr = pCommandHandler->lpVtbl->QueryInterface(pCommandHandler, &IID_IUICommandHandler, commandHandler);		
	
	return hr; 
}

HRESULT STDMETHODCALLTYPE OnDestroyUICommand (IUIApplication *This, UINT32 commandId,  UI_COMMANDTYPE typeID, IUICommandHandler *commandHandler) 
{ 
	return E_NOTIMPL; 
}

BOOL InitializeFramework(HWND hWnd)
{
	HRESULT hr;

	hr = CoCreateInstance(&CLSID_UIRibbonFramework, NULL, CLSCTX_INPROC_SERVER, &IID_IUIFRAMEWORK, (VOID **)&g_pFramework);
	if (FAILED(hr)) {
		return(FALSE);
	}
	else
	{
		IUIApplication	*pApplication = NULL;
		VOID *ppvObj = NULL;

		/* allocate pApplication */
		pApplication = (IUIApplication *)GlobalAlloc(GMEM_FIXED, sizeof(IUIApplication));
		if(!pApplication) {
			return(FALSE);
		}

		/*	
		Point our pApplication to myRibbon_Vtbl that contains standard IUnknown method (QueryInterface, AddRef, Release)
		and callback for our IUIApplication interface (OnViewChanged, OnCreateUICommand, OnDestroyUICommand).
		*/
		(IUIApplicationVtbl *)pApplication->lpVtbl = &myRibbon_Vtbl;
		hr = pApplication->lpVtbl->QueryInterface(pApplication, &IID_IUIAPPLICATION, &ppvObj);

		/* Connects the host application to ribbon framework */
		hr = g_pFramework->lpVtbl->Initialize(g_pFramework, hWnd, (IUIApplication *)ppvObj);
		if (FAILED(hr)) {
			return(FALSE);
		}
		pApplication->lpVtbl->Release(pApplication);

		/* 
		LoadUI does the following: 
		1. Load our compiled binary markup 
		2. Initiate callbacks to the IUIApplication
		3. Bind command handler(s)
		*/
		hr = g_pFramework->lpVtbl->LoadUI(g_pFramework, GetModuleHandle(NULL), L"APPLICATION_RIBBON");
		if (FAILED(hr)) {
			return(FALSE);
		}

	}
	return(TRUE);

}

void DestroyRibbon()
{
	HRESULT hr;
	if (g_pFramework)
	{
		/* release and destroy */
		hr = ((IUIFramework *)g_pFramework)->lpVtbl->Destroy(g_pFramework);
		g_pFramework = NULL;
	}

}

//
//  FUNCTION: GetRibbonHeight()
//
//  PURPOSE:  Get the ribbon height.
//
//
HRESULT GetRibbonHeight(UINT* ribbonHeight, IUIFramework *a_framework)
{
	HRESULT hr = S_OK;

	if (a_framework)
	{
		IUIRibbon* pRibbon = NULL;

		if (SUCCEEDED(a_framework->lpVtbl->GetView(a_framework, 0, &IID_IUIRIBBON, &(pRibbon))))
		{
			hr = pRibbon->lpVtbl->GetHeight(pRibbon, ribbonHeight);
			pRibbon->lpVtbl->Release(pRibbon);
		}
	}

	return hr;
}

HRESULT SetModes(INT32 iModes, IUIFramework *a_framework)
{
	HRESULT hr = S_OK;

	if (a_framework)
	{
		hr = a_framework->lpVtbl->SetModes(g_pFramework, UI_MAKEAPPMODE(iModes));
	}

	return hr;
}

HRESULT GetUICommandProperty(UINT32 commandId, REFPROPERTYKEY key, PROPVARIANT *value, IUIFramework *a_framework)
{
	HRESULT hr = S_OK;

	if (a_framework)
	{
		hr = a_framework->lpVtbl->GetUICommandProperty(a_framework, commandId, key, value);
	}

	return hr;
}

HRESULT SetUICommandProperty (UINT32 commandId, REFPROPERTYKEY key, PROPVARIANT *value, IUIFramework *a_framework)
{
	HRESULT hr = S_OK;

	if (a_framework)
	{
		hr = a_framework->lpVtbl->SetUICommandProperty(a_framework, commandId, key, value);
	}

	return hr;
}

HRESULT InvalidateUICommand(UINT32 commandId, UI_INVALIDATIONS flags, const PROPERTYKEY *key, IUIFramework *a_framework)
{
	HRESULT hr = S_OK;

	if (a_framework)
	{
		hr = a_framework->lpVtbl->InvalidateUICommand(a_framework, commandId, flags, key);
	}

	return hr;	
}

IUIFramework *GetRibbonFramwork()
{
		return g_pFramework;
}

IUICommandHandler *GetCommandHandler()
{
		return pCommandHandler;
}
