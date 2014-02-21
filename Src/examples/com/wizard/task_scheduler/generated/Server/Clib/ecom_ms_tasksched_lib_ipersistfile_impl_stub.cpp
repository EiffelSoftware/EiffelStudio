/*-----------------------------------------------------------
Implemented `IPersistFile' interface.
-----------------------------------------------------------*/

#include "ecom_grt_globals_mstask_modified_idl_c.h"
#include "ecom_MS_TaskSched_lib_IPersistFile_impl_stub.h"
static const IID IID_IPersistFile_ = {0x0000010b,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_IPersist_ = {0x0000010c,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

ecom_MS_TaskSched_lib::IPersistFile_impl_stub::IPersistFile_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::IPersistFile_impl_stub::~IPersistFile_impl_stub()
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

STDMETHODIMP ecom_MS_TaskSched_lib::IPersistFile_impl_stub::GetClassID(  /* [out] */ GUID * p_class_id )

/*-----------------------------------------------------------
	
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_p_class_id = NULL;
	if (p_class_id != NULL)
	{
		tmp_p_class_id = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_record_38 (p_class_id));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_class_id", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_p_class_id != NULL) ? eif_access (tmp_p_class_id) : NULL));
	
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::IPersistFile_impl_stub::IsDirty( void )

/*-----------------------------------------------------------
	
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("is_dirty", type_id);

	;
	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	;
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::IPersistFile_impl_stub::Load(  /* [in] */ LPWSTR psz_file_name, /* [in] */ ULONG dw_mode )

/*-----------------------------------------------------------
	
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_psz_file_name = NULL;
	if (psz_file_name != NULL)
	{
		tmp_psz_file_name = eif_protect (rt_ce.ccom_ce_lpwstr (psz_file_name, NULL));
	}
	EIF_INTEGER tmp_dw_mode = (EIF_INTEGER)dw_mode;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("load", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_psz_file_name != NULL) ? eif_access (tmp_psz_file_name) : NULL), (EIF_INTEGER)tmp_dw_mode);
	if (tmp_psz_file_name != NULL)
		eif_wean (tmp_psz_file_name);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::IPersistFile_impl_stub::Save(  /* [in] */ LPWSTR psz_file_name, /* [in] */ LONG f_remember )

/*-----------------------------------------------------------
	
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_psz_file_name = NULL;
	if (psz_file_name != NULL)
	{
		tmp_psz_file_name = eif_protect (rt_ce.ccom_ce_lpwstr (psz_file_name, NULL));
	}
	EIF_INTEGER tmp_f_remember = (EIF_INTEGER)f_remember;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("save", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_psz_file_name != NULL) ? eif_access (tmp_psz_file_name) : NULL), (EIF_INTEGER)tmp_f_remember);
	if (tmp_psz_file_name != NULL)
		eif_wean (tmp_psz_file_name);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::IPersistFile_impl_stub::SaveCompleted(  /* [in] */ LPWSTR psz_file_name )

/*-----------------------------------------------------------
	
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_psz_file_name = NULL;
	if (psz_file_name != NULL)
	{
		tmp_psz_file_name = eif_protect (rt_ce.ccom_ce_lpwstr (psz_file_name, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("save_completed", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_psz_file_name != NULL) ? eif_access (tmp_psz_file_name) : NULL));
	if (tmp_psz_file_name != NULL)
		eif_wean (tmp_psz_file_name);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::IPersistFile_impl_stub::GetCurFile(  /* [out] */ LPWSTR * ppsz_file_name )

/*-----------------------------------------------------------
	
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_ppsz_file_name = NULL;
	if (ppsz_file_name != NULL)
	{
		tmp_ppsz_file_name = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_39 (ppsz_file_name, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_cur_file", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_ppsz_file_name != NULL) ? eif_access (tmp_ppsz_file_name) : NULL));
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_39 (((tmp_ppsz_file_name != NULL) ? eif_wean (tmp_ppsz_file_name) : NULL), ppsz_file_name);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_MS_TaskSched_lib::IPersistFile_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_MS_TaskSched_lib::IPersistFile_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	 return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::IPersistFile_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_MS_TaskSched_lib::IPersistFile_2*>(this);
	else if (riid == IID_IPersistFile_)
		*ppv = static_cast<ecom_MS_TaskSched_lib::IPersistFile_2*>(this);
	else if (riid == IID_IPersist_)
		*ppv = static_cast<ecom_MS_TaskSched_lib::IPersist*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


