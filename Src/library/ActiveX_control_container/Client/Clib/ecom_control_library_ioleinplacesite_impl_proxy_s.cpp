/*-----------------------------------------------------------
Implemented `IOleInPlaceSite' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleInPlaceSite_impl_proxy_s.h"
static const IID IID_IOleInPlaceSite_ = {0x00000119,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleInPlaceSite_impl_proxy::IOleInPlaceSite_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IOleInPlaceSite_, (void **)&p_IOleInPlaceSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleInPlaceSite_impl_proxy::~IOleInPlaceSite_impl_proxy()
{
	p_unknown->Release ();
	if (p_IOleInPlaceSite!=NULL)
		p_IOleInPlaceSite->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSite_impl_proxy::ccom_get_window(  /* [out] */ EIF_OBJECT phwnd )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSite == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSite_, (void **)&p_IOleInPlaceSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::wireHWND * tmp_phwnd = 0;
	tmp_phwnd = (ecom_control_library::wireHWND *)rt_ec.ccom_ec_pointed_pointer (eif_access (phwnd), NULL);
	
	hr = p_IOleInPlaceSite->GetWindow(tmp_phwnd);
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

void ecom_control_library::IOleInPlaceSite_impl_proxy::ccom_context_sensitive_help(  /* [in] */ EIF_INTEGER f_enter_mode )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSite == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSite_, (void **)&p_IOleInPlaceSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_f_enter_mode = 0;
	tmp_f_enter_mode = (LONG)f_enter_mode;
	
	hr = p_IOleInPlaceSite->ContextSensitiveHelp(tmp_f_enter_mode);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSite_impl_proxy::ccom_can_in_place_activate()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSite == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSite_, (void **)&p_IOleInPlaceSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceSite->CanInPlaceActivate ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSite_impl_proxy::ccom_on_in_place_activate()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSite == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSite_, (void **)&p_IOleInPlaceSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceSite->OnInPlaceActivate ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSite_impl_proxy::ccom_on_uiactivate()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSite == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSite_, (void **)&p_IOleInPlaceSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceSite->OnUIActivate ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSite_impl_proxy::ccom_get_window_context(  /* [out] */ EIF_OBJECT pp_frame,  /* [out] */ EIF_OBJECT pp_doc,  /* [out] */ ecom_control_library::tagRECT * lprc_pos_rect,  /* [out] */ ecom_control_library::tagRECT * lprc_clip_rect,  /* [in, out] */ ecom_control_library::tagOIFI * lp_frame_info )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSite == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSite_, (void **)&p_IOleInPlaceSite);
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
	
	hr = p_IOleInPlaceSite->GetWindowContext(tmp_pp_frame,tmp_pp_doc,lprc_pos_rect,lprc_clip_rect,lp_frame_info);
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

void ecom_control_library::IOleInPlaceSite_impl_proxy::ccom_scroll(  /* [in] */ ecom_control_library::tagSIZE * scroll_extant )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSite == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSite_, (void **)&p_IOleInPlaceSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IOleInPlaceSite->Scroll(*(ecom_control_library::tagSIZE*)scroll_extant);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSite_impl_proxy::ccom_on_uideactivate(  /* [in] */ EIF_INTEGER f_undoable )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSite == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSite_, (void **)&p_IOleInPlaceSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_f_undoable = 0;
	tmp_f_undoable = (LONG)f_undoable;
	
	hr = p_IOleInPlaceSite->OnUIDeactivate(tmp_f_undoable);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSite_impl_proxy::ccom_on_in_place_deactivate()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSite == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSite_, (void **)&p_IOleInPlaceSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceSite->OnInPlaceDeactivate ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSite_impl_proxy::ccom_discard_undo_state()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSite == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSite_, (void **)&p_IOleInPlaceSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceSite->DiscardUndoState ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSite_impl_proxy::ccom_deactivate_and_undo()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSite == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSite_, (void **)&p_IOleInPlaceSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceSite->DeactivateAndUndo ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceSite_impl_proxy::ccom_on_pos_rect_change(  /* [in] */ ecom_control_library::tagRECT * lprc_pos_rect )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceSite == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceSite_, (void **)&p_IOleInPlaceSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IOleInPlaceSite->OnPosRectChange(lprc_pos_rect);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IOleInPlaceSite_impl_proxy::ccom_item()

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