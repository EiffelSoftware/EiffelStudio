/*-----------------------------------------------------------
FolderBrowser factory
-----------------------------------------------------------*/

#include "FolderBrowser_factory.h"
#ifdef __cplusplus
extern "C" {
#endif

FolderBrowser_factory::FolderBrowser_factory()
{
	IsInitialized = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) FolderBrowser_factory::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return 2;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) FolderBrowser_factory::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	UnlockModule ();
	return 1;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP FolderBrowser_factory::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IClassFactory)
		*ppv = static_cast<IClassFactory*>(this);
	else if (riid == IID_IUnknown)
		*ppv = static_cast<IClassFactory*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;
	reinterpret_cast<IUnknown *>(this)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP FolderBrowser_factory::CreateInstance( IUnknown *pIunknown, REFIID riid, void **ppv )

/*-----------------------------------------------------------
	Create Instance
-----------------------------------------------------------*/
{
	if (ppv == 0)
		return E_POINTER;
	*ppv = 0;
	if (pIunknown)
		return CLASS_E_NOAGGREGATION;
	ecom_FolderBrowser::FolderBrowser *pUnknown = new ecom_FolderBrowser::FolderBrowser (type_id);
	if (!pUnknown)
		return E_OUTOFMEMORY;
	pUnknown->AddRef ();
	HRESULT tmp_hr = pUnknown->QueryInterface (riid, ppv);
	pUnknown->Release ();
	return tmp_hr;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP FolderBrowser_factory::LockServer( BOOL tmp_value )

/*-----------------------------------------------------------
	Lock Server
-----------------------------------------------------------*/
{
	if (tmp_value)
		LockModule ();
	else
		UnlockModule ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void FolderBrowser_factory::Initialize()

/*-----------------------------------------------------------
	Initialize
-----------------------------------------------------------*/
{
	type_id = eif_type_id ("FOLDER_BROWSER_COCLASS_IMP");
	IsInitialized = (type_id >= 0);
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif