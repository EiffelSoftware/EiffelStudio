/*-----------------------------------------------------------
Implemented `IOleControlSite' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleControlSite_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IOleControlSite_ = {0xb196b289,0xbab4,0x101a,{0xb6,0x9c,0x00,0xaa,0x00,0x34,0x1d,0x07}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleControlSite_impl_stub::IOleControlSite_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleControlSite_impl_stub::~IOleControlSite_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleControlSite_impl_stub::OnControlInfoChanged( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("on_control_info_changed", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleControlSite_impl_stub::LockInPlaceActive(  /* [in] */ LONG f_lock )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_f_lock = (EIF_INTEGER)f_lock;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("lock_in_place_active", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_lock);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleControlSite_impl_stub::GetExtendedControl(  /* [out] */ IDispatch * * pp_disp )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_disp = NULL;
	if (pp_disp != NULL)
	{
		tmp_pp_disp = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_204 (pp_disp, NULL));
		if (*pp_disp != NULL)
			(*pp_disp)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_extended_control", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_disp != NULL) ? eif_access (tmp_pp_disp) : NULL));
	
	if (*pp_disp != NULL)
		(*pp_disp)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_204 (((tmp_pp_disp != NULL) ? eif_wean (tmp_pp_disp) : NULL), pp_disp);
	if (*pp_disp != NULL)
		(*pp_disp)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleControlSite_impl_stub::TransformCoords(  /* [in, out] */ ecom_control_library::_POINTL * p_ptl_himetric, /* [in, out] */ ecom_control_library::tagPOINTF * p_ptf_container, /* [in] */ ULONG dw_flags )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_ptl_himetric = NULL;
	if (p_ptl_himetric != NULL)
	{
		tmp_p_ptl_himetric = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_205 (p_ptl_himetric));
	}
	EIF_OBJECT tmp_p_ptf_container = NULL;
	if (p_ptf_container != NULL)
	{
		tmp_p_ptf_container = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_207 (p_ptf_container));
	}
	EIF_INTEGER tmp_dw_flags = (EIF_INTEGER)dw_flags;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("transform_coords", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_ptl_himetric != NULL) ? eif_access (tmp_p_ptl_himetric) : NULL), ((tmp_p_ptf_container != NULL) ? eif_access (tmp_p_ptf_container) : NULL), (EIF_INTEGER)tmp_dw_flags);
	
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleControlSite_impl_stub::TranslateAccelerator(  /* [in] */ ecom_control_library::tagMSG * p_msg, /* [in] */ ULONG grf_modifiers )

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
	EIF_INTEGER tmp_grf_modifiers = (EIF_INTEGER)grf_modifiers;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("translate_accelerator", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_msg != NULL) ? eif_access (tmp_p_msg) : NULL), (EIF_INTEGER)tmp_grf_modifiers);
	if (tmp_p_msg != NULL)
		eif_wean (tmp_p_msg);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleControlSite_impl_stub::OnFocus(  /* [in] */ LONG f_got_focus )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_f_got_focus = (EIF_INTEGER)f_got_focus;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("on_focus", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_got_focus);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleControlSite_impl_stub::ShowPropertyFrame( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("show_property_frame", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IOleControlSite_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IOleControlSite_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleControlSite_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IOleControlSite*>(this);
	else if (riid == IID_IOleControlSite_)
		*ppv = static_cast<ecom_control_library::IOleControlSite*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif