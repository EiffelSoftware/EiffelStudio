/*-----------------------------------------------------------
Implemented `IFont' Interface.
-----------------------------------------------------------*/

#include "ecom_IFont_impl.h"

static const IID IID_IFont1 = {0xbef6e002,0xa874,0x101a,{0x8b,0xba,0x00,0xaa,0x00,0x30,0x0c,0xab}};


IFont_impl::IFont_impl( IUnknown * a_pointer )
{
	HRESULT hr, hr2;

	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};

	hr = a_pointer->QueryInterface(IID_IFont1, (void **)&p_IFont);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

IFont_impl::~IFont_impl()
{
	p_unknown->Release ();
	if (p_IFont!=NULL)
		p_IFont->Release ();
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE IFont_impl::ccom_name(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	BSTR tmp_pname = 0;
	
	hr = p_IFont->IFont_Name( &tmp_pname);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_REFERENCE)rt_ce.ccom_ce_bstr (tmp_pname);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont_impl::ccom_set_name(  /* [in] */ EIF_OBJECT pname )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IFont_set_Name((BSTR)rt_ec.ccom_ec_bstr (eif_access (pname)));
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE IFont_impl::ccom_size(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
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
	
	hr = p_IFont->IFont_Size( ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return eif_wean (result);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont_impl::ccom_set_size(  /* [in] */ CURRENCY * psize )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IFont_set_Size(*(CURRENCY*)psize);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN IFont_impl::ccom_bold(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	VARIANT_BOOL tmp_pbold = 0;
	
	hr = p_IFont->IFont_Bold( &tmp_pbold);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (tmp_pbold);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont_impl::ccom_set_bold(  /* [in] */ EIF_BOOLEAN pbold )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IFont_set_Bold((VARIANT_BOOL)rt_ec.ccom_ec_boolean (pbold));
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN IFont_impl::ccom_italic(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	VARIANT_BOOL tmp_pitalic = 0;
	
	hr = p_IFont->IFont_Italic( &tmp_pitalic);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (tmp_pitalic);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont_impl::ccom_set_italic(  /* [in] */ EIF_BOOLEAN pitalic )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IFont_set_Italic((VARIANT_BOOL)rt_ec.ccom_ec_boolean (pitalic));
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN IFont_impl::ccom_underline(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	VARIANT_BOOL tmp_punderline = 0;
	
	hr = p_IFont->IFont_Underline( &tmp_punderline);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (tmp_punderline);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont_impl::ccom_set_underline(  /* [in] */ EIF_BOOLEAN punderline )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IFont_set_Underline((VARIANT_BOOL)rt_ec.ccom_ec_boolean (punderline));
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN IFont_impl::ccom_strikethrough(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	VARIANT_BOOL tmp_pstrikethrough = 0;
	
	hr = p_IFont->IFont_Strikethrough( &tmp_pstrikethrough);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (tmp_pstrikethrough);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont_impl::ccom_set_strikethrough(  /* [in] */ EIF_BOOLEAN pstrikethrough )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IFont_set_Strikethrough((VARIANT_BOOL)rt_ec.ccom_ec_boolean (pstrikethrough));
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER IFont_impl::ccom_weight(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	SHORT tmp_pweight = 0;
	
	hr = p_IFont->IFont_Weight( &tmp_pweight);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_INTEGER)tmp_pweight;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont_impl::ccom_set_weight(  /* [in] */ EIF_INTEGER pweight )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IFont_set_Weight((SHORT)pweight);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER IFont_impl::ccom_charset(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	SHORT tmp_pcharset = 0;
	
	hr = p_IFont->IFont_Charset( &tmp_pcharset);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_INTEGER)tmp_pcharset;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont_impl::ccom_set_charset(  /* [in] */ EIF_INTEGER pcharset )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IFont_set_Charset((SHORT)pcharset);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER IFont_impl::ccom_h_font(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	OLE_HANDLE tmp_phfont = 0;
	
	hr = p_IFont->hFont( &tmp_phfont);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_INTEGER)tmp_phfont;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER IFont_impl::ccom_clone1( )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	IFont *  tmp_ppfont = 0;
	
	hr = p_IFont->Clone1(&tmp_ppfont);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	return (EIF_POINTER)tmp_ppfont;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont_impl::ccom_is_equal1(  /* [in] */ IFont * pfont_other )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IsEqual((IFont *)pfont_other);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont_impl::ccom_set_ratio(  /* [in] */ EIF_INTEGER cy_logical,  /* [in] */ EIF_INTEGER cy_himetric )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->SetRatio((LONG)cy_logical,(LONG)cy_himetric);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont_impl::ccom_add_ref_hfont(  /* [in] */ EIF_INTEGER a_h_font )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->AddRefHfont((OLE_HANDLE)a_h_font);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void IFont_impl::ccom_release_hfont(  /* [in] */ EIF_INTEGER a_h_font )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->ReleaseHfont((OLE_HANDLE)a_h_font);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER IFont_impl::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/
