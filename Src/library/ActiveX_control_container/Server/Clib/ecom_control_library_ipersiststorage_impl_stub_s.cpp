/*-----------------------------------------------------------
Implemented `IPersistStorage' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IPersistStorage_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IPersistStorage_ = {0x0000010a,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_IPersist_ = {0x0000010c,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IPersistStorage_impl_stub::IPersistStorage_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPersistStorage_impl_stub::~IPersistStorage_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistStorage_impl_stub::IPersist_GetClassID(  /* [out] */ GUID * p_class_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_class_id = NULL;
	if (p_class_id != NULL)
	{
		tmp_p_class_id = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (p_class_id));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_class_id", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_class_id != NULL) ? eif_access (tmp_p_class_id) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistStorage_impl_stub::IsDirty( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("is_dirty", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistStorage_impl_stub::InitNew(  /* [in] */ ecom_control_library::IStorage * pstg )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pstg = NULL;
	if (pstg != NULL)
	{
		tmp_pstg = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_280 (pstg));
		pstg->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("init_new", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pstg != NULL) ? eif_access (tmp_pstg) : NULL));
	if (tmp_pstg != NULL)
		eif_wean (tmp_pstg);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistStorage_impl_stub::Load(  /* [in] */ ecom_control_library::IStorage * pstg )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pstg = NULL;
	if (pstg != NULL)
	{
		tmp_pstg = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_280 (pstg));
		pstg->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("load", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pstg != NULL) ? eif_access (tmp_pstg) : NULL));
	if (tmp_pstg != NULL)
		eif_wean (tmp_pstg);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistStorage_impl_stub::Save(  /* [in] */ ecom_control_library::IStorage * p_stg_save, /* [in] */ LONG f_same_as_load )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_stg_save = NULL;
	if (p_stg_save != NULL)
	{
		tmp_p_stg_save = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_280 (p_stg_save));
		p_stg_save->AddRef ();
	}
	EIF_INTEGER tmp_f_same_as_load = (EIF_INTEGER)f_same_as_load;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("save", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_stg_save != NULL) ? eif_access (tmp_p_stg_save) : NULL), (EIF_INTEGER)tmp_f_same_as_load);
	if (tmp_p_stg_save != NULL)
		eif_wean (tmp_p_stg_save);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistStorage_impl_stub::SaveCompleted(  /* [in] */ ecom_control_library::IStorage * p_stg_new )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_stg_new = NULL;
	if (p_stg_new != NULL)
	{
		tmp_p_stg_new = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_280 (p_stg_new));
		p_stg_new->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("save_completed", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_stg_new != NULL) ? eif_access (tmp_p_stg_new) : NULL));
	if (tmp_p_stg_new != NULL)
		eif_wean (tmp_p_stg_new);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistStorage_impl_stub::HandsOffStorage( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("hands_off_storage", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IPersistStorage_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IPersistStorage_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistStorage_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IPersistStorage*>(this);
	else if (riid == IID_IPersistStorage_)
		*ppv = static_cast<ecom_control_library::IPersistStorage*>(this);
	else if (riid == IID_IPersist_)
		*ppv = static_cast<ecom_control_library::IPersist*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif