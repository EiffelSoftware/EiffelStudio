/*-----------------------------------------------------------
Implemented `IOleInPlaceObjectWindowless' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleInPlaceObjectWindowless_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IOleInPlaceObjectWindowless_ = {0x1c2056cc,0x5ef4,0x101b,{0x8b,0xc8,0x00,0xaa,0x00,0x3e,0x3b,0x29}};

static const IID IID_IOleInPlaceObject_ = {0x00000113,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_IOleWindow_ = {0x00000114,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleInPlaceObjectWindowless_impl_stub::IOleInPlaceObjectWindowless_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleInPlaceObjectWindowless_impl_stub::~IOleInPlaceObjectWindowless_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceObjectWindowless_impl_stub::GetWindow(  /* [out] */ ecom_control_library::wireHWND * phwnd )

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

STDMETHODIMP ecom_control_library::IOleInPlaceObjectWindowless_impl_stub::ContextSensitiveHelp(  /* [in] */ LONG f_enter_mode )

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

STDMETHODIMP ecom_control_library::IOleInPlaceObjectWindowless_impl_stub::InPlaceDeactivate( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("in_place_deactivate", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceObjectWindowless_impl_stub::UIDeactivate( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("uideactivate", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceObjectWindowless_impl_stub::SetObjectRects(  /* [in] */ ecom_control_library::tagRECT * lprc_pos_rect, /* [in] */ ecom_control_library::tagRECT * lprc_clip_rect )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_lprc_pos_rect = NULL;
	if (lprc_pos_rect != NULL)
	{
		tmp_lprc_pos_rect = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 (lprc_pos_rect));
	}
	EIF_OBJECT tmp_lprc_clip_rect = NULL;
	if (lprc_clip_rect != NULL)
	{
		tmp_lprc_clip_rect = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 (lprc_clip_rect));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_object_rects", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_lprc_pos_rect != NULL) ? eif_access (tmp_lprc_pos_rect) : NULL), ((tmp_lprc_clip_rect != NULL) ? eif_access (tmp_lprc_clip_rect) : NULL));
	if (tmp_lprc_pos_rect != NULL)
		eif_wean (tmp_lprc_pos_rect);
	if (tmp_lprc_clip_rect != NULL)
		eif_wean (tmp_lprc_clip_rect);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceObjectWindowless_impl_stub::ReactivateAndUndo( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("reactivate_and_undo", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceObjectWindowless_impl_stub::OnWindowMessage(  /* [in] */ UINT msg, /* [in] */ UINT w_param, /* [in] */ LONG l_param, /* [out] */ LONG * pl_result )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_msg = (EIF_INTEGER)msg;
	EIF_INTEGER tmp_w_param = (EIF_INTEGER)w_param;
	EIF_INTEGER tmp_l_param = (EIF_INTEGER)l_param;
	EIF_OBJECT tmp_pl_result = NULL;
	if (pl_result != NULL)
	{
		tmp_pl_result = eif_protect (rt_ce.ccom_ce_pointed_long (pl_result, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("on_window_message", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_msg, (EIF_INTEGER)tmp_w_param, (EIF_INTEGER)tmp_l_param, ((tmp_pl_result != NULL) ? eif_access (tmp_pl_result) : NULL));
	rt_ec.ccom_ec_pointed_long (((tmp_pl_result != NULL) ? eif_wean (tmp_pl_result) : NULL), pl_result);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceObjectWindowless_impl_stub::GetDropTarget(  /* [out] */ ecom_control_library::IDropTarget * * pp_drop_target )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_drop_target = NULL;
	if (pp_drop_target != NULL)
	{
		tmp_pp_drop_target = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_223 (pp_drop_target, NULL));
		if (*pp_drop_target != NULL)
			(*pp_drop_target)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_drop_target", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_drop_target != NULL) ? eif_access (tmp_pp_drop_target) : NULL));
	
	if (*pp_drop_target != NULL)
		(*pp_drop_target)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_223 (((tmp_pp_drop_target != NULL) ? eif_wean (tmp_pp_drop_target) : NULL), pp_drop_target);
	if (*pp_drop_target != NULL)
		(*pp_drop_target)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IOleInPlaceObjectWindowless_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IOleInPlaceObjectWindowless_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceObjectWindowless_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IOleInPlaceObjectWindowless*>(this);
	else if (riid == IID_IOleInPlaceObjectWindowless_)
		*ppv = static_cast<ecom_control_library::IOleInPlaceObjectWindowless*>(this);
	else if (riid == IID_IOleInPlaceObject_)
		*ppv = static_cast<ecom_control_library::IOleInPlaceObject*>(this);
	else if (riid == IID_IOleWindow_)
		*ppv = static_cast<ecom_control_library::IOleWindow*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif