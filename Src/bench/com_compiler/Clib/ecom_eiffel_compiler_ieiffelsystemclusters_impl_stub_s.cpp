/*-----------------------------------------------------------
Implemented `IEiffelSystemClusters' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelSystemClusters_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IEiffelSystemClusters_ = {0xd2773adf,0xfd21,0x4cfa,{0x9a,0x4f,0x87,0x73,0xcf,0xf6,0x2c,0xfd}};

static const IID LIBID_eiffel_compiler_ = {0xa81ca1a9,0x3eef,0x4e47,{0xbe,0xae,0xc1,0x63,0x25,0xee,0xfa,0x3f}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::IEiffelSystemClusters_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
	pTypeInfo = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::~IEiffelSystemClusters_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
	if (pTypeInfo)
		pTypeInfo->Release ();
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
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_142 (eif_access (tmp_object));
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
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_142 (eif_access (tmp_object));
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
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_145 (eif_access (tmp_object));
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
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_145 (eif_access (tmp_object));
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

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo )

/*-----------------------------------------------------------
	Get type info
-----------------------------------------------------------*/
{
	if ((itinfo != 0) || (pptinfo == NULL))
		return E_INVALIDARG;
	*pptinfo = NULL;
	if (pTypeInfo == 0)
	{
		HRESULT tmp_hr = 0;
		ITypeLib *pTypeLib = 0;
		tmp_hr = LoadRegTypeLib (LIBID_eiffel_compiler_, 0, 0, 0, &pTypeLib);
		if (FAILED(tmp_hr))
			return tmp_hr;
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEiffelSystemClusters_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	(*pptinfo = pTypeInfo)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::GetTypeInfoCount( unsigned int * pctinfo )

/*-----------------------------------------------------------
	Get type info count
-----------------------------------------------------------*/
{
	if (pctinfo == NULL)
		return E_NOTIMPL;
	*pctinfo = 1;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid )

/*-----------------------------------------------------------
	IDs of function names 'rgszNames'
-----------------------------------------------------------*/
{
	if (pTypeInfo == 0)
	{
		HRESULT tmp_hr = 0;
		ITypeLib *pTypeLib = 0;
		tmp_hr = LoadRegTypeLib (LIBID_eiffel_compiler_, 0, 0, 0, &pTypeLib);
		if (FAILED(tmp_hr))
			return tmp_hr;
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEiffelSystemClusters_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	return pTypeInfo->GetIDsOfNames (rgszNames, cNames, rgdispid);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub::Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr )

/*-----------------------------------------------------------
	Invoke function.
-----------------------------------------------------------*/
{
	HRESULT hr = 0;
	int i = 0;

	unsigned int uArgErr;
	if (wFlags & ~(DISPATCH_METHOD | DISPATCH_PROPERTYGET | DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
		return ResultFromScode (E_INVALIDARG);

	if (puArgErr == NULL)
		puArgErr = &uArgErr;

	VARIANTARG * rgvarg = pDispParams->rgvarg;
	DISPID * rgdispidNamedArgs = pDispParams->rgdispidNamedArgs;
	unsigned int cArgs = pDispParams->cArgs;
	unsigned int cNamedArgs = pDispParams->cNamedArgs;
	VARIANTARG ** tmp_value = NULL;

	if (pExcepInfo != NULL)
	{
		pExcepInfo->wCode = 0;
		pExcepInfo->wReserved = 0;
		pExcepInfo->bstrSource = NULL;
		pExcepInfo->bstrDescription = NULL;
		pExcepInfo->bstrHelpFile = NULL;
		pExcepInfo->dwHelpContext = 0;
		pExcepInfo->pvReserved = NULL;
		pExcepInfo->pfnDeferredFillIn = NULL;
		pExcepInfo->scode = 0;
	}
	
	switch (dispID)
	{
		
		case 1610743808:
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				ecom_eiffel_compiler::IEnumClusterProp * result = 0;
				
				hr = cluster_tree (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 13;
					pVarResult->punkVal = result;
				}
					
			}
			break;

		case 1610743809:
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				ecom_eiffel_compiler::IEnumClusterProp * result = 0;
				
				hr = flat_clusters (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 13;
					pVarResult->punkVal = result;
				}
					
			}
			break;

		case 1610743810:
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				
				hr = store ();
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
			}
			break;

		case 1610743811:
			{
				if (pDispParams->cArgs != 3)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (3*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8, 8, 8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				if (tmp_value [1]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [1], tmp_value [1], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 1;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_1 = (BSTR)tmp_value [1]->bstrVal;
				
				if (tmp_value [2]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [2], tmp_value [2], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 2;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_2 = (BSTR)tmp_value [2]->bstrVal;
				
				hr = add_cluster ( arg_0, arg_1, arg_2);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 1610743812:
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				hr = remove_cluster ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 1610743813:
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				ecom_eiffel_compiler::IEiffelClusterProperties * result = 0;
				
				hr = cluster_properties ( arg_0,&result);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 9;
					pVarResult->pdispVal = result;
				}
					
				CoTaskMemFree (tmp_value);
			}
			break;

		case 1610743814:
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {19};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 19)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 19);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				ULONG arg_0 = (ULONG)tmp_value [0]->ulVal;
				ecom_eiffel_compiler::IEiffelClusterProperties * result = 0;
				
				hr = cluster_properties_by_id ( arg_0,&result);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 9;
					pVarResult->pdispVal = result;
				}
					
				CoTaskMemFree (tmp_value);
			}
			break;

		case 1610743815:
			{
				if (pDispParams->cArgs != 2)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (2*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8, 8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				if (tmp_value [1]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [1], tmp_value [1], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 1;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_1 = (BSTR)tmp_value [1]->bstrVal;
				
				hr = change_cluster_name ( arg_0, arg_1);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 1610743816:
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				VARIANT_BOOL result = 0;
				
				hr = is_valid_name ( arg_0,&result);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 11;
					pVarResult->boolVal = result;
				}
					
				CoTaskMemFree (tmp_value);
			}
			break;

		case 1610743817:
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				BSTR result = 0;
				
				hr = get_cluster_fullname ( arg_0,&result);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 8;
					pVarResult->bstrVal = result;
				}
					
				CoTaskMemFree (tmp_value);
			}
			break;

		default:
			return DISP_E_MEMBERNOTFOUND;
	}
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
		if (pTypeInfo !=NULL)
		{
			pTypeInfo->Release ();
			pTypeInfo = NULL;
		}
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
	else if (riid == IID_IDispatch)
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