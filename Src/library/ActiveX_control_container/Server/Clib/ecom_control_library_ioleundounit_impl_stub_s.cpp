/*-----------------------------------------------------------
Implemented `IOleUndoUnit' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleUndoUnit_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IOleUndoUnit_ = {0x894ad3b0,0xef97,0x11ce,{0x9b,0xc9,0x00,0xaa,0x00,0x60,0x8e,0x01}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleUndoUnit_impl_stub::IOleUndoUnit_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleUndoUnit_impl_stub::~IOleUndoUnit_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoUnit_impl_stub::Do(  /* [in] */ ecom_control_library::IOleUndoManager * p_undo_manager )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_undo_manager = NULL;
	if (p_undo_manager != NULL)
	{
		tmp_p_undo_manager = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_166 (p_undo_manager));
		p_undo_manager->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("do1", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_undo_manager != NULL) ? eif_access (tmp_p_undo_manager) : NULL));
	if (tmp_p_undo_manager != NULL)
		eif_wean (tmp_p_undo_manager);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoUnit_impl_stub::GetDescription(  /* [out] */ BSTR * p_bstr )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_bstr = NULL;
	if (p_bstr != NULL)
	{
		tmp_p_bstr = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_167 (p_bstr, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_description", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_bstr != NULL) ? eif_access (tmp_p_bstr) : NULL));
	
	if (*p_bstr != NULL)
		rt_ce.free_memory_bstr (*p_bstr);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_167 (((tmp_p_bstr != NULL) ? eif_wean (tmp_p_bstr) : NULL), p_bstr);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoUnit_impl_stub::GetUnitType(  /* [out] */ GUID * p_clsid, /* [out] */ LONG * pl_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_clsid = NULL;
	if (p_clsid != NULL)
	{
		tmp_p_clsid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (p_clsid));
	}
	EIF_OBJECT tmp_pl_id = NULL;
	if (pl_id != NULL)
	{
		tmp_pl_id = eif_protect (rt_ce.ccom_ce_pointed_long (pl_id, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_unit_type", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_clsid != NULL) ? eif_access (tmp_p_clsid) : NULL), ((tmp_pl_id != NULL) ? eif_access (tmp_pl_id) : NULL));
	
	rt_ec.ccom_ec_pointed_long (((tmp_pl_id != NULL) ? eif_wean (tmp_pl_id) : NULL), pl_id);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoUnit_impl_stub::OnNextAdd( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("on_next_add", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IOleUndoUnit_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IOleUndoUnit_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoUnit_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IOleUndoUnit*>(this);
	else if (riid == IID_IOleUndoUnit_)
		*ppv = static_cast<ecom_control_library::IOleUndoUnit*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif