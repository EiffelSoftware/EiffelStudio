/*-----------------------------------------------------------
Implemented `IEiffelSystemClusters' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelSystemClusters_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IEiffelSystemClusters_ = {0xcd49d55e,0x5467,0x4058,{0xa9,0x99,0x1d,0x35,0xb9,0x05,0x76,0x4e}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::IEiffelSystemClusters_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::~IEiffelSystemClusters_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::cluster_tree(  /* [out, retval] */ ecom_eiffel_compiler::IEnumClusterProp * * return_value )

/*-----------------------------------------------------------
	Cluster tree.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("cluster_tree", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "cluster_tree", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_183 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::flat_clusters(  /* [out, retval] */ ecom_eiffel_compiler::IEnumClusterProp * * return_value )

/*-----------------------------------------------------------
	Cluster in a flat form.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("flat_clusters", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "flat_clusters", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_183 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::store( void )

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

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::add_cluster(  /* [in] */ BSTR cluster_name, /* [in] */ BSTR parent_name, /* [in] */ BSTR cluster_path )

/*-----------------------------------------------------------
	Add a cluster to the project.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_cluster_name = NULL;
	if (cluster_name != NULL)
	{
		tmp_cluster_name = eif_protect (rt_ce.ccom_ce_bstr (cluster_name));
	}
	EIF_OBJECT tmp_parent_name = NULL;
	if (parent_name != NULL)
	{
		tmp_parent_name = eif_protect (rt_ce.ccom_ce_bstr (parent_name));
	}
	EIF_OBJECT tmp_cluster_path = NULL;
	if (cluster_path != NULL)
	{
		tmp_cluster_path = eif_protect (rt_ce.ccom_ce_bstr (cluster_path));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_cluster", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_cluster_name != NULL) ? eif_access (tmp_cluster_name) : NULL), ((tmp_parent_name != NULL) ? eif_access (tmp_parent_name) : NULL), ((tmp_cluster_path != NULL) ? eif_access (tmp_cluster_path) : NULL));
	if (tmp_cluster_name != NULL)
		eif_wean (tmp_cluster_name);
	if (tmp_parent_name != NULL)
		eif_wean (tmp_parent_name);
	if (tmp_cluster_path != NULL)
		eif_wean (tmp_cluster_path);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::remove_cluster(  /* [in] */ BSTR cluster_name )

/*-----------------------------------------------------------
	Remove a cluster from the project.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_cluster_name = NULL;
	if (cluster_name != NULL)
	{
		tmp_cluster_name = eif_protect (rt_ce.ccom_ce_bstr (cluster_name));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remove_cluster", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_cluster_name != NULL) ? eif_access (tmp_cluster_name) : NULL));
	if (tmp_cluster_name != NULL)
		eif_wean (tmp_cluster_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::cluster_properties(  /* [in] */ BSTR cluster_name, /* [out, retval] */ ecom_eiffel_compiler::IEiffelClusterProperties * * return_value )

/*-----------------------------------------------------------
	Cluster properties.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_cluster_name = NULL;
	if (cluster_name != NULL)
	{
		tmp_cluster_name = eif_protect (rt_ce.ccom_ce_bstr (cluster_name));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("cluster_properties", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_cluster_name != NULL) ? eif_access (tmp_cluster_name) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "cluster_properties", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_186 (eif_access (tmp_object));
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

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::cluster_properties_by_id(  /* [in] */ ULONG cluster_id, /* [out, retval] */ ecom_eiffel_compiler::IEiffelClusterProperties * * return_value )

/*-----------------------------------------------------------
	Cluster properties.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_cluster_id = (EIF_INTEGER)cluster_id;
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("cluster_properties_by_id", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_INTEGER))eiffel_function) (eif_access (eiffel_object), (EIF_INTEGER)tmp_cluster_id);
	else
		tmp_value = eif_field (eif_access (eiffel_object), "cluster_properties_by_id", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_186 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::change_cluster_name(  /* [in] */ BSTR a_name, /* [in] */ BSTR a_new_name )

/*-----------------------------------------------------------
	Change cluster name.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_name = NULL;
	if (a_name != NULL)
	{
		tmp_a_name = eif_protect (rt_ce.ccom_ce_bstr (a_name));
	}
	EIF_OBJECT tmp_a_new_name = NULL;
	if (a_new_name != NULL)
	{
		tmp_a_new_name = eif_protect (rt_ce.ccom_ce_bstr (a_new_name));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("change_cluster_name", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_a_name != NULL) ? eif_access (tmp_a_name) : NULL), ((tmp_a_new_name != NULL) ? eif_access (tmp_a_new_name) : NULL));
	if (tmp_a_name != NULL)
		eif_wean (tmp_a_name);
	if (tmp_a_new_name != NULL)
		eif_wean (tmp_a_new_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::is_valid_name(  /* [in] */ BSTR cluster_name, /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Checks to see if a cluster name is valid
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_cluster_name = NULL;
	if (cluster_name != NULL)
	{
		tmp_cluster_name = eif_protect (rt_ce.ccom_ce_bstr (cluster_name));
	}
	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("is_valid_name", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_cluster_name != NULL) ? eif_access (tmp_cluster_name) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "is_valid_name", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	if (tmp_cluster_name != NULL)
		eif_wean (tmp_cluster_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::get_cluster_fullname(  /* [in] */ BSTR cluster_name, /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Retrieves a clusters full name from its name
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_cluster_name = NULL;
	if (cluster_name != NULL)
	{
		tmp_cluster_name = eif_protect (rt_ce.ccom_ce_bstr (cluster_name));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("get_cluster_fullname", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_cluster_name != NULL) ? eif_access (tmp_cluster_name) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "get_cluster_fullname", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
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

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelSystemClusters*>(this);
	else if (riid == IID_IEiffelSystemClusters_)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelSystemClusters*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif