/*-----------------------------------------------------------
Implemented `IProvideTaskPage' interface.
-----------------------------------------------------------*/

#include "ecom_grt_globals_mstask_modified_idl_c.h"
#include "ecom_MS_TaskSched_lib_IProvideTaskPage_impl_stub.h"
static const IID IID_IProvideTaskPage_ = {0x4086658a,0xcbbb,0x11cf,{0xb6,0x04,0x00,0xc0,0x4f,0xd8,0xd5,0x65}};

ecom_MS_TaskSched_lib::IProvideTaskPage_impl_stub::IProvideTaskPage_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::IProvideTaskPage_impl_stub::~IProvideTaskPage_impl_stub()
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

STDMETHODIMP ecom_MS_TaskSched_lib::IProvideTaskPage_impl_stub::GetPage(  /* [in] */ long tp_type, /* [in] */ LONG f_persist_changes, /* [out] */ void * * ph_page )

/*-----------------------------------------------------------
	Retrieves the property sheet pages associated with a task.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_INTEGER tmp_tp_type = (EIF_INTEGER)tp_type;
	EIF_INTEGER tmp_f_persist_changes = (EIF_INTEGER)f_persist_changes;
	EIF_OBJECT tmp_ph_page = NULL;
	if (ph_page != NULL)
	{
		tmp_ph_page = eif_protect (rt_ce.ccom_ce_pointed_pointer (ph_page, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_page", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), (EIF_INTEGER)tmp_tp_type, (EIF_INTEGER)tmp_f_persist_changes, ((tmp_ph_page != NULL) ? eif_access (tmp_ph_page) : NULL));
	
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_MS_TaskSched_lib::IProvideTaskPage_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_MS_TaskSched_lib::IProvideTaskPage_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	 return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::IProvideTaskPage_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_MS_TaskSched_lib::IProvideTaskPage*>(this);
	else if (riid == IID_IProvideTaskPage_)
		*ppv = static_cast<ecom_MS_TaskSched_lib::IProvideTaskPage*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


