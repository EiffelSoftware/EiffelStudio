/*-----------------------------------------------------------
Implemented `IPointerInactive' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IPointerInactive_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IPointerInactive_ = {0x55980ba0,0x35aa,0x11cf,{0xb6,0x71,0x00,0xaa,0x00,0x4c,0xd6,0xd8}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IPointerInactive_impl_stub::IPointerInactive_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPointerInactive_impl_stub::~IPointerInactive_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPointerInactive_impl_stub::GetActivationPolicy(  /* [out] */ ULONG * pdw_policy )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pdw_policy = NULL;
	if (pdw_policy != NULL)
	{
		tmp_pdw_policy = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_policy, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_activation_policy", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pdw_policy != NULL) ? eif_access (tmp_pdw_policy) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_policy != NULL) ? eif_wean (tmp_pdw_policy) : NULL), pdw_policy);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPointerInactive_impl_stub::OnInactiveMouseMove(  /* [in] */ ecom_control_library::tagRECT * p_rect_bounds, /* [in] */ LONG x, /* [in] */ LONG y, /* [in] */ ULONG grf_key_state )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_rect_bounds = NULL;
	if (p_rect_bounds != NULL)
	{
		tmp_p_rect_bounds = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 (p_rect_bounds));
	}
	EIF_INTEGER tmp_x = (EIF_INTEGER)x;
	EIF_INTEGER tmp_y = (EIF_INTEGER)y;
	EIF_INTEGER tmp_grf_key_state = (EIF_INTEGER)grf_key_state;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("on_inactive_mouse_move", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_rect_bounds != NULL) ? eif_access (tmp_p_rect_bounds) : NULL), (EIF_INTEGER)tmp_x, (EIF_INTEGER)tmp_y, (EIF_INTEGER)tmp_grf_key_state);
	if (tmp_p_rect_bounds != NULL)
		eif_wean (tmp_p_rect_bounds);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPointerInactive_impl_stub::OnInactiveSetCursor(  /* [in] */ ecom_control_library::tagRECT * p_rect_bounds, /* [in] */ LONG x, /* [in] */ LONG y, /* [in] */ ULONG dw_mouse_msg, /* [in] */ LONG f_set_always )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_rect_bounds = NULL;
	if (p_rect_bounds != NULL)
	{
		tmp_p_rect_bounds = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 (p_rect_bounds));
	}
	EIF_INTEGER tmp_x = (EIF_INTEGER)x;
	EIF_INTEGER tmp_y = (EIF_INTEGER)y;
	EIF_INTEGER tmp_dw_mouse_msg = (EIF_INTEGER)dw_mouse_msg;
	EIF_INTEGER tmp_f_set_always = (EIF_INTEGER)f_set_always;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("on_inactive_set_cursor", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_rect_bounds != NULL) ? eif_access (tmp_p_rect_bounds) : NULL), (EIF_INTEGER)tmp_x, (EIF_INTEGER)tmp_y, (EIF_INTEGER)tmp_dw_mouse_msg, (EIF_INTEGER)tmp_f_set_always);
	if (tmp_p_rect_bounds != NULL)
		eif_wean (tmp_p_rect_bounds);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IPointerInactive_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IPointerInactive_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPointerInactive_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IPointerInactive*>(this);
	else if (riid == IID_IPointerInactive_)
		*ppv = static_cast<ecom_control_library::IPointerInactive*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif