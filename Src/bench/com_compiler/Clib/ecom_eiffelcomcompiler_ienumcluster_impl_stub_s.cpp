/*-----------------------------------------------------------
Implemented `IEnumCluster' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEnumCluster_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IEnumCluster_ = {0x7a252ad5,0xc033,0x4f33,{0x98,0xa2,0x55,0x1d,0x84,0x51,0xb8,0xc4}};

static const IID LIBID_EiffelComCompiler_ = {0x06b5d7c0,0x2c7d,0x4d1c,{0xa9,0x8b,0x45,0x99,0xbd,0xcd,0xfa,0x58}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEnumCluster_impl_stub::IEnumCluster_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
	pTypeInfo = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumCluster_impl_stub::~IEnumCluster_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
	if (pTypeInfo)
		pTypeInfo->Release ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumCluster_impl_stub::Next(  /* [out] */ ecom_EiffelComCompiler::IEiffelClusterDescriptor * * pp_ieiffel_cluster_descriptor, /* [out] */ ULONG * pul_count )

/*-----------------------------------------------------------
	Go to next item in enumerator
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_ieiffel_cluster_descriptor = NULL;
	if (pp_ieiffel_cluster_descriptor != NULL)
	{
		tmp_pp_ieiffel_cluster_descriptor = eif_protect (grt_ce_ISE.ccom_ce_pointed_cell_50 (pp_ieiffel_cluster_descriptor, NULL));
		if (*pp_ieiffel_cluster_descriptor != NULL)
			(*pp_ieiffel_cluster_descriptor)->AddRef ();
	}
	EIF_OBJECT tmp_pul_count = NULL;
	if (pul_count != NULL)
	{
		tmp_pul_count = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pul_count, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("next", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_ieiffel_cluster_descriptor != NULL) ? eif_access (tmp_pp_ieiffel_cluster_descriptor) : NULL), ((tmp_pul_count != NULL) ? eif_access (tmp_pul_count) : NULL));
	
	if (*pp_ieiffel_cluster_descriptor != NULL)
		(*pp_ieiffel_cluster_descriptor)->Release ();
	grt_ec_ISE.ccom_ec_pointed_cell_50 (((tmp_pp_ieiffel_cluster_descriptor != NULL) ? eif_wean (tmp_pp_ieiffel_cluster_descriptor) : NULL), pp_ieiffel_cluster_descriptor);
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pul_count != NULL) ? eif_wean (tmp_pul_count) : NULL), pul_count);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumCluster_impl_stub::Skip(  /* [in] */ ULONG ul_count )

/*-----------------------------------------------------------
	Skip `ulCount' items.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_ul_count = (EIF_INTEGER)ul_count;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("skip", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_ul_count);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumCluster_impl_stub::Reset( void )

/*-----------------------------------------------------------
	Reset enumerator.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("reset", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumCluster_impl_stub::Clone(  /* [out] */ ecom_EiffelComCompiler::IEnumCluster * * pp_ienum_cluster )

/*-----------------------------------------------------------
	Clone enumerator.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_ienum_cluster = NULL;
	if (pp_ienum_cluster != NULL)
	{
		tmp_pp_ienum_cluster = eif_protect (grt_ce_ISE.ccom_ce_pointed_cell_43 (pp_ienum_cluster, NULL));
		if (*pp_ienum_cluster != NULL)
			(*pp_ienum_cluster)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("clone1", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_ienum_cluster != NULL) ? eif_access (tmp_pp_ienum_cluster) : NULL));
	
	if (*pp_ienum_cluster != NULL)
		(*pp_ienum_cluster)->Release ();
	grt_ec_ISE.ccom_ec_pointed_cell_43 (((tmp_pp_ienum_cluster != NULL) ? eif_wean (tmp_pp_ienum_cluster) : NULL), pp_ienum_cluster);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumCluster_impl_stub::IthItem(  /* [in] */ ULONG ul_index, /* [out] */ ecom_EiffelComCompiler::IEiffelClusterDescriptor * * pp_ieiffel_cluster_descriptor )

/*-----------------------------------------------------------
	Retrieve enumerators ith item at `ulIndex'.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_ul_index = (EIF_INTEGER)ul_index;
	EIF_OBJECT tmp_pp_ieiffel_cluster_descriptor = NULL;
	if (pp_ieiffel_cluster_descriptor != NULL)
	{
		tmp_pp_ieiffel_cluster_descriptor = eif_protect (grt_ce_ISE.ccom_ce_pointed_cell_50 (pp_ieiffel_cluster_descriptor, NULL));
		if (*pp_ieiffel_cluster_descriptor != NULL)
			(*pp_ieiffel_cluster_descriptor)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("ith_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_ul_index, ((tmp_pp_ieiffel_cluster_descriptor != NULL) ? eif_access (tmp_pp_ieiffel_cluster_descriptor) : NULL));
	
	if (*pp_ieiffel_cluster_descriptor != NULL)
		(*pp_ieiffel_cluster_descriptor)->Release ();
	grt_ec_ISE.ccom_ec_pointed_cell_50 (((tmp_pp_ieiffel_cluster_descriptor != NULL) ? eif_wean (tmp_pp_ieiffel_cluster_descriptor) : NULL), pp_ieiffel_cluster_descriptor);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumCluster_impl_stub::Count(  /* [out, retval] */ ULONG * pul_count )

/*-----------------------------------------------------------
	Retrieve enumerator item count.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_INTEGER_FUNCTION eiffel_function = 0;
	eiffel_function = eif_integer_function ("count", type_id);
	EIF_INTEGER tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "count", EIF_INTEGER);
	*pul_count = (ULONG)tmp_value;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumCluster_impl_stub::GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo )

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
		tmp_hr = LoadRegTypeLib (LIBID_EiffelComCompiler_, 2, 0, 0, &pTypeLib);
		if (FAILED(tmp_hr))
			return tmp_hr;
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEnumCluster_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	(*pptinfo = pTypeInfo)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumCluster_impl_stub::GetTypeInfoCount( unsigned int * pctinfo )

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

STDMETHODIMP ecom_EiffelComCompiler::IEnumCluster_impl_stub::GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid )

/*-----------------------------------------------------------
	IDs of function names 'rgszNames'
-----------------------------------------------------------*/
{
	if (pTypeInfo == 0)
	{
		HRESULT tmp_hr = 0;
		ITypeLib *pTypeLib = 0;
		tmp_hr = LoadRegTypeLib (LIBID_EiffelComCompiler_, 2, 0, 0, &pTypeLib);
		if (FAILED(tmp_hr))
			return tmp_hr;
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEnumCluster_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	return pTypeInfo->GetIDsOfNames (rgszNames, cNames, rgdispid);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumCluster_impl_stub::Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr )

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
		
		case 10088:
			{
				if (pDispParams->cArgs != 2)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (2*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {16393, 16403};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 16393)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 16393);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				ecom_EiffelComCompiler::IEiffelClusterDescriptor * * arg_0 = 0;
				IID tmp_iid_0 = {0x09cc4e23,0xceac,0x44b5,{0xb5,0x25,0x61,0xed,0x0c,0xef,0x00,0x75}};
				ecom_EiffelComCompiler::IEiffelClusterDescriptor * tmp_tmp_arg_0 = 0;
				if (tmp_value [0]->vt = (VT_UNKNOWN |VT_BYREF))
				{
					IUnknown ** tmp_arg_0 = tmp_value [0]->ppunkVal;
					if (tmp_arg_0 != NULL)
						if (* tmp_arg_0 != NULL)
							hr = (*tmp_arg_0)->QueryInterface (tmp_iid_0, (void**)(&tmp_tmp_arg_0));
				}
				else if (tmp_value [0]->vt = (VT_DISPATCH |VT_BYREF))
				{
					IDispatch ** tmp_arg_0 = tmp_value [0]->ppdispVal;
					if (tmp_arg_0 != NULL)
						if (* tmp_arg_0 != NULL)
							hr = (*tmp_arg_0)->QueryInterface (tmp_iid_0, (void**)(&tmp_tmp_arg_0));
				}
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					
					return DISP_E_TYPEMISMATCH;
				}
				arg_0 = &tmp_tmp_arg_0;
				
				if (tmp_value [1]->vt != 16403)
				{
					hr = VariantChangeType (tmp_value [1], tmp_value [1], VARIANT_NOUSEROVERRIDE, 16403);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 1;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				ULONG * arg_1 = (ULONG *)tmp_value [1]->pulVal;
				
				hr = Next ( arg_0, arg_1);
				
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

		case 10089:
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
				
				hr = Skip ( arg_0);
				
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

		case 10090:
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				
				hr = Reset ();
				
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

		case 10091:
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {16393};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 16393)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 16393);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				ecom_EiffelComCompiler::IEnumCluster * * arg_0 = 0;
				IID tmp_iid_0 = {0x7a252ad5,0xc033,0x4f33,{0x98,0xa2,0x55,0x1d,0x84,0x51,0xb8,0xc4}};
				ecom_EiffelComCompiler::IEnumCluster * tmp_tmp_arg_0 = 0;
				if (tmp_value [0]->vt = (VT_UNKNOWN |VT_BYREF))
				{
					IUnknown ** tmp_arg_0 = tmp_value [0]->ppunkVal;
					if (tmp_arg_0 != NULL)
						if (* tmp_arg_0 != NULL)
							hr = (*tmp_arg_0)->QueryInterface (tmp_iid_0, (void**)(&tmp_tmp_arg_0));
				}
				else if (tmp_value [0]->vt = (VT_DISPATCH |VT_BYREF))
				{
					IDispatch ** tmp_arg_0 = tmp_value [0]->ppdispVal;
					if (tmp_arg_0 != NULL)
						if (* tmp_arg_0 != NULL)
							hr = (*tmp_arg_0)->QueryInterface (tmp_iid_0, (void**)(&tmp_tmp_arg_0));
				}
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					
					return DISP_E_TYPEMISMATCH;
				}
				arg_0 = &tmp_tmp_arg_0;
				
				hr = Clone ( arg_0);
				
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

		case 10092:
			{
				if (pDispParams->cArgs != 2)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (2*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {19, 16393};

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
				
				if (tmp_value [1]->vt != 16393)
				{
					hr = VariantChangeType (tmp_value [1], tmp_value [1], VARIANT_NOUSEROVERRIDE, 16393);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 1;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				ecom_EiffelComCompiler::IEiffelClusterDescriptor * * arg_1 = 0;
				IID tmp_iid_1 = {0x09cc4e23,0xceac,0x44b5,{0xb5,0x25,0x61,0xed,0x0c,0xef,0x00,0x75}};
				ecom_EiffelComCompiler::IEiffelClusterDescriptor * tmp_tmp_arg_1 = 0;
				if (tmp_value [1]->vt = (VT_UNKNOWN |VT_BYREF))
				{
					IUnknown ** tmp_arg_1 = tmp_value [1]->ppunkVal;
					if (tmp_arg_1 != NULL)
						if (* tmp_arg_1 != NULL)
							hr = (*tmp_arg_1)->QueryInterface (tmp_iid_1, (void**)(&tmp_tmp_arg_1));
				}
				else if (tmp_value [1]->vt = (VT_DISPATCH |VT_BYREF))
				{
					IDispatch ** tmp_arg_1 = tmp_value [1]->ppdispVal;
					if (tmp_arg_1 != NULL)
						if (* tmp_arg_1 != NULL)
							hr = (*tmp_arg_1)->QueryInterface (tmp_iid_1, (void**)(&tmp_tmp_arg_1));
				}
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					
					return DISP_E_TYPEMISMATCH;
				}
				arg_1 = &tmp_tmp_arg_1;
				
				hr = IthItem ( arg_0, arg_1);
				
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

		case 10093:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				ULONG result = 0;
				
				hr = Count (&result);
				
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
					pVarResult->vt = 19;
					pVarResult->ulVal = result;
				}
					
			}
			break;

		default:
			return DISP_E_MEMBERNOTFOUND;
	}
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::IEnumCluster_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::IEnumCluster_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumCluster_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_EiffelComCompiler::IEnumCluster*>(this);
	else if (riid == IID_IDispatch)
		*ppv = static_cast<ecom_EiffelComCompiler::IEnumCluster*>(this);
	else if (riid == IID_IEnumCluster_)
		*ppv = static_cast<ecom_EiffelComCompiler::IEnumCluster*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif