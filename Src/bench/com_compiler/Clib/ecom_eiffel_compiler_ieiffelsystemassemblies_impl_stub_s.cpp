/*-----------------------------------------------------------
Implemented `IEiffelSystemAssemblies' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IEiffelSystemAssemblies_ = {0x9cf82ea0,0xb5f9,0x4110,{0xa7,0x58,0x24,0x1a,0x3b,0xc9,0x5d,0x52}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::IEiffelSystemAssemblies_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::~IEiffelSystemAssemblies_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::store( void )

/*-----------------------------------------------------------
	Save changes.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("store", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::add_assembly(  /* [in] */ BSTR assembly_prefix, /* [in] */ BSTR cluster_name, /* [in] */ BSTR a_name, /* [in] */ BSTR a_version, /* [in] */ BSTR a_culture, /* [in] */ BSTR a_publickey )

/*-----------------------------------------------------------
	Add a signed assembly to the project.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_assembly_prefix = NULL;
	if (assembly_prefix != NULL)
	{
		tmp_assembly_prefix = eif_protect (rt_ce.ccom_ce_bstr (assembly_prefix));
	}
	EIF_OBJECT tmp_cluster_name = NULL;
	if (cluster_name != NULL)
	{
		tmp_cluster_name = eif_protect (rt_ce.ccom_ce_bstr (cluster_name));
	}
	EIF_OBJECT tmp_a_name = NULL;
	if (a_name != NULL)
	{
		tmp_a_name = eif_protect (rt_ce.ccom_ce_bstr (a_name));
	}
	EIF_OBJECT tmp_a_version = NULL;
	if (a_version != NULL)
	{
		tmp_a_version = eif_protect (rt_ce.ccom_ce_bstr (a_version));
	}
	EIF_OBJECT tmp_a_culture = NULL;
	if (a_culture != NULL)
	{
		tmp_a_culture = eif_protect (rt_ce.ccom_ce_bstr (a_culture));
	}
	EIF_OBJECT tmp_a_publickey = NULL;
	if (a_publickey != NULL)
	{
		tmp_a_publickey = eif_protect (rt_ce.ccom_ce_bstr (a_publickey));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_assembly", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_assembly_prefix != NULL) ? eif_access (tmp_assembly_prefix) : NULL), ((tmp_cluster_name != NULL) ? eif_access (tmp_cluster_name) : NULL), ((tmp_a_name != NULL) ? eif_access (tmp_a_name) : NULL), ((tmp_a_version != NULL) ? eif_access (tmp_a_version) : NULL), ((tmp_a_culture != NULL) ? eif_access (tmp_a_culture) : NULL), ((tmp_a_publickey != NULL) ? eif_access (tmp_a_publickey) : NULL));
	if (tmp_assembly_prefix != NULL)
		eif_wean (tmp_assembly_prefix);
	if (tmp_cluster_name != NULL)
		eif_wean (tmp_cluster_name);
	if (tmp_a_name != NULL)
		eif_wean (tmp_a_name);
	if (tmp_a_version != NULL)
		eif_wean (tmp_a_version);
	if (tmp_a_culture != NULL)
		eif_wean (tmp_a_culture);
	if (tmp_a_publickey != NULL)
		eif_wean (tmp_a_publickey);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::add_local_assembly(  /* [in] */ BSTR assembly_prefix, /* [in] */ BSTR cluster_name, /* [in] */ BSTR a_path )

/*-----------------------------------------------------------
	Add a local assembly to the project.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_assembly_prefix = NULL;
	if (assembly_prefix != NULL)
	{
		tmp_assembly_prefix = eif_protect (rt_ce.ccom_ce_bstr (assembly_prefix));
	}
	EIF_OBJECT tmp_cluster_name = NULL;
	if (cluster_name != NULL)
	{
		tmp_cluster_name = eif_protect (rt_ce.ccom_ce_bstr (cluster_name));
	}
	EIF_OBJECT tmp_a_path = NULL;
	if (a_path != NULL)
	{
		tmp_a_path = eif_protect (rt_ce.ccom_ce_bstr (a_path));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_local_assembly", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_assembly_prefix != NULL) ? eif_access (tmp_assembly_prefix) : NULL), ((tmp_cluster_name != NULL) ? eif_access (tmp_cluster_name) : NULL), ((tmp_a_path != NULL) ? eif_access (tmp_a_path) : NULL));
	if (tmp_assembly_prefix != NULL)
		eif_wean (tmp_assembly_prefix);
	if (tmp_cluster_name != NULL)
		eif_wean (tmp_cluster_name);
	if (tmp_a_path != NULL)
		eif_wean (tmp_a_path);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::remove_assembly(  /* [in] */ BSTR assembly_identifier )

/*-----------------------------------------------------------
	Remove an assembly from the project.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_assembly_identifier = NULL;
	if (assembly_identifier != NULL)
	{
		tmp_assembly_identifier = eif_protect (rt_ce.ccom_ce_bstr (assembly_identifier));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remove_assembly", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_assembly_identifier != NULL) ? eif_access (tmp_assembly_identifier) : NULL));
	if (tmp_assembly_identifier != NULL)
		eif_wean (tmp_assembly_identifier);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::assembly_properties(  /* [in] */ BSTR cluster_name, /* [out, retval] */ ecom_eiffel_compiler::IEiffelAssemblyProperties * * return_value )

/*-----------------------------------------------------------
	Assembly properties.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_cluster_name = NULL;
	if (cluster_name != NULL)
	{
		tmp_cluster_name = eif_protect (rt_ce.ccom_ce_bstr (cluster_name));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("assembly_properties", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_cluster_name != NULL) ? eif_access (tmp_cluster_name) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "assembly_properties", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_139 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	if (tmp_cluster_name != NULL)
		eif_wean (tmp_cluster_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::is_valid_cluster_name(  /* [in] */ BSTR cluster_name, /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Checks to see if a assembly cluster name is valid
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_cluster_name = NULL;
	if (cluster_name != NULL)
	{
		tmp_cluster_name = eif_protect (rt_ce.ccom_ce_bstr (cluster_name));
	}
	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("is_valid_cluster_name", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_cluster_name != NULL) ? eif_access (tmp_cluster_name) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "is_valid_cluster_name", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	if (tmp_cluster_name != NULL)
		eif_wean (tmp_cluster_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::contains_assembly(  /* [in] */ BSTR cluster_name, /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Checks to see if a assembly cluster name has already been added to the project
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_cluster_name = NULL;
	if (cluster_name != NULL)
	{
		tmp_cluster_name = eif_protect (rt_ce.ccom_ce_bstr (cluster_name));
	}
	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("contains_assembly", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_cluster_name != NULL) ? eif_access (tmp_cluster_name) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "contains_assembly", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	if (tmp_cluster_name != NULL)
		eif_wean (tmp_cluster_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::contains_gac_assembly(  /* [in] */ BSTR a_name, /* [in] */ BSTR a_version, /* [in] */ BSTR a_culture, /* [in] */ BSTR a_publickey, /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Checks to see if a signed assembly has already been added to the project
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_name = NULL;
	if (a_name != NULL)
	{
		tmp_a_name = eif_protect (rt_ce.ccom_ce_bstr (a_name));
	}
	EIF_OBJECT tmp_a_version = NULL;
	if (a_version != NULL)
	{
		tmp_a_version = eif_protect (rt_ce.ccom_ce_bstr (a_version));
	}
	EIF_OBJECT tmp_a_culture = NULL;
	if (a_culture != NULL)
	{
		tmp_a_culture = eif_protect (rt_ce.ccom_ce_bstr (a_culture));
	}
	EIF_OBJECT tmp_a_publickey = NULL;
	if (a_publickey != NULL)
	{
		tmp_a_publickey = eif_protect (rt_ce.ccom_ce_bstr (a_publickey));
	}
	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("contains_gac_assembly", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_a_name != NULL) ? eif_access (tmp_a_name) : NULL), ((tmp_a_version != NULL) ? eif_access (tmp_a_version) : NULL), ((tmp_a_culture != NULL) ? eif_access (tmp_a_culture) : NULL), ((tmp_a_publickey != NULL) ? eif_access (tmp_a_publickey) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "contains_gac_assembly", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	if (tmp_a_name != NULL)
		eif_wean (tmp_a_name);
	if (tmp_a_version != NULL)
		eif_wean (tmp_a_version);
	if (tmp_a_culture != NULL)
		eif_wean (tmp_a_culture);
	if (tmp_a_publickey != NULL)
		eif_wean (tmp_a_publickey);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::contains_local_assembly(  /* [in] */ BSTR a_path, /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Checks to see if a unsigned assembly has already been added to the project
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_path = NULL;
	if (a_path != NULL)
	{
		tmp_a_path = eif_protect (rt_ce.ccom_ce_bstr (a_path));
	}
	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("contains_local_assembly", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_a_path != NULL) ? eif_access (tmp_a_path) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "contains_local_assembly", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	if (tmp_a_path != NULL)
		eif_wean (tmp_a_path);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::cluster_name_from_gac_assembly(  /* [in] */ BSTR a_name, /* [in] */ BSTR a_version, /* [in] */ BSTR a_culture, /* [in] */ BSTR a_publickey, /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Retrieves the cluster name for a signed assembly in the project
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_name = NULL;
	if (a_name != NULL)
	{
		tmp_a_name = eif_protect (rt_ce.ccom_ce_bstr (a_name));
	}
	EIF_OBJECT tmp_a_version = NULL;
	if (a_version != NULL)
	{
		tmp_a_version = eif_protect (rt_ce.ccom_ce_bstr (a_version));
	}
	EIF_OBJECT tmp_a_culture = NULL;
	if (a_culture != NULL)
	{
		tmp_a_culture = eif_protect (rt_ce.ccom_ce_bstr (a_culture));
	}
	EIF_OBJECT tmp_a_publickey = NULL;
	if (a_publickey != NULL)
	{
		tmp_a_publickey = eif_protect (rt_ce.ccom_ce_bstr (a_publickey));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("cluster_name_from_gac_assembly", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_a_name != NULL) ? eif_access (tmp_a_name) : NULL), ((tmp_a_version != NULL) ? eif_access (tmp_a_version) : NULL), ((tmp_a_culture != NULL) ? eif_access (tmp_a_culture) : NULL), ((tmp_a_publickey != NULL) ? eif_access (tmp_a_publickey) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "cluster_name_from_gac_assembly", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	if (tmp_a_name != NULL)
		eif_wean (tmp_a_name);
	if (tmp_a_version != NULL)
		eif_wean (tmp_a_version);
	if (tmp_a_culture != NULL)
		eif_wean (tmp_a_culture);
	if (tmp_a_publickey != NULL)
		eif_wean (tmp_a_publickey);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::cluster_name_from_local_assembly(  /* [in] */ BSTR a_path, /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Retrieves the cluster name for a unsigned assembly in the project
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_path = NULL;
	if (a_path != NULL)
	{
		tmp_a_path = eif_protect (rt_ce.ccom_ce_bstr (a_path));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("cluster_name_from_local_assembly", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_a_path != NULL) ? eif_access (tmp_a_path) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "cluster_name_from_local_assembly", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	if (tmp_a_path != NULL)
		eif_wean (tmp_a_path);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::is_valid_prefix(  /* [in] */ BSTR assembly_prefix, /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Is 'prefix' a valid assembly prefix
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_assembly_prefix = NULL;
	if (assembly_prefix != NULL)
	{
		tmp_assembly_prefix = eif_protect (rt_ce.ccom_ce_bstr (assembly_prefix));
	}
	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("is_valid_prefix", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_assembly_prefix != NULL) ? eif_access (tmp_assembly_prefix) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "is_valid_prefix", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	if (tmp_assembly_prefix != NULL)
		eif_wean (tmp_assembly_prefix);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::assemblies(  /* [out, retval] */ ecom_eiffel_compiler::IEnumAssembly * * return_value )

/*-----------------------------------------------------------
	Returns all of the assemblies in an enumerator
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("assemblies", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "assemblies", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_46 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	UnlockModule ();
	LONG res = InterlockedDecrement (&ref_count);
	if (res  ==  0)
	{
		delete this;
	}
	return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelSystemAssemblies*>(this);
	else if (riid == IID_IEiffelSystemAssemblies_)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelSystemAssemblies*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif