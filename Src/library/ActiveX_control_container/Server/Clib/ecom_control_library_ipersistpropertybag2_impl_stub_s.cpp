/*-----------------------------------------------------------
Implemented `IPersistPropertyBag2' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IPersistPropertyBag2_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IPersistPropertyBag2_ = {0x22f55881,0x280b,0x11d0,{0xa8,0xa9,0x00,0xa0,0xc9,0x0c,0x20,0x04}};

static const IID IID_IPersist_ = {0x0000010c,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IPersistPropertyBag2_impl_stub::IPersistPropertyBag2_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPersistPropertyBag2_impl_stub::~IPersistPropertyBag2_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistPropertyBag2_impl_stub::IPersist_GetClassID(  /* [out] */ GUID * p_class_id )

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

STDMETHODIMP ecom_control_library::IPersistPropertyBag2_impl_stub::InitNew( void )

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

STDMETHODIMP ecom_control_library::IPersistPropertyBag2_impl_stub::Load(  /* [in] */ ecom_control_library::IPropertyBag2 * p_prop_bag, /* [in] */ ecom_control_library::IErrorLog * p_err_log )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_prop_bag = NULL;
	if (p_prop_bag != NULL)
	{
		tmp_p_prop_bag = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_271 (p_prop_bag));
		p_prop_bag->AddRef ();
	}
	EIF_OBJECT tmp_p_err_log = NULL;
	if (p_err_log != NULL)
	{
		tmp_p_err_log = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_267 (p_err_log));
		p_err_log->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("load", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_prop_bag != NULL) ? eif_access (tmp_p_prop_bag) : NULL), ((tmp_p_err_log != NULL) ? eif_access (tmp_p_err_log) : NULL));
	if (tmp_p_prop_bag != NULL)
		eif_wean (tmp_p_prop_bag);
	if (tmp_p_err_log != NULL)
		eif_wean (tmp_p_err_log);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistPropertyBag2_impl_stub::Save(  /* [in] */ ecom_control_library::IPropertyBag2 * p_prop_bag, /* [in] */ LONG f_clear_dirty, /* [in] */ LONG f_save_all_properties )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_prop_bag = NULL;
	if (p_prop_bag != NULL)
	{
		tmp_p_prop_bag = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_271 (p_prop_bag));
		p_prop_bag->AddRef ();
	}
	EIF_INTEGER tmp_f_clear_dirty = (EIF_INTEGER)f_clear_dirty;
	EIF_INTEGER tmp_f_save_all_properties = (EIF_INTEGER)f_save_all_properties;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("save", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_prop_bag != NULL) ? eif_access (tmp_p_prop_bag) : NULL), (EIF_INTEGER)tmp_f_clear_dirty, (EIF_INTEGER)tmp_f_save_all_properties);
	if (tmp_p_prop_bag != NULL)
		eif_wean (tmp_p_prop_bag);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistPropertyBag2_impl_stub::IsDirty( void )

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

STDMETHODIMP_(ULONG) ecom_control_library::IPersistPropertyBag2_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IPersistPropertyBag2_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPersistPropertyBag2_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IPersistPropertyBag2*>(this);
	else if (riid == IID_IPersistPropertyBag2_)
		*ppv = static_cast<ecom_control_library::IPersistPropertyBag2*>(this);
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