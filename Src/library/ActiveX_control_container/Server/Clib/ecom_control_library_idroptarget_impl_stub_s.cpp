/*-----------------------------------------------------------
Implemented `IDropTarget' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IDropTarget_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IDropTarget_ = {0x00000122,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IDropTarget_impl_stub::IDropTarget_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IDropTarget_impl_stub::~IDropTarget_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDropTarget_impl_stub::DragEnter(  /* [in] */ ecom_control_library::IDataObject * p_data_obj, /* [in] */ ULONG grf_key_state, /* [in] */ ecom_control_library::_POINTL pt, /* [in, out] */ ULONG * pdw_effect )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_data_obj = NULL;
	if (p_data_obj != NULL)
	{
		tmp_p_data_obj = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_106 (p_data_obj));
		p_data_obj->AddRef ();
	}
	EIF_INTEGER tmp_grf_key_state = (EIF_INTEGER)grf_key_state;
	EIF_OBJECT tmp_pt = NULL;
	tmp_pt = eif_protect (grt_ce_control_interfaces2.ccom_ce_record_x_pointl_record137 (pt));
	EIF_OBJECT tmp_pdw_effect = NULL;
	if (pdw_effect != NULL)
	{
		tmp_pdw_effect = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_effect, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("drag_enter", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_data_obj != NULL) ? eif_access (tmp_p_data_obj) : NULL), (EIF_INTEGER)tmp_grf_key_state, ((tmp_pt != NULL) ? eif_access (tmp_pt) : NULL), ((tmp_pdw_effect != NULL) ? eif_access (tmp_pdw_effect) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_effect != NULL) ? eif_wean (tmp_pdw_effect) : NULL), pdw_effect);
	if (tmp_p_data_obj != NULL)
		eif_wean (tmp_p_data_obj);
	if (tmp_pt != NULL)
		eif_wean (tmp_pt);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDropTarget_impl_stub::DragOver(  /* [in] */ ULONG grf_key_state, /* [in] */ ecom_control_library::_POINTL pt, /* [in, out] */ ULONG * pdw_effect )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_grf_key_state = (EIF_INTEGER)grf_key_state;
	EIF_OBJECT tmp_pt = NULL;
	tmp_pt = eif_protect (grt_ce_control_interfaces2.ccom_ce_record_x_pointl_record137 (pt));
	EIF_OBJECT tmp_pdw_effect = NULL;
	if (pdw_effect != NULL)
	{
		tmp_pdw_effect = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_effect, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("drag_over", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_grf_key_state, ((tmp_pt != NULL) ? eif_access (tmp_pt) : NULL), ((tmp_pdw_effect != NULL) ? eif_access (tmp_pdw_effect) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_effect != NULL) ? eif_wean (tmp_pdw_effect) : NULL), pdw_effect);
	if (tmp_pt != NULL)
		eif_wean (tmp_pt);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDropTarget_impl_stub::DragLeave( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("drag_leave", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDropTarget_impl_stub::Drop(  /* [in] */ ecom_control_library::IDataObject * p_data_obj, /* [in] */ ULONG grf_key_state, /* [in] */ ecom_control_library::_POINTL pt, /* [in, out] */ ULONG * pdw_effect )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_data_obj = NULL;
	if (p_data_obj != NULL)
	{
		tmp_p_data_obj = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_106 (p_data_obj));
		p_data_obj->AddRef ();
	}
	EIF_INTEGER tmp_grf_key_state = (EIF_INTEGER)grf_key_state;
	EIF_OBJECT tmp_pt = NULL;
	tmp_pt = eif_protect (grt_ce_control_interfaces2.ccom_ce_record_x_pointl_record137 (pt));
	EIF_OBJECT tmp_pdw_effect = NULL;
	if (pdw_effect != NULL)
	{
		tmp_pdw_effect = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_effect, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("drop", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_data_obj != NULL) ? eif_access (tmp_p_data_obj) : NULL), (EIF_INTEGER)tmp_grf_key_state, ((tmp_pt != NULL) ? eif_access (tmp_pt) : NULL), ((tmp_pdw_effect != NULL) ? eif_access (tmp_pdw_effect) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_effect != NULL) ? eif_wean (tmp_pdw_effect) : NULL), pdw_effect);
	if (tmp_p_data_obj != NULL)
		eif_wean (tmp_p_data_obj);
	if (tmp_pt != NULL)
		eif_wean (tmp_pt);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IDropTarget_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IDropTarget_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDropTarget_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IDropTarget*>(this);
	else if (riid == IID_IDropTarget_)
		*ppv = static_cast<ecom_control_library::IDropTarget*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif