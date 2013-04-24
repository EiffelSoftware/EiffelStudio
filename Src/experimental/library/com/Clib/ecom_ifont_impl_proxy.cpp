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
Implemented `IFont20' Interface.
-----------------------------------------------------------*/

#include "ecom_IFont20_impl_proxy.h"
static const IID IID_IFont20_ = {0xbef6e002,0xa874,0x101a,{0x8b,0xba,0x00,0xaa,0x00,0x30,0x0c,0xab}};

#ifdef __cplusplus
extern "C" {
#endif

IFont20_impl_proxy::IFont20_impl_proxy( IUnknown * a_pointer )
{
	HRESULT hr, hr2;

	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	rt.ccom_check_hresult (hr);

	hr = a_pointer->QueryInterface(IID_IFont20_, (void **)&p_IFont20);
	rt.ccom_check_hresult (hr);
};
/*----------------------------------------------------------------------------------------------------------------------*/

IFont20_impl_proxy::~IFont20_impl_proxy()
{
	p_unknown->Release ();
	if (p_IFont20!=NULL)
		p_IFont20->Release ();
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE IFont20_impl_proxy::ccom_name(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	BSTR ret_value = 0;
	
	hr = p_IFont20->IFont20_Name( &ret_value);
	rt.ccom_check_hresult (hr);

	return (EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont20_impl_proxy::ccom_set_name(  /* [in] */ EIF_OBJECT pname )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	BSTR tmp_pname = 0;
	tmp_pname = (BSTR)rt_ec.ccom_ec_bstr (eif_access (pname));
	
	hr = p_IFont20->IFont20_set_Name(tmp_pname);
	rt.ccom_check_hresult (hr);
	if (tmp_pname != NULL)
		SysFreeString (tmp_pname);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE IFont20_impl_proxy::ccom_size(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	
	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result;
	EIF_PROCEDURE make;
	CURRENCY * ret_value;

	tid = eif_type_id ("ECOM_CURRENCY");
	make = eif_procedure ("make", tid);
	result = eif_create (tid);
	make (eif_access (result));
	ret_value = (CURRENCY *)eif_field (eif_access (result), "item", EIF_POINTER);
	
	hr = p_IFont20->IFont20_Size( ret_value);
	rt.ccom_check_hresult (hr);

	return eif_wean (result);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont20_impl_proxy::ccom_set_size(  /* [in] */ CURRENCY * psize )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	
	hr = p_IFont20->IFont20_set_Size(*(CURRENCY*)psize);
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN IFont20_impl_proxy::ccom_bold(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IFont20->IFont20_Bold( &ret_value);
	rt.ccom_check_hresult (hr);

	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont20_impl_proxy::ccom_set_bold(  /* [in] */ EIF_BOOLEAN pbold )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	VARIANT_BOOL tmp_pbold = 0;
	tmp_pbold = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (pbold);
	
	hr = p_IFont20->IFont20_set_Bold(tmp_pbold);
	rt.ccom_check_hresult (hr);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN IFont20_impl_proxy::ccom_italic(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IFont20->IFont20_Italic( &ret_value);
	rt.ccom_check_hresult (hr);	

	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont20_impl_proxy::ccom_set_italic(  /* [in] */ EIF_BOOLEAN pitalic )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	VARIANT_BOOL tmp_pitalic = 0;
	tmp_pitalic = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (pitalic);
	
	hr = p_IFont20->IFont20_set_Italic(tmp_pitalic);
	rt.ccom_check_hresult (hr);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN IFont20_impl_proxy::ccom_underline(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IFont20->IFont20_Underline( &ret_value);
	rt.ccom_check_hresult (hr);
	
	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont20_impl_proxy::ccom_set_underline(  /* [in] */ EIF_BOOLEAN punderline )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	VARIANT_BOOL tmp_punderline = 0;
	tmp_punderline = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (punderline);
	
	hr = p_IFont20->IFont20_set_Underline(tmp_punderline);
	rt.ccom_check_hresult (hr);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN IFont20_impl_proxy::ccom_strikethrough(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IFont20->IFont20_Strikethrough( &ret_value);
	rt.ccom_check_hresult (hr);	

	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont20_impl_proxy::ccom_set_strikethrough(  /* [in] */ EIF_BOOLEAN pstrikethrough )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	VARIANT_BOOL tmp_pstrikethrough = 0;
	tmp_pstrikethrough = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (pstrikethrough);
	
	hr = p_IFont20->IFont20_set_Strikethrough(tmp_pstrikethrough);
	rt.ccom_check_hresult (hr);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER IFont20_impl_proxy::ccom_weight(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	SHORT ret_value = 0;
	
	hr = p_IFont20->IFont20_Weight( &ret_value);
	rt.ccom_check_hresult (hr);	

	return (EIF_INTEGER)ret_value;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont20_impl_proxy::ccom_set_weight(  /* [in] */ EIF_INTEGER pweight )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	SHORT tmp_pweight = 0;
	tmp_pweight = (SHORT)pweight;
	
	hr = p_IFont20->IFont20_set_Weight(tmp_pweight);
	rt.ccom_check_hresult (hr);	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER IFont20_impl_proxy::ccom_charset(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	SHORT ret_value = 0;
	
	hr = p_IFont20->IFont20_Charset( &ret_value);
	rt.ccom_check_hresult (hr);	

	return (EIF_INTEGER)ret_value;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont20_impl_proxy::ccom_set_charset(  /* [in] */ EIF_INTEGER pcharset )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	SHORT tmp_pcharset = 0;
	tmp_pcharset = (SHORT)pcharset;
	
	hr = p_IFont20->IFont20_set_Charset(tmp_pcharset);
	rt.ccom_check_hresult (hr);	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER IFont20_impl_proxy::ccom_h_font(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	OLE_HANDLE ret_value = 0;
	
	hr = p_IFont20->hFont( &ret_value);
	rt.ccom_check_hresult (hr);	

	return (EIF_INTEGER)ret_value;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont20_impl_proxy::ccom_clone1(  /* [out] */ EIF_OBJECT ppfont )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	IFont20 * * tmp_ppfont = 0;
	tmp_ppfont = (IFont20 * *)rt_ec.ccom_ec_pointed_pointed_ifont (eif_access (ppfont), NULL);
	
	hr = p_IFont20->Clone(tmp_ppfont);
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_pointed_ifont ((IFont * *)tmp_ppfont, ppfont);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont20_impl_proxy::ccom_is_equal1(  /* [in] */ IFont * pfont_other )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	
	hr = p_IFont20->IsEqual((IFont20 *) pfont_other);
	rt.ccom_check_hresult (hr);	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont20_impl_proxy::ccom_set_ratio(  /* [in] */ EIF_INTEGER cy_logical,  /* [in] */ EIF_INTEGER cy_himetric )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	LONG tmp_cy_logical = 0;
	tmp_cy_logical = (LONG)cy_logical;
	LONG tmp_cy_himetric = 0;
	tmp_cy_himetric = (LONG)cy_himetric;
	
	hr = p_IFont20->SetRatio(tmp_cy_logical,tmp_cy_himetric);
	rt.ccom_check_hresult (hr);	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont20_impl_proxy::ccom_add_ref_hfont(  /* [in] */ EIF_INTEGER a_h_font )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	OLE_HANDLE tmp_a_h_font = 0;
	tmp_a_h_font = (OLE_HANDLE)a_h_font;
	
	hr = p_IFont20->AddRefHfont(tmp_a_h_font);
	rt.ccom_check_hresult (hr);	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont20_impl_proxy::ccom_release_hfont(  /* [in] */ EIF_INTEGER a_h_font )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont20 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont20_, (void **)&p_IFont20);
		rt.ccom_check_hresult (hr);
	};
	OLE_HANDLE tmp_a_h_font = 0;
	tmp_a_h_font = (OLE_HANDLE)a_h_font;
	
	hr = p_IFont20->ReleaseHfont(tmp_a_h_font);
	rt.ccom_check_hresult (hr);	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER IFont20_impl_proxy::ccom_item()

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
