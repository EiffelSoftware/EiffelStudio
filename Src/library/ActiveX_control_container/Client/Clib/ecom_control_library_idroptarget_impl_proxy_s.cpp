/*-----------------------------------------------------------
Implemented `IDropTarget' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IDropTarget_impl_proxy_s.h"
static const IID IID_IDropTarget_ = {0x00000122,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IDropTarget_impl_proxy::IDropTarget_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IDropTarget_, (void **)&p_IDropTarget);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IDropTarget_impl_proxy::~IDropTarget_impl_proxy()
{
	p_unknown->Release ();
	if (p_IDropTarget!=NULL)
		p_IDropTarget->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDropTarget_impl_proxy::ccom_drag_enter(  /* [in] */ ecom_control_library::IDataObject * p_data_obj,  /* [in] */ EIF_INTEGER grf_key_state,  /* [in] */ ecom_control_library::_POINTL * pt,  /* [in, out] */ EIF_OBJECT pdw_effect )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDropTarget == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDropTarget_, (void **)&p_IDropTarget);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_grf_key_state = 0;
	tmp_grf_key_state = (ULONG)grf_key_state;
	ULONG * tmp_pdw_effect = 0;
	tmp_pdw_effect = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_effect), NULL);
	
	hr = p_IDropTarget->DragEnter(p_data_obj,tmp_grf_key_state,*(ecom_control_library::_POINTL*)pt,tmp_pdw_effect);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_effect, pdw_effect);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_138 (tmp_pdw_effect);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDropTarget_impl_proxy::ccom_drag_over(  /* [in] */ EIF_INTEGER grf_key_state,  /* [in] */ ecom_control_library::_POINTL * pt,  /* [in, out] */ EIF_OBJECT pdw_effect )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDropTarget == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDropTarget_, (void **)&p_IDropTarget);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_grf_key_state = 0;
	tmp_grf_key_state = (ULONG)grf_key_state;
	ULONG * tmp_pdw_effect = 0;
	tmp_pdw_effect = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_effect), NULL);
	
	hr = p_IDropTarget->DragOver(tmp_grf_key_state,*(ecom_control_library::_POINTL*)pt,tmp_pdw_effect);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_effect, pdw_effect);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_139 (tmp_pdw_effect);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDropTarget_impl_proxy::ccom_drag_leave()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDropTarget == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDropTarget_, (void **)&p_IDropTarget);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IDropTarget->DragLeave ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDropTarget_impl_proxy::ccom_drop(  /* [in] */ ecom_control_library::IDataObject * p_data_obj,  /* [in] */ EIF_INTEGER grf_key_state,  /* [in] */ ecom_control_library::_POINTL * pt,  /* [in, out] */ EIF_OBJECT pdw_effect )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDropTarget == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDropTarget_, (void **)&p_IDropTarget);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_grf_key_state = 0;
	tmp_grf_key_state = (ULONG)grf_key_state;
	ULONG * tmp_pdw_effect = 0;
	tmp_pdw_effect = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_effect), NULL);
	
	hr = p_IDropTarget->Drop(p_data_obj,tmp_grf_key_state,*(ecom_control_library::_POINTL*)pt,tmp_pdw_effect);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_effect, pdw_effect);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_140 (tmp_pdw_effect);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IDropTarget_impl_proxy::ccom_item()

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