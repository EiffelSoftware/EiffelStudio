/*-----------------------------------------------------------
Implemented `IPersistMemory' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IPersistMemory_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IPersistMemory_ = {0xbd1ae5e0,0xa6ae,0x11ce,{0xbd,0x37,0x50,0x42,0x00,0xc1,0x00,0x00}};

static const IID IID_IPersist_ = {0x0000010c,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IPersistMemory_impl_stub::IPersistMemory_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPersistMemory_impl_stub::~IPersistMemory_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistMemory_impl_stub::IPersist_GetClassID(  /* [out] */ GUID * p_class_id )

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

STDMETHODIMP ecom_control_library::IPersistMemory_impl_stub::IsDirty( void )

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

STDMETHODIMP ecom_control_library::IPersistMemory_impl_stub::RemoteLoad(  /* [in] */ UCHAR * p_mem, /* [in] */ ULONG cb_size )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_mem = NULL;
	if (p_mem != NULL)
	{
		tmp_p_mem = eif_protect (rt_ce.ccom_ce_pointed_unsigned_character (p_mem, NULL));
	}
	EIF_INTEGER tmp_cb_size = (EIF_INTEGER)cb_size;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_load", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_mem != NULL) ? eif_access (tmp_p_mem) : NULL), (EIF_INTEGER)tmp_cb_size);
	if (tmp_p_mem != NULL)
		eif_wean (tmp_p_mem);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistMemory_impl_stub::RemoteSave(  /* [out] */ UCHAR * p_mem, /* [in] */ LONG f_clear_dirty, /* [in] */ ULONG cb_size )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_mem = NULL;
	if (p_mem != NULL)
	{
		tmp_p_mem = eif_protect (rt_ce.ccom_ce_pointed_unsigned_character (p_mem, NULL));
	}
	EIF_INTEGER tmp_f_clear_dirty = (EIF_INTEGER)f_clear_dirty;
	EIF_INTEGER tmp_cb_size = (EIF_INTEGER)cb_size;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_save", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_mem != NULL) ? eif_access (tmp_p_mem) : NULL), (EIF_INTEGER)tmp_f_clear_dirty, (EIF_INTEGER)tmp_cb_size);
	rt_ec.ccom_ec_pointed_unsigned_character (((tmp_p_mem != NULL) ? eif_wean (tmp_p_mem) : NULL), p_mem);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistMemory_impl_stub::GetSizeMax(  /* [out] */ ULONG * pcb_size )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pcb_size = NULL;
	if (pcb_size != NULL)
	{
		tmp_pcb_size = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pcb_size, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_size_max", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pcb_size != NULL) ? eif_access (tmp_pcb_size) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pcb_size != NULL) ? eif_wean (tmp_pcb_size) : NULL), pcb_size);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistMemory_impl_stub::InitNew( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("init_new", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IPersistMemory_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IPersistMemory_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistMemory_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IPersistMemory*>(this);
	else if (riid == IID_IPersistMemory_)
		*ppv = static_cast<ecom_control_library::IPersistMemory*>(this);
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