#include "common.h"

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
	if (eiffel_dispatcher) {
		return (EIF_NATURAL_32) ((eiffel_on_view_changed_function) (
#ifndef EIF_IL_DLL
			(EIF_REFERENCE) eif_access (eiffel_dispatcher),
#endif
			(EIF_POINTER) This,
			(EIF_NATURAL_32) viewId,
			(EIF_INTEGER) typeID,
			(EIF_POINTER) view,
			(EIF_INTEGER) verb,
			(EIF_INTEGER) uReasonCode));
	} else {
		return E_NOTIMPL; 
	}  
}

HRESULT STDMETHODCALLTYPE OnCreateUICommand(IUIApplication *This, UINT32 commandId, UI_COMMANDTYPE typeID, IUICommandHandler **commandHandler)
{ 
	if (eiffel_dispatcher) {
		return (EIF_NATURAL_32) ((eiffel_on_create_ui_command_function) (
#ifndef EIF_IL_DLL
			(EIF_REFERENCE) eif_access (eiffel_dispatcher),
#endif
			(EIF_POINTER) This,
			(EIF_NATURAL_32) commandId,
			(EIF_INTEGER) typeID,
			(EIF_POINTER) commandHandler));
	} else {
		return 0;
	}  
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

EIF_POINTER InitializeFramework(HWND hWnd, EIF_POINTER a_ribbon_resource_handle)
{
	HRESULT hr;
	IUIApplication	*pApplication = NULL;

	hr = CoCreateInstance(&CLSID_UIRibbonFramework, NULL, CLSCTX_INPROC_SERVER, &IID_IUIFRAMEWORK, (VOID **)&g_pFramework);
	if (SUCCEEDED(hr)) {
		VOID *ppvObj = NULL;
		HINSTANCE l_resouce_handle = (HINSTANCE)a_ribbon_resource_handle;
		
		/* allocate pApplication */
		pApplication = (IUIApplication *)GlobalAlloc(GMEM_FIXED, sizeof(IUIApplication));
		if (pApplication) {
				/* Point our pApplication to myRibbon_Vtbl that contains standard IUnknown method
				 * (QueryInterface, AddRef, Release) and callback for our IUIApplication interface
				 * (OnViewChanged, OnCreateUICommand, OnDestroyUICommand).
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
				if (l_resouce_handle == (HINSTANCE)NULL)
				{
					hr = g_pFramework->lpVtbl->LoadUI(g_pFramework, GetModuleHandle(NULL), L"APPLICATION_RIBBON");
				}else
				{
					hr = g_pFramework->lpVtbl->LoadUI(g_pFramework, l_resouce_handle, L"APPLICATION_RIBBON");
				}
					
				if (SUCCEEDED(hr)) {
					return (EIF_POINTER) g_pFramework;
				}
			}
		}
	}
	return NULL;
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
