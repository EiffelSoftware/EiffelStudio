/*-----------------------------------------------------------
Implemented `IPropertyPage2' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IPropertyPage2_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IPropertyPage2_ = {0x01e44665,0x24ac,0x101b,{0x84,0xed,0x08,0x00,0x2b,0x2e,0xc7,0x13}};

static const IID IID_IPropertyPage_ = {0xb196b28d,0xbab4,0x101a,{0xb6,0x9c,0x00,0xaa,0x00,0x34,0x1d,0x07}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IPropertyPage2_impl_stub::IPropertyPage2_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPropertyPage2_impl_stub::~IPropertyPage2_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPage2_impl_stub::SetPageSite(  /* [in] */ ecom_control_library::IPropertyPageSite * p_page_site )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_page_site = NULL;
	if (p_page_site != NULL)
	{
		tmp_p_page_site = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_294 (p_page_site));
		p_page_site->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_page_site", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_page_site != NULL) ? eif_access (tmp_p_page_site) : NULL));
	if (tmp_p_page_site != NULL)
		eif_wean (tmp_p_page_site);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPage2_impl_stub::Activate(  /* [in] */ ecom_control_library::wireHWND hwnd_parent, /* [in] */ ecom_control_library::tagRECT * p_rect, /* [in] */ LONG b_modal )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_POINTER tmp_hwnd_parent = (EIF_POINTER)hwnd_parent;
	EIF_OBJECT tmp_p_rect = NULL;
	if (p_rect != NULL)
	{
		tmp_p_rect = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 (p_rect));
	}
	EIF_INTEGER tmp_b_modal = (EIF_INTEGER)b_modal;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("activate", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)tmp_hwnd_parent, ((tmp_p_rect != NULL) ? eif_access (tmp_p_rect) : NULL), (EIF_INTEGER)tmp_b_modal);
	if (tmp_p_rect != NULL)
		eif_wean (tmp_p_rect);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPage2_impl_stub::Deactivate( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("deactivate", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPage2_impl_stub::GetPageInfo(  /* [out] */ ecom_control_library::tagPROPPAGEINFO * p_page_info )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_page_info = NULL;
	if (p_page_info != NULL)
	{
		tmp_p_page_info = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_296 (p_page_info));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_page_info", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_page_info != NULL) ? eif_access (tmp_p_page_info) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPage2_impl_stub::SetObjects(  /* [in] */ ULONG c_objects, /* [in] */ IUnknown * * ppunk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_c_objects = (EIF_INTEGER)c_objects;
	EIF_OBJECT tmp_ppunk = NULL;
	if (ppunk != NULL)
	{
		tmp_ppunk = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_297 (ppunk, NULL));
		if (*ppunk != NULL)
			(*ppunk)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_objects", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_c_objects, ((tmp_ppunk != NULL) ? eif_access (tmp_ppunk) : NULL));
	if (tmp_ppunk != NULL)
		eif_wean (tmp_ppunk);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPage2_impl_stub::Show(  /* [in] */ UINT n_cmd_show )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_n_cmd_show = (EIF_INTEGER)n_cmd_show;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("show", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_n_cmd_show);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPage2_impl_stub::Move(  /* [in] */ ecom_control_library::tagRECT * p_rect )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_rect = NULL;
	if (p_rect != NULL)
	{
		tmp_p_rect = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 (p_rect));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("move", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_rect != NULL) ? eif_access (tmp_p_rect) : NULL));
	if (tmp_p_rect != NULL)
		eif_wean (tmp_p_rect);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPage2_impl_stub::IsPageDirty( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("is_page_dirty", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPage2_impl_stub::Apply( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("apply", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPage2_impl_stub::Help(  /* [in] */ LPWSTR psz_help_dir )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_psz_help_dir = NULL;
	if (psz_help_dir != NULL)
	{
		tmp_psz_help_dir = eif_protect (rt_ce.ccom_ce_lpwstr (psz_help_dir, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("help", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_psz_help_dir != NULL) ? eif_access (tmp_psz_help_dir) : NULL));
	if (tmp_psz_help_dir != NULL)
		eif_wean (tmp_psz_help_dir);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPage2_impl_stub::TranslateAccelerator(  /* [in] */ ecom_control_library::tagMSG * p_msg )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_msg = NULL;
	if (p_msg != NULL)
	{
		tmp_p_msg = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_198 (p_msg));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("translate_accelerator", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_msg != NULL) ? eif_access (tmp_p_msg) : NULL));
	if (tmp_p_msg != NULL)
		eif_wean (tmp_p_msg);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPage2_impl_stub::EditProperty(  /* [in] */ LONG disp_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_disp_id = (EIF_INTEGER)disp_id;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("edit_property", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_disp_id);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IPropertyPage2_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IPropertyPage2_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPage2_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IPropertyPage2*>(this);
	else if (riid == IID_IPropertyPage2_)
		*ppv = static_cast<ecom_control_library::IPropertyPage2*>(this);
	else if (riid == IID_IPropertyPage_)
		*ppv = static_cast<ecom_control_library::IPropertyPage*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif