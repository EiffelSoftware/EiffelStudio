/*-----------------------------------------------------------
Implemented `IEnumVARIANT' Interface.
-----------------------------------------------------------*/

#include "ecom_IEnumVARIANT_impl.h"

static const IID IID_IEnumVARIANT = {0x00020404,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

IEnumVARIANT_impl::IEnumVARIANT_impl( IUnknown * a_pointer )
{
	HRESULT hr, hr2;

	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};

	hr = a_pointer->QueryInterface(IID_IEnumVARIANT, (void **)&p_IEnumVARIANT);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

IEnumVARIANT_impl::~IEnumVARIANT_impl()
{
	p_unknown->Release ();
	if (p_IEnumVARIANT!=NULL)
		p_IEnumVARIANT->Release ();
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IEnumVARIANT_impl::ccom_next(  /* [in] */ EIF_INTEGER celt,  /* [in] */ VARIANT * rgvar,  /* [out] */ EIF_OBJECT pcelt_fetched )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumVARIANT == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumVARIANT, (void **)&p_IEnumVARIANT);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	ULONG * tmp_pcelt_fetched = 0;
	tmp_pcelt_fetched = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pcelt_fetched), NULL);
	
	hr = p_IEnumVARIANT->Next((ULONG)celt,(VARIANT *)rgvar,tmp_pcelt_fetched);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pcelt_fetched, pcelt_fetched);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IEnumVARIANT_impl::ccom_skip(  /* [in] */ EIF_INTEGER celt )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumVARIANT == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumVARIANT, (void **)&p_IEnumVARIANT);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IEnumVARIANT->Skip((ULONG)celt);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IEnumVARIANT_impl::ccom_reset()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumVARIANT == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumVARIANT, (void **)&p_IEnumVARIANT);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	hr = p_IEnumVARIANT->Reset ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER IEnumVARIANT_impl::ccom_clone1()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumVARIANT == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumVARIANT, (void **)&p_IEnumVARIANT);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	IEnumVARIANT * tmp_ppenum = 0;
	
	hr = p_IEnumVARIANT->Clone(&tmp_ppenum);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	return (EIF_POINTER)tmp_ppenum;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER IEnumVARIANT_impl::ccom_item()

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