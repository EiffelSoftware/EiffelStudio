/*-----------------------------------------------------------
Implemented `IEnumObjectFiles' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEnumObjectFiles_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IEnumObjectFiles_ = {0x5ce55179,0x0954,0x44f9,{0x9e,0x1f,0xa7,0x44,0x56,0x64,0x20,0x47}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEnumObjectFiles_impl_stub::IEnumObjectFiles_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumObjectFiles_impl_stub::~IEnumObjectFiles_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEnumObjectFiles_impl_stub::Next(  /* [out] */ BSTR * rgelt, /* [out] */ ULONG * pcelt_fetched )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_rgelt = NULL;
	if (rgelt != NULL)
	{
		tmp_rgelt = eif_protect (grt_ce_ISE.ccom_ce_pointed_cell_220 (rgelt, NULL));
	}
	EIF_OBJECT tmp_pcelt_fetched = NULL;
	if (pcelt_fetched != NULL)
	{
		tmp_pcelt_fetched = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pcelt_fetched, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("next", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_rgelt != NULL) ? eif_access (tmp_rgelt) : NULL), ((tmp_pcelt_fetched != NULL) ? eif_access (tmp_pcelt_fetched) : NULL));
	
	if (*rgelt != NULL)
		rt_ce.free_memory_bstr (*rgelt);
	grt_ec_ISE.ccom_ec_pointed_cell_220 (((tmp_rgelt != NULL) ? eif_wean (tmp_rgelt) : NULL), rgelt);
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pcelt_fetched != NULL) ? eif_wean (tmp_pcelt_fetched) : NULL), pcelt_fetched);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEnumObjectFiles_impl_stub::Skip(  /* [in] */ ULONG celt )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_celt = (EIF_INTEGER)celt;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("skip", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_celt);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEnumObjectFiles_impl_stub::Reset( void )

/*-----------------------------------------------------------
	No description available.
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

STDMETHODIMP ecom_eiffel_compiler::IEnumObjectFiles_impl_stub::Clone(  /* [out] */ ecom_eiffel_compiler::IEnumObjectFiles * * ppenum )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppenum = NULL;
	if (ppenum != NULL)
	{
		tmp_ppenum = eif_protect (grt_ce_ISE.ccom_ce_pointed_cell_215 (ppenum, NULL));
		if (*ppenum != NULL)
			(*ppenum)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("clone1", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppenum != NULL) ? eif_access (tmp_ppenum) : NULL));
	
	if (*ppenum != NULL)
		(*ppenum)->Release ();
	grt_ec_ISE.ccom_ec_pointed_cell_215 (((tmp_ppenum != NULL) ? eif_wean (tmp_ppenum) : NULL), ppenum);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEnumObjectFiles_impl_stub::ith_item(  /* [in] */ ULONG an_index, /* [out] */ BSTR * rgelt )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_an_index = (EIF_INTEGER)an_index;
	EIF_OBJECT tmp_rgelt = NULL;
	if (rgelt != NULL)
	{
		tmp_rgelt = eif_protect (grt_ce_ISE.ccom_ce_pointed_cell_222 (rgelt, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("ith_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_an_index, ((tmp_rgelt != NULL) ? eif_access (tmp_rgelt) : NULL));
	
	if (*rgelt != NULL)
		rt_ce.free_memory_bstr (*rgelt);
	grt_ec_ISE.ccom_ec_pointed_cell_222 (((tmp_rgelt != NULL) ? eif_wean (tmp_rgelt) : NULL), rgelt);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEnumObjectFiles_impl_stub::count(  /* [out, retval] */ ULONG * return_value )

/*-----------------------------------------------------------
	No description available.
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
	*return_value = (ULONG)tmp_value;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEnumObjectFiles_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEnumObjectFiles_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEnumObjectFiles_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_eiffel_compiler::IEnumObjectFiles*>(this);
	else if (riid == IID_IEnumObjectFiles_)
		*ppv = static_cast<ecom_eiffel_compiler::IEnumObjectFiles*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif