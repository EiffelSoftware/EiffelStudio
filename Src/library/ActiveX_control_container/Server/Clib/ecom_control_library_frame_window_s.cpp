/*-----------------------------------------------------------
OLE Control Container Frame. Control interfaces. Help file: 
-----------------------------------------------------------*/

#include "ecom_control_library_frame_window_s.h"
static int return_hr_value;

static const CLSID CLSID_frame_window_ = {0x7d6698bc,0x5649,0x4757,{0xaa,0xff,0x29,0x6a,0xdb,0xcc,0xa9,0x06}};

static const IID IID_IOleInPlaceFrame_ = {0x00000116,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_IOleInPlaceUIWindow_ = {0x00000115,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_IOleWindow_ = {0x00000114,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID LIBID_control_library_ = {0xbde3247e,0x6bc6,0x47f4,{0xa4,0x6f,0xe5,0xae,0xa4,0xf8,0xdf,0x39}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::frame_window::frame_window( EIF_TYPE_ID tid )
{
	type_id = tid;
	ref_count = 0;
	eiffel_object = eif_create (type_id);
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("make_from_pointer", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)this);
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::frame_window::frame_window( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::frame_window::~frame_window()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::frame_window::GetWindow(  /* [out] */ ecom_control_library::wireHWND * phwnd )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_phwnd = NULL;
	if (phwnd != NULL)
	{
		tmp_phwnd = eif_protect (rt_ce.ccom_ce_pointed_pointer ((void **)phwnd, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_window", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_phwnd != NULL) ? eif_access (tmp_phwnd) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::frame_window::ContextSensitiveHelp(  /* [in] */ LONG f_enter_mode )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_f_enter_mode = (EIF_INTEGER)f_enter_mode;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("context_sensitive_help", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_enter_mode);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::frame_window::GetBorder(  /* [out] */ ecom_control_library::tagRECT * lprect_border )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_lprect_border = NULL;
	if (lprect_border != NULL)
	{
		tmp_lprect_border = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 (lprect_border));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_border", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_lprect_border != NULL) ? eif_access (tmp_lprect_border) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::frame_window::RequestBorderSpace(  /* [in] */ ecom_control_library::tagRECT * pborderwidths )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pborderwidths = NULL;
	if (pborderwidths != NULL)
	{
		tmp_pborderwidths = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 (pborderwidths));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("request_border_space", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pborderwidths != NULL) ? eif_access (tmp_pborderwidths) : NULL));
	if (tmp_pborderwidths != NULL)
		eif_wean (tmp_pborderwidths);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::frame_window::SetBorderSpace(  /* [in] */ ecom_control_library::tagRECT * pborderwidths )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pborderwidths = NULL;
	if (pborderwidths != NULL)
	{
		tmp_pborderwidths = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 (pborderwidths));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_border_space", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pborderwidths != NULL) ? eif_access (tmp_pborderwidths) : NULL));
	if (tmp_pborderwidths != NULL)
		eif_wean (tmp_pborderwidths);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::frame_window::SetActiveObject(  /* [in] */ ecom_control_library::IOleInPlaceActiveObject * p_active_object, /* [in] */ LPWSTR psz_obj_name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_active_object = NULL;
	if (p_active_object != NULL)
	{
		tmp_p_active_object = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_214 (p_active_object));
		p_active_object->AddRef ();
	}
	EIF_OBJECT tmp_psz_obj_name = NULL;
	if (psz_obj_name != NULL)
	{
		tmp_psz_obj_name = eif_protect (rt_ce.ccom_ce_lpwstr (psz_obj_name, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_active_object", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_active_object != NULL) ? eif_access (tmp_p_active_object) : NULL), ((tmp_psz_obj_name != NULL) ? eif_access (tmp_psz_obj_name) : NULL));
	if (tmp_p_active_object != NULL)
		eif_wean (tmp_p_active_object);
	if (tmp_psz_obj_name != NULL)
		eif_wean (tmp_psz_obj_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::frame_window::InsertMenus(  /* [in] */ ecom_control_library::wireHMENU hmenu_shared, /* [in, out] */ ecom_control_library::tagOleMenuGroupWidths * lp_menu_widths )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_POINTER tmp_hmenu_shared = (EIF_POINTER)hmenu_shared;
	EIF_OBJECT tmp_lp_menu_widths = NULL;
	if (lp_menu_widths != NULL)
	{
		tmp_lp_menu_widths = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_217 (lp_menu_widths));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("insert_menus", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)tmp_hmenu_shared, ((tmp_lp_menu_widths != NULL) ? eif_access (tmp_lp_menu_widths) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::frame_window::SetMenu(  /* [in] */ ecom_control_library::wireHMENU hmenu_shared, /* [in] */ ecom_control_library::wireHGLOBAL holemenu, /* [in] */ ecom_control_library::wireHWND hwnd_active_object )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_POINTER tmp_hmenu_shared = (EIF_POINTER)hmenu_shared;
	EIF_OBJECT tmp_holemenu = NULL;
	if (holemenu != NULL)
	{
		tmp_holemenu = eif_protect (grt_ce_control_interfaces2.ccom_ce_alias_wire_hglobal_alias218 (holemenu));
	}
	EIF_POINTER tmp_hwnd_active_object = (EIF_POINTER)hwnd_active_object;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_menu", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER, EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)tmp_hmenu_shared, ((tmp_holemenu != NULL) ? eif_access (tmp_holemenu) : NULL), (EIF_POINTER)tmp_hwnd_active_object);
	if (tmp_holemenu != NULL)
		eif_wean (tmp_holemenu);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::frame_window::RemoveMenus(  /* [in] */ ecom_control_library::wireHMENU hmenu_shared )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_POINTER tmp_hmenu_shared = (EIF_POINTER)hmenu_shared;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remove_menus", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)tmp_hmenu_shared);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::frame_window::SetStatusText(  /* [in] */ LPWSTR psz_status_text )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_psz_status_text = NULL;
	if (psz_status_text != NULL)
	{
		tmp_psz_status_text = eif_protect (rt_ce.ccom_ce_lpwstr (psz_status_text, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_status_text", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_psz_status_text != NULL) ? eif_access (tmp_psz_status_text) : NULL));
	if (tmp_psz_status_text != NULL)
		eif_wean (tmp_psz_status_text);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::frame_window::EnableModeless(  /* [in] */ LONG f_enable )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_f_enable = (EIF_INTEGER)f_enable;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enable_modeless", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_enable);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::frame_window::TranslateAccelerator(  /* [in] */ ecom_control_library::tagMSG * lpmsg, /* [in] */ USHORT w_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_lpmsg = NULL;
	if (lpmsg != NULL)
	{
		tmp_lpmsg = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_198 (lpmsg));
	}
	EIF_INTEGER tmp_w_id = (EIF_INTEGER)w_id;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("translate_accelerator", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_lpmsg != NULL) ? eif_access (tmp_lpmsg) : NULL), (EIF_INTEGER)tmp_w_id);
	if (tmp_lpmsg != NULL)
		eif_wean (tmp_lpmsg);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::frame_window::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::frame_window::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::frame_window::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface.
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IOleInPlaceFrame*>(this);
	else if (riid == IID_IProvideClassInfo)
		*ppv = static_cast<IProvideClassInfo2*>(this);
	else if (riid == IID_IProvideClassInfo2)
		*ppv = static_cast<IProvideClassInfo2*>(this);
	else if (riid == IID_IOleInPlaceFrame_)
		*ppv = static_cast<ecom_control_library::IOleInPlaceFrame*>(this);
	else if (riid == IID_IOleInPlaceUIWindow_)
		*ppv = static_cast<ecom_control_library::IOleInPlaceUIWindow*>(this);
	else if (riid == IID_IOleWindow_)
		*ppv = static_cast<ecom_control_library::IOleWindow*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::frame_window::GetClassInfo( ITypeInfo ** ppti )

/*-----------------------------------------------------------
	GetClassInfo
-----------------------------------------------------------*/
{
	if (ppti == NULL)
		return E_POINTER;
	ITypeLib * ptl = NULL;
	HRESULT hr = LoadRegTypeLib (LIBID_control_library_, 1, 0, 0, &ptl);
	if (SUCCEEDED (hr))
	{
		hr = ptl->GetTypeInfoOfGuid (CLSID_frame_window_, ppti);
		ptl->Release ();
	}
	return hr;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::frame_window::GetGUID( DWORD dwKind, GUID * pguid )

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