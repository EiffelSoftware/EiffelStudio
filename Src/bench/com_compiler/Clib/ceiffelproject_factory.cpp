/*-----------------------------------------------------------
CEiffelProject factory
-----------------------------------------------------------*/

#include "CEiffelProject_factory.h"
#ifdef __cplusplus
extern "C" {
#endif

CEiffelProject_factory::CEiffelProject_factory()
{
	IsInitialized = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) CEiffelProject_factory::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return 2;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) CEiffelProject_factory::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	return 1;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP CEiffelProject_factory::QueryInterface( REFIID riid, void ** ppv )

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

STDMETHODIMP CEiffelProject_factory::CreateInstance( IUnknown *pIunknown, REFIID riid, void **ppv )

/*-----------------------------------------------------------
	Create Instance
-----------------------------------------------------------*/
{
	if (ppv == 0)
		return E_POINTER;
	*ppv = 0;
	if (pIunknown)
		return CLASS_E_NOAGGREGATION;
	ecom_eiffel_compiler::CEiffelProject *pUnknown = new ecom_eiffel_compiler::CEiffelProject (type_id);
	if (!pUnknown)
		return E_OUTOFMEMORY;
	pUnknown->AddRef ();
	HRESULT tmp_hr = pUnknown->QueryInterface (riid, ppv);
	pUnknown->Release ();
	return tmp_hr;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP CEiffelProject_factory::LockServer( BOOL tmp_value )

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

void CEiffelProject_factory::Initialize()

/*-----------------------------------------------------------
	Initialize
-----------------------------------------------------------*/
{
	type_id = eif_type_id ("CEIFFEL_PROJECT_COCLASS_IMP");
	IsInitialized = (type_id >= 0);
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif