/*-----------------------------------------------------------
Implemented `IViewObject' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IViewObject_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IViewObject_ = {0x0000010d,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IViewObject_impl_stub::IViewObject_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IViewObject_impl_stub::~IViewObject_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IViewObject_impl_stub::RemoteDraw(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ LONG lindex, /* [in] */ ULONG pv_aspect, /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd, /* [in] */ ULONG hdc_target_dev, /* [in] */ ULONG hdc_draw, /* [in] */ ecom_control_library::_RECTL * lprc_bounds, /* [in] */ ecom_control_library::_RECTL * lprc_wbounds, /* [in] */ ecom_control_library::IContinue * p_continue )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_draw_aspect = (EIF_INTEGER)dw_draw_aspect;
	EIF_INTEGER tmp_lindex = (EIF_INTEGER)lindex;
	EIF_INTEGER tmp_pv_aspect = (EIF_INTEGER)pv_aspect;
	EIF_OBJECT tmp_ptd = NULL;
	if (ptd != NULL)
	{
		tmp_ptd = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_13 (ptd));
	}
	EIF_INTEGER tmp_hdc_target_dev = (EIF_INTEGER)hdc_target_dev;
	EIF_INTEGER tmp_hdc_draw = (EIF_INTEGER)hdc_draw;
	EIF_OBJECT tmp_lprc_bounds = NULL;
	if (lprc_bounds != NULL)
	{
		tmp_lprc_bounds = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_381 (lprc_bounds));
	}
	EIF_OBJECT tmp_lprc_wbounds = NULL;
	if (lprc_wbounds != NULL)
	{
		tmp_lprc_wbounds = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_381 (lprc_wbounds));
	}
	EIF_OBJECT tmp_p_continue = NULL;
	if (p_continue != NULL)
	{
		tmp_p_continue = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_383 (p_continue));
		p_continue->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_draw", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_draw_aspect, (EIF_INTEGER)tmp_lindex, (EIF_INTEGER)tmp_pv_aspect, ((tmp_ptd != NULL) ? eif_access (tmp_ptd) : NULL), (EIF_INTEGER)tmp_hdc_target_dev, (EIF_INTEGER)tmp_hdc_draw, ((tmp_lprc_bounds != NULL) ? eif_access (tmp_lprc_bounds) : NULL), ((tmp_lprc_wbounds != NULL) ? eif_access (tmp_lprc_wbounds) : NULL), ((tmp_p_continue != NULL) ? eif_access (tmp_p_continue) : NULL));
	if (tmp_ptd != NULL)
		eif_wean (tmp_ptd);
	if (tmp_lprc_bounds != NULL)
		eif_wean (tmp_lprc_bounds);
	if (tmp_lprc_wbounds != NULL)
		eif_wean (tmp_lprc_wbounds);
	if (tmp_p_continue != NULL)
		eif_wean (tmp_p_continue);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IViewObject_impl_stub::RemoteGetColorSet(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ LONG lindex, /* [in] */ ULONG pv_aspect, /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd, /* [in] */ ULONG hic_target_dev, /* [out] */ ecom_control_library::tagLOGPALETTE * * pp_color_set )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_draw_aspect = (EIF_INTEGER)dw_draw_aspect;
	EIF_INTEGER tmp_lindex = (EIF_INTEGER)lindex;
	EIF_INTEGER tmp_pv_aspect = (EIF_INTEGER)pv_aspect;
	EIF_OBJECT tmp_ptd = NULL;
	if (ptd != NULL)
	{
		tmp_ptd = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_13 (ptd));
	}
	EIF_INTEGER tmp_hic_target_dev = (EIF_INTEGER)hic_target_dev;
	EIF_OBJECT tmp_pp_color_set = NULL;
	if (pp_color_set != NULL)
	{
		tmp_pp_color_set = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_384 (pp_color_set, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_color_set", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_draw_aspect, (EIF_INTEGER)tmp_lindex, (EIF_INTEGER)tmp_pv_aspect, ((tmp_ptd != NULL) ? eif_access (tmp_ptd) : NULL), (EIF_INTEGER)tmp_hic_target_dev, ((tmp_pp_color_set != NULL) ? eif_access (tmp_pp_color_set) : NULL));
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_384 (((tmp_pp_color_set != NULL) ? eif_wean (tmp_pp_color_set) : NULL), pp_color_set);
	if (tmp_ptd != NULL)
		eif_wean (tmp_ptd);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IViewObject_impl_stub::RemoteFreeze(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ LONG lindex, /* [in] */ ULONG pv_aspect, /* [out] */ ULONG * pdw_freeze )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_draw_aspect = (EIF_INTEGER)dw_draw_aspect;
	EIF_INTEGER tmp_lindex = (EIF_INTEGER)lindex;
	EIF_INTEGER tmp_pv_aspect = (EIF_INTEGER)pv_aspect;
	EIF_OBJECT tmp_pdw_freeze = NULL;
	if (pdw_freeze != NULL)
	{
		tmp_pdw_freeze = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_freeze, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_freeze", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_draw_aspect, (EIF_INTEGER)tmp_lindex, (EIF_INTEGER)tmp_pv_aspect, ((tmp_pdw_freeze != NULL) ? eif_access (tmp_pdw_freeze) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_freeze != NULL) ? eif_wean (tmp_pdw_freeze) : NULL), pdw_freeze);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IViewObject_impl_stub::Unfreeze(  /* [in] */ ULONG dw_freeze )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_freeze = (EIF_INTEGER)dw_freeze;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("unfreeze", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_freeze);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IViewObject_impl_stub::SetAdvise(  /* [in] */ ULONG aspects, /* [in] */ ULONG advf, /* [in] */ ecom_control_library::IAdviseSink * p_adv_sink )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_aspects = (EIF_INTEGER)aspects;
	EIF_INTEGER tmp_advf = (EIF_INTEGER)advf;
	EIF_OBJECT tmp_p_adv_sink = NULL;
	if (p_adv_sink != NULL)
	{
		tmp_p_adv_sink = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_108 (p_adv_sink));
		p_adv_sink->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_advise", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_aspects, (EIF_INTEGER)tmp_advf, ((tmp_p_adv_sink != NULL) ? eif_access (tmp_p_adv_sink) : NULL));
	if (tmp_p_adv_sink != NULL)
		eif_wean (tmp_p_adv_sink);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IViewObject_impl_stub::RemoteGetAdvise(  /* [out] */ ULONG * p_aspects, /* [out] */ ULONG * p_advf, /* [out] */ ecom_control_library::IAdviseSink * * pp_adv_sink )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_aspects = NULL;
	if (p_aspects != NULL)
	{
		tmp_p_aspects = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (p_aspects, NULL));
	}
	EIF_OBJECT tmp_p_advf = NULL;
	if (p_advf != NULL)
	{
		tmp_p_advf = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (p_advf, NULL));
	}
	EIF_OBJECT tmp_pp_adv_sink = NULL;
	if (pp_adv_sink != NULL)
	{
		tmp_pp_adv_sink = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_388 (pp_adv_sink, NULL));
		if (*pp_adv_sink != NULL)
			(*pp_adv_sink)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_advise", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_aspects != NULL) ? eif_access (tmp_p_aspects) : NULL), ((tmp_p_advf != NULL) ? eif_access (tmp_p_advf) : NULL), ((tmp_pp_adv_sink != NULL) ? eif_access (tmp_pp_adv_sink) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_p_aspects != NULL) ? eif_wean (tmp_p_aspects) : NULL), p_aspects);
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_p_advf != NULL) ? eif_wean (tmp_p_advf) : NULL), p_advf);
	
	if (*pp_adv_sink != NULL)
		(*pp_adv_sink)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_388 (((tmp_pp_adv_sink != NULL) ? eif_wean (tmp_pp_adv_sink) : NULL), pp_adv_sink);
	if (*pp_adv_sink != NULL)
		(*pp_adv_sink)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IViewObject_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IViewObject_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IViewObject_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IViewObject*>(this);
	else if (riid == IID_IViewObject_)
		*ppv = static_cast<ecom_control_library::IViewObject*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif