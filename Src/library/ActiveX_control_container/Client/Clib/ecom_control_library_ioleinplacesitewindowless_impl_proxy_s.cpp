/*-----------------------------------------------------------
Implemented `IOleInPlaceSiteWindowless' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleInPlaceSiteWindowless_impl_proxy_s.h"
static const IID IID_IOleInPlaceSiteWindowless_ = {0x922eada0,0x3424,0x11cf,{0xb6,0x70,0x00,0xaa,0x00,0x4c,0xd6,0xd8}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::IOleInPlaceSiteWindowless_impl_proxy( IUnknown * a_pointer )
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

	hr = a_pointer->QueryInterface(IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::~IOleInPlaceSiteWindowless_impl_proxy()
{
	p_unknown->Release ();
	if (p_IOleInPlaceSiteWindowless!=NULL)
		p_IOleInPlaceSiteWindowless->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_get_window(  /* [out] */ EIF_OBJECT phwnd )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::wireHWND * tmp_phwnd = 0;
	tmp_phwnd = (ecom_control_library::wireHWND *)rt_ec.ccom_ec_pointed_pointer (eif_access (phwnd), NULL);
	
	hr = p_IOleInPlaceSiteWindowless->GetWindow(tmp_phwnd);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_pointer ((void **)tmp_phwnd, phwnd);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_208 (tmp_phwnd);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_context_sensitive_help(  /* [in] */ EIF_INTEGER f_enter_mode )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_f_enter_mode = 0;
	tmp_f_enter_mode = (LONG)f_enter_mode;
	
	hr = p_IOleInPlaceSiteWindowless->ContextSensitiveHelp(tmp_f_enter_mode);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_can_in_place_activate()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceSiteWindowless->CanInPlaceActivate ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_on_in_place_activate()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceSiteWindowless->OnInPlaceActivate ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_on_uiactivate()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceSiteWindowless->OnUIActivate ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_get_window_context(  /* [out] */ EIF_OBJECT pp_frame,  /* [out] */ EIF_OBJECT pp_doc,  /* [out] */ ecom_control_library::tagRECT * lprc_pos_rect,  /* [out] */ ecom_control_library::tagRECT * lprc_clip_rect,  /* [in, out] */ ecom_control_library::tagOIFI * lp_frame_info )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::IOleInPlaceFrame * * tmp_pp_frame = 0;
	tmp_pp_frame = (ecom_control_library::IOleInPlaceFrame * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_226 (eif_access (pp_frame), NULL);
	ecom_control_library::IOleInPlaceUIWindow * * tmp_pp_doc = 0;
	tmp_pp_doc = (ecom_control_library::IOleInPlaceUIWindow * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_227 (eif_access (pp_doc), NULL);
	
	hr = p_IOleInPlaceSiteWindowless->GetWindowContext(tmp_pp_frame,tmp_pp_doc,lprc_pos_rect,lprc_clip_rect,lp_frame_info);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_226 ((ecom_control_library::IOleInPlaceFrame * *)tmp_pp_frame, pp_frame);
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_227 ((ecom_control_library::IOleInPlaceUIWindow * *)tmp_pp_doc, pp_doc);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_226 (tmp_pp_frame);
grt_ce_control_interfaces2.ccom_free_memory_pointed_227 (tmp_pp_doc);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_scroll(  /* [in] */ ecom_control_library::tagSIZE * scroll_extant )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IOleInPlaceSiteWindowless->Scroll(*(ecom_control_library::tagSIZE*)scroll_extant);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_on_uideactivate(  /* [in] */ EIF_INTEGER f_undoable )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_f_undoable = 0;
	tmp_f_undoable = (LONG)f_undoable;
	
	hr = p_IOleInPlaceSiteWindowless->OnUIDeactivate(tmp_f_undoable);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_on_in_place_deactivate()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceSiteWindowless->OnInPlaceDeactivate ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_discard_undo_state()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceSiteWindowless->DiscardUndoState ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_deactivate_and_undo()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceSiteWindowless->DeactivateAndUndo ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_on_pos_rect_change(  /* [in] */ ecom_control_library::tagRECT * lprc_pos_rect )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IOleInPlaceSiteWindowless->OnPosRectChange(lprc_pos_rect);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_on_in_place_activate_ex(  /* [out] */ EIF_OBJECT pf_no_redraw,  /* [in] */ EIF_INTEGER dw_flags )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG * tmp_pf_no_redraw = 0;
	tmp_pf_no_redraw = (LONG *)rt_ec.ccom_ec_pointed_long (eif_access (pf_no_redraw), NULL);
	ULONG tmp_dw_flags = 0;
	tmp_dw_flags = (ULONG)dw_flags;
	
	hr = p_IOleInPlaceSiteWindowless->OnInPlaceActivateEx(tmp_pf_no_redraw,tmp_dw_flags);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_long ((LONG *)tmp_pf_no_redraw, pf_no_redraw);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_231 (tmp_pf_no_redraw);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_on_in_place_deactivate_ex(  /* [in] */ EIF_INTEGER f_no_redraw )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_f_no_redraw = 0;
	tmp_f_no_redraw = (LONG)f_no_redraw;
	
	hr = p_IOleInPlaceSiteWindowless->OnInPlaceDeactivateEx(tmp_f_no_redraw);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_request_uiactivate()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceSiteWindowless->RequestUIActivate ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_can_windowless_activate()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceSiteWindowless->CanWindowlessActivate ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_get_capture()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceSiteWindowless->GetCapture ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_set_capture(  /* [in] */ EIF_INTEGER f_capture )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_f_capture = 0;
	tmp_f_capture = (LONG)f_capture;
	
	hr = p_IOleInPlaceSiteWindowless->SetCapture(tmp_f_capture);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_get_focus()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceSiteWindowless->GetFocus ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_set_focus(  /* [in] */ EIF_INTEGER f_focus )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_f_focus = 0;
	tmp_f_focus = (LONG)f_focus;
	
	hr = p_IOleInPlaceSiteWindowless->SetFocus(tmp_f_focus);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_get_dc(  /* [in] */ ecom_control_library::tagRECT * p_rect,  /* [in] */ EIF_INTEGER grf_flags,  /* [out] */ EIF_OBJECT ph_dc )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_grf_flags = 0;
	tmp_grf_flags = (ULONG)grf_flags;
	ecom_control_library::wireHDC * tmp_ph_dc = 0;
	tmp_ph_dc = (ecom_control_library::wireHDC *)rt_ec.ccom_ec_pointed_pointer (eif_access (ph_dc), NULL);
	
	hr = p_IOleInPlaceSiteWindowless->GetDC(p_rect,tmp_grf_flags,tmp_ph_dc);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_pointer ((void **)tmp_ph_dc, ph_dc);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_233 (tmp_ph_dc);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_release_dc(  /* [in] */ EIF_POINTER h_dc )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::wireHDC tmp_h_dc = 0;
	tmp_h_dc = (ecom_control_library::wireHDC)h_dc;
	
	hr = p_IOleInPlaceSiteWindowless->ReleaseDC(tmp_h_dc);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	grt_ce_control_interfaces2.free_memory_232 (tmp_h_dc);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_invalidate_rect(  /* [in] */ ecom_control_library::tagRECT * p_rect,  /* [in] */ EIF_INTEGER f_erase )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_f_erase = 0;
	tmp_f_erase = (LONG)f_erase;
	
	hr = p_IOleInPlaceSiteWindowless->InvalidateRect(p_rect,tmp_f_erase);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_invalidate_rgn(  /* [in] */ EIF_POINTER h_rgn,  /* [in] */ EIF_INTEGER f_erase )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	void * tmp_h_rgn = 0;
	tmp_h_rgn = (void *)h_rgn;
	LONG tmp_f_erase = 0;
	tmp_f_erase = (LONG)f_erase;
	
	hr = p_IOleInPlaceSiteWindowless->InvalidateRgn(tmp_h_rgn,tmp_f_erase);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_234 (tmp_h_rgn);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_scroll_rect(  /* [in] */ EIF_INTEGER dx,  /* [in] */ EIF_INTEGER dy,  /* [in] */ ecom_control_library::tagRECT * p_rect_scroll,  /* [in] */ ecom_control_library::tagRECT * p_rect_clip )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	INT tmp_dx = 0;
	tmp_dx = (INT)dx;
	INT tmp_dy = 0;
	tmp_dy = (INT)dy;
	
	hr = p_IOleInPlaceSiteWindowless->ScrollRect(tmp_dx,tmp_dy,p_rect_scroll,p_rect_clip);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_adjust_rect(  /* [in, out] */ ecom_control_library::tagRECT * prc )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IOleInPlaceSiteWindowless->AdjustRect(prc);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_on_def_window_message(  /* [in] */ EIF_INTEGER msg,  /* [in] */ EIF_INTEGER w_param,  /* [in] */ EIF_INTEGER l_param,  /* [out] */ EIF_OBJECT pl_result )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSiteWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSiteWindowless_, (void **)&p_IOleInPlaceSiteWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	UINT tmp_msg = 0;
	tmp_msg = (UINT)msg;
	UINT tmp_w_param = 0;
	tmp_w_param = (UINT)w_param;
	LONG tmp_l_param = 0;
	tmp_l_param = (LONG)l_param;
	LONG * tmp_pl_result = 0;
	tmp_pl_result = (LONG *)rt_ec.ccom_ec_pointed_long (eif_access (pl_result), NULL);
	
	hr = p_IOleInPlaceSiteWindowless->OnDefWindowMessage(tmp_msg,tmp_w_param,tmp_l_param,tmp_pl_result);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_long ((LONG *)tmp_pl_result, pl_result);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_235 (tmp_pl_result);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IOleInPlaceSiteWindowless_impl_proxy::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif