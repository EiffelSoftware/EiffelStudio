/*-----------------------------------------------------------
Implemented `IOleInPlaceSite' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleInPlaceSite_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IOleInPlaceSite_ = {0x00000119,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_IOleWindow_ = {0x00000114,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleInPlaceSite_impl_stub::IOleInPlaceSite_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleInPlaceSite_impl_stub::~IOleInPlaceSite_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceSite_impl_stub::GetWindow(  /* [out] */ ecom_control_library::wireHWND * phwnd )

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

STDMETHODIMP ecom_control_library::IOleInPlaceSite_impl_stub::ContextSensitiveHelp(  /* [in] */ LONG f_enter_mode )

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

STDMETHODIMP ecom_control_library::IOleInPlaceSite_impl_stub::CanInPlaceActivate( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("can_in_place_activate", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceSite_impl_stub::OnInPlaceActivate( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("on_in_place_activate", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceSite_impl_stub::OnUIActivate( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("on_uiactivate", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceSite_impl_stub::GetWindowContext(  /* [out] */ ecom_control_library::IOleInPlaceFrame * * pp_frame, /* [out] */ ecom_control_library::IOleInPlaceUIWindow * * pp_doc, /* [out] */ ecom_control_library::tagRECT * lprc_pos_rect, /* [out] */ ecom_control_library::tagRECT * lprc_clip_rect, /* [in, out] */ ecom_control_library::tagOIFI * lp_frame_info )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_frame = NULL;
	if (pp_frame != NULL)
	{
		tmp_pp_frame = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_226 (pp_frame, NULL));
		if (*pp_frame != NULL)
			(*pp_frame)->AddRef ();
	}
	EIF_OBJECT tmp_pp_doc = NULL;
	if (pp_doc != NULL)
	{
		tmp_pp_doc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_227 (pp_doc, NULL));
		if (*pp_doc != NULL)
			(*pp_doc)->AddRef ();
	}
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
	EIF_OBJECT tmp_lp_frame_info = NULL;
	if (lp_frame_info != NULL)
	{
		tmp_lp_frame_info = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_229 (lp_frame_info));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_window_context", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_frame != NULL) ? eif_access (tmp_pp_frame) : NULL), ((tmp_pp_doc != NULL) ? eif_access (tmp_pp_doc) : NULL), ((tmp_lprc_pos_rect != NULL) ? eif_access (tmp_lprc_pos_rect) : NULL), ((tmp_lprc_clip_rect != NULL) ? eif_access (tmp_lprc_clip_rect) : NULL), ((tmp_lp_frame_info != NULL) ? eif_access (tmp_lp_frame_info) : NULL));
	
	if (*pp_frame != NULL)
		(*pp_frame)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_226 (((tmp_pp_frame != NULL) ? eif_wean (tmp_pp_frame) : NULL), pp_frame);
	if (*pp_frame != NULL)
		(*pp_frame)->AddRef ();
	
	if (*pp_doc != NULL)
		(*pp_doc)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_227 (((tmp_pp_doc != NULL) ? eif_wean (tmp_pp_doc) : NULL), pp_doc);
	if (*pp_doc != NULL)
		(*pp_doc)->AddRef ();
	
	
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceSite_impl_stub::Scroll(  /* [in] */ ecom_control_library::tagSIZE scroll_extant )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_scroll_extant = NULL;
	tmp_scroll_extant = eif_protect (grt_ce_control_interfaces2.ccom_ce_record_tag_size_record230 (scroll_extant));
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("scroll", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_scroll_extant != NULL) ? eif_access (tmp_scroll_extant) : NULL));
	if (tmp_scroll_extant != NULL)
		eif_wean (tmp_scroll_extant);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceSite_impl_stub::OnUIDeactivate(  /* [in] */ LONG f_undoable )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_f_undoable = (EIF_INTEGER)f_undoable;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("on_uideactivate", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_undoable);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceSite_impl_stub::OnInPlaceDeactivate( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("on_in_place_deactivate", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceSite_impl_stub::DiscardUndoState( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("discard_undo_state", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceSite_impl_stub::DeactivateAndUndo( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("deactivate_and_undo", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceSite_impl_stub::OnPosRectChange(  /* [in] */ ecom_control_library::tagRECT * lprc_pos_rect )

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
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("on_pos_rect_change", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_lprc_pos_rect != NULL) ? eif_access (tmp_lprc_pos_rect) : NULL));
	if (tmp_lprc_pos_rect != NULL)
		eif_wean (tmp_lprc_pos_rect);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IOleInPlaceSite_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IOleInPlaceSite_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleInPlaceSite_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IOleInPlaceSite*>(this);
	else if (riid == IID_IOleInPlaceSite_)
		*ppv = static_cast<ecom_control_library::IOleInPlaceSite*>(this);
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