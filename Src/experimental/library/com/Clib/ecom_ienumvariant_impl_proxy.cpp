/*
indexing
	description: "EiffelCOM: library of reusable components for COM."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*-----------------------------------------------------------
Implemented `IEnumVARIANT1' Interface.
-----------------------------------------------------------*/

#include "ecom_IEnumVARIANT1_impl_proxy.h"
static const IID IID_IEnumVARIANT1_ = {0x00020404,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

IEnumVARIANT1_impl_proxy::IEnumVARIANT1_impl_proxy( IUnknown * a_pointer )
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	rt.ccom_check_hresult (hr);
	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	rt.ccom_check_hresult (hr);

	hr = a_pointer->QueryInterface(IID_IEnumVARIANT1_, (void **)&p_IEnumVARIANT1);
	rt.ccom_check_hresult (hr);

};
/*----------------------------------------------------------------------------------------------------------------------*/

IEnumVARIANT1_impl_proxy::~IEnumVARIANT1_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEnumVARIANT1!=NULL)
		p_IEnumVARIANT1->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IEnumVARIANT1_impl_proxy::ccom_next(  /* [in] */ EIF_INTEGER celt,  /* [in] */ VARIANT * rgvar,  /* [out] */ EIF_OBJECT pcelt_fetched )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumVARIANT1 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumVARIANT1_, (void **)&p_IEnumVARIANT1);
		rt.ccom_check_hresult (hr);
	};
	ULONG tmp_celt = 0;
	tmp_celt = (ULONG)celt;
	ULONG * tmp_pcelt_fetched = 0;
	tmp_pcelt_fetched = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pcelt_fetched), NULL);

	hr = p_IEnumVARIANT1->Next(tmp_celt,rgvar,tmp_pcelt_fetched);
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pcelt_fetched, pcelt_fetched);

	if (tmp_pcelt_fetched != NULL)
		CoTaskMemFree (tmp_pcelt_fetched);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IEnumVARIANT1_impl_proxy::ccom_skip(  /* [in] */ EIF_INTEGER celt )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumVARIANT1 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumVARIANT1_, (void **)&p_IEnumVARIANT1);
		rt.ccom_check_hresult (hr);
	};
	ULONG tmp_celt = 0;
	tmp_celt = (ULONG)celt;

	hr = p_IEnumVARIANT1->Skip(tmp_celt);
	rt.ccom_check_hresult (hr);


};
/*----------------------------------------------------------------------------------------------------------------------*/

void IEnumVARIANT1_impl_proxy::ccom_reset()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumVARIANT1 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumVARIANT1_, (void **)&p_IEnumVARIANT1);
		rt.ccom_check_hresult (hr);
	};
	hr = p_IEnumVARIANT1->Reset ();
	rt.ccom_check_hresult (hr);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IEnumVARIANT1_impl_proxy::ccom_clone1(  /* [out] */ EIF_OBJECT ppenum )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumVARIANT1 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumVARIANT1_, (void **)&p_IEnumVARIANT1);
		rt.ccom_check_hresult (hr);
	};
	IEnumVARIANT * * tmp_ppenum = 0;
	tmp_ppenum = (IEnumVARIANT * *)rt_ec.ccom_ec_pointed_pointed_enum_variant (eif_access (ppenum), NULL);

	hr = p_IEnumVARIANT1->Clone(tmp_ppenum);
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_pointed_enum_variant ((IEnumVARIANT * *)tmp_ppenum, ppenum);

	if (tmp_ppenum != NULL)
		CoTaskMemFree (tmp_ppenum);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER IEnumVARIANT1_impl_proxy::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif
