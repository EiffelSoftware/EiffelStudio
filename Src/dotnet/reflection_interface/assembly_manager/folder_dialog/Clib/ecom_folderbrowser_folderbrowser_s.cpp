/*-----------------------------------------------------------
browse folder library. Help file: 
-----------------------------------------------------------*/

#include "ecom_FolderBrowser_FolderBrowser_s.h"
static int return_hr_value;

static const CLSID CLSID_FolderBrowser_ = {0x524055ae,0x3734,0x40bb,{0xad,0xf3,0x70,0xb3,0x68,0x99,0x30,0x2a}};

static const IID IID_IFolderBrowser_ = {0x7e8227b1,0x110e,0x4d6b,{0x99,0xa6,0xdc,0xd5,0x10,0x10,0x91,0xa4}};

static const IID LIBID_FolderBrowser_ = {0xba223fc7,0xf4bf,0x4ec8,{0x85,0xf1,0xa6,0xf1,0x13,0xbd,0xaa,0xfa}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_FolderBrowser::FolderBrowser::FolderBrowser( EIF_TYPE_ID tid )
{
	type_id = tid;
	ref_count = 0;
	eiffel_object = eif_create (type_id);
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("make_from_pointer", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)this);
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_FolderBrowser::FolderBrowser::FolderBrowser( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_FolderBrowser::FolderBrowser::~FolderBrowser()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_FolderBrowser::FolderBrowser::FolderName(  /* [out] */ LPWSTR * result1 )

/*-----------------------------------------------------------
	Folder chosen by the user.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_result1 = NULL;
	if (result1 != NULL)
	{
		tmp_result1 = eif_protect (grt_ce_folder_browser.ccom_ce_pointed_cell_1 (result1, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("folder_name", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_result1 != NULL) ? eif_access (tmp_result1) : NULL));
	grt_ec_folder_browser.ccom_ec_pointed_cell_1 (((tmp_result1 != NULL) ? eif_wean (tmp_result1) : NULL), result1);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_FolderBrowser::FolderBrowser::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	LONG res = InterlockedDecrement (&ref_count);
	if (res  ==  0)
	{
		delete this;
	}
	return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_FolderBrowser::FolderBrowser::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_FolderBrowser::FolderBrowser::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface.
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_FolderBrowser::IFolderBrowser*>(this);
	else if (riid == IID_IProvideClassInfo)
		*ppv = static_cast<IProvideClassInfo2*>(this);
	else if (riid == IID_IProvideClassInfo2)
		*ppv = static_cast<IProvideClassInfo2*>(this);
	else if (riid == IID_IFolderBrowser_)
		*ppv = static_cast<ecom_FolderBrowser::IFolderBrowser*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_FolderBrowser::FolderBrowser::GetClassInfo( ITypeInfo ** ppti )

/*-----------------------------------------------------------
	GetClassInfo
-----------------------------------------------------------*/
{
	if (ppti == NULL)
		return E_POINTER;
	ITypeLib * ptl = NULL;
	HRESULT hr = LoadRegTypeLib (LIBID_FolderBrowser_, 1, 0, 0, &ptl);
	if (SUCCEEDED (hr))
	{
		hr = ptl->GetTypeInfoOfGuid (CLSID_FolderBrowser_, ppti);
		ptl->Release ();
	}
	return hr;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_FolderBrowser::FolderBrowser::GetGUID( DWORD dwKind, GUID * pguid )

/*-----------------------------------------------------------
	GetGUID
-----------------------------------------------------------*/
{
	if ((dwKind != GUIDKIND_DEFAULT_SOURCE_DISP_IID) ||(!pguid))
		return E_INVALIDARG;
	*pguid = IID_NULL;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif