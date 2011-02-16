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
IUIImageFromBitmap *g_image_from_bitmap = NULL;
IUICollection *g_ui_collection = NULL;

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

BOOL CreateIUIImageFromBitmap (HBITMAP bitmap, IUIImage **image)
{
	HRESULT hr;
	if (!g_image_from_bitmap)
		{
			hr = CoCreateInstance(&CLSID_UIRibbonImageFromBitmapFactory, NULL, CLSCTX_ALL, &IID_IUIImageFromBitmap, (VOID **)&g_image_from_bitmap);
			if (FAILED(hr)) {
				return(FALSE);
			}					
		}
	if (g_image_from_bitmap) {
		hr = g_image_from_bitmap->lpVtbl->CreateImage(g_image_from_bitmap, bitmap, UI_OWNERSHIP_COPY , image);
	}

	return TRUE;
}

EIF_POINTER InitializeFramework(HWND hWnd)
{
	HRESULT hr;

	hr = CoCreateInstance(&CLSID_UIRibbonFramework, NULL, CLSCTX_INPROC_SERVER, &IID_IUIFRAMEWORK, (VOID **)&g_pFramework);
	if (SUCCEEDED(hr)) {
		IUIApplication	*pApplication = NULL;
		VOID *ppvObj = NULL;

		/* allocate pApplication */
		pApplication = (IUIApplication *)GlobalAlloc(GMEM_FIXED, sizeof(IUIApplication));
		if (pApplication) {
				/* Point our pApplication to myRibbon_Vtbl that contains standard IUnknown method (QueryInterface, AddRef, Release)
				 * and callback for our IUIApplication interface (OnViewChanged, OnCreateUICommand, OnDestroyUICommand).
				 */
			(IUIApplicationVtbl *)pApplication->lpVtbl = &myRibbon_Vtbl;
			hr = pApplication->lpVtbl->QueryInterface(pApplication, &IID_IUIAPPLICATION, &ppvObj);

			/* Connects the host application to ribbon framework */
			hr = g_pFramework->lpVtbl->Initialize(g_pFramework, hWnd, (IUIApplication *)ppvObj);
			if (SUCCEEDED(hr)) {
				pApplication->lpVtbl->Release(pApplication);
					/* LoadUI does the following: 
					 * 1. Load our compiled binary markup 
					 * 2. Initiate callbacks to the IUIApplication
					 * 3. Bind command handler(s)
					 */
				hr = g_pFramework->lpVtbl->LoadUI(g_pFramework, GetModuleHandle(NULL), L"APPLICATION_RIBBON");
				if (SUCCEEDED(hr)) {
					return (EIF_POINTER) g_pFramework;
				}
			}
		}
	}
	return NULL;
}

IUICommandHandler *GetCommandHandler()
{
	return pCommandHandler;
}

HRESULT QueryInterfaceIUICollectionWithPropVariant (PROPVARIANT * a_prop_variant)
{
	HRESULT hr;
		
	hr = a_prop_variant->punkVal->lpVtbl->QueryInterface(a_prop_variant->punkVal, &IID_IUICollection, &g_ui_collection);

	return hr;	
}

IUICollection * GetUICollection ()
{
	return g_ui_collection;
}

HRESULT IUICollection_Add (IUICollection *a_ui_collection, IUnknown *item)
{
	HRESULT hr = S_OK;

	if (a_ui_collection)
	{
		hr = a_ui_collection->lpVtbl->Add(a_ui_collection, item);
	}

	return hr;		
}

HRESULT SHStrDupW_eiffel(LPCWSTR src, LPWSTR * dest)
{
	HRESULT hr;
	int len = 0;

	if (src) {
		len = (lstrlenW(src) + 1) * sizeof(WCHAR);
		*dest = CoTaskMemAlloc(len);
	} else {
		*dest = NULL;
	}

	if (*dest) {
		memcpy(*dest, src, len);
		hr = S_OK;
	} else {
		hr = E_OUTOFMEMORY;
	}

	return hr;
}
