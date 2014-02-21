/*-----------------------------------------------------------
Implemented `IEnumWorkItems' interface.
-----------------------------------------------------------*/

#include "ecom_grt_globals_mstask_modified_idl_c.h"
#include "ecom_MS_TaskSched_lib_IEnumWorkItems_impl_stub.h"
static const IID IID_IEnumWorkItems_ = {0x148bd528,0xa2ab,0x11ce,{0xb1,0x1f,0x00,0xaa,0x00,0x53,0x05,0x03}};

ecom_MS_TaskSched_lib::IEnumWorkItems_impl_stub::IEnumWorkItems_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::IEnumWorkItems_impl_stub::~IEnumWorkItems_impl_stub()
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_PROC_STUB;

	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
	ECOM_EXIT_PROC_STUB;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::IEnumWorkItems_impl_stub::Next(  /* [in] */ ULONG celt, /* [out] */ LPWSTR * * rgpwsz_names, /* [out] */ ULONG * pcelt_fetched )

/*-----------------------------------------------------------
	Retrieves the next set of tasks in the enumeration sequence.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_INTEGER tmp_celt = (EIF_INTEGER)celt;
	EIF_OBJECT tmp_rgpwsz_names = NULL;
	if (rgpwsz_names != NULL)
	{
		tmp_rgpwsz_names = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_63 (rgpwsz_names, NULL));
	}
	EIF_OBJECT tmp_pcelt_fetched = NULL;
	if (pcelt_fetched != NULL)
	{
		tmp_pcelt_fetched = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pcelt_fetched, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("next", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), (EIF_INTEGER)tmp_celt, ((tmp_rgpwsz_names != NULL) ? eif_access (tmp_rgpwsz_names) : NULL), ((tmp_pcelt_fetched != NULL) ? eif_access (tmp_pcelt_fetched) : NULL));
	
	if (*rgpwsz_names != NULL)
		grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_62 (*rgpwsz_names);
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_63 (((tmp_rgpwsz_names != NULL) ? eif_wean (tmp_rgpwsz_names) : NULL), rgpwsz_names);
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pcelt_fetched != NULL) ? eif_wean (tmp_pcelt_fetched) : NULL), pcelt_fetched);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::IEnumWorkItems_impl_stub::Skip(  /* [in] */ ULONG celt )

/*-----------------------------------------------------------
	Skips the next set of tasks in the enumeration sequence.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_INTEGER tmp_celt = (EIF_INTEGER)celt;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("skip", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure)
	 (eif_access (eiffel_object), (EIF_INTEGER)tmp_celt);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::IEnumWorkItems_impl_stub::Reset( void )

/*-----------------------------------------------------------
	Resets the enumeration sequence to the beginning. 
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("reset", type_id);

	;
	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	;
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::IEnumWorkItems_impl_stub::Clone(  /* [out] */ ecom_MS_TaskSched_lib::IEnumWorkItems * * pp_enum_work_items )

/*-----------------------------------------------------------
	Creates a new enumeration object in the same state as the current enumeration object: the new object points to the same place in the enumeration sequence.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pp_enum_work_items = NULL;
	if (pp_enum_work_items != NULL)
	{
		tmp_pp_enum_work_items = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_57 (pp_enum_work_items, NULL));
		if (*pp_enum_work_items != NULL)
			(*pp_enum_work_items)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("clone1", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pp_enum_work_items != NULL) ? eif_access (tmp_pp_enum_work_items) : NULL));
	
	if (*pp_enum_work_items != NULL)
		(*pp_enum_work_items)->Release ();
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_57 (((tmp_pp_enum_work_items != NULL) ? eif_wean (tmp_pp_enum_work_items) : NULL), pp_enum_work_items);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_MS_TaskSched_lib::IEnumWorkItems_impl_stub::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	LONG res = InterlockedDecrement (&ref_count);
	if (res == 0)
	{
		delete this;
	}
	return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_MS_TaskSched_lib::IEnumWorkItems_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	 return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::IEnumWorkItems_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_MS_TaskSched_lib::IEnumWorkItems*>(this);
	else if (riid == IID_IEnumWorkItems_)
		*ppv = static_cast<ecom_MS_TaskSched_lib::IEnumWorkItems*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


