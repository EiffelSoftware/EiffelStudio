/*-----------------------------------------------------------
Implemented `VBA__Collection' Interface.
-----------------------------------------------------------*/

#include "ecom_VBA__Collection_impl.h"
static const IID IID_VBA__Collection = {0xa4c46780,0x499f,0x101b,{0xbb,0x78,0x00,0xaa,0x00,0x38,0x3c,0xbb}};

VBA__Collection_impl::VBA__Collection_impl( IUnknown * a_pointer )
{
	HRESULT hr, hr2;

	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};

	hr = a_pointer->QueryInterface(IID_VBA__Collection, (void **)&p_VBA__Collection);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

VBA__Collection_impl::~VBA__Collection_impl()
{
	p_unknown->Release ();
	if (p_VBA__Collection!=NULL)
		p_VBA__Collection->Release ();
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE VBA__Collection_impl::ccom_item1(  /* [in] */ VARIANT * index )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__Collection == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__Collection, (void **)&p_VBA__Collection);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result = 0;
	EIF_PROCEDURE make = 0;
	VARIANT * ret_value = 0;

	tid = eif_type_id ("ECOM_VARIANT");
	make = eif_procedure ("make", tid);
	result = eif_create (tid);
	make (eif_access (result));
	ret_value = (VARIANT*)eif_field (eif_access (result), "item", EIF_POINTER);
	
	hr = p_VBA__Collection->Item1((VARIANT *)index, ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	

	return eif_wean (result);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void VBA__Collection_impl::ccom_add(  /* [in] */ VARIANT * a_item,  /* [in] */ VARIANT * key,  /* [in] */ VARIANT * before,  /* [in] */ VARIANT * after )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__Collection == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__Collection, (void **)&p_VBA__Collection);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_VBA__Collection->Add((VARIANT *)a_item,(VARIANT *)key,(VARIANT *)before,(VARIANT *)after);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER VBA__Collection_impl::ccom_count()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__Collection == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__Collection, (void **)&p_VBA__Collection);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	long ret_value = 0;
	
	hr = p_VBA__Collection->Count( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	

	return (EIF_INTEGER)ret_value;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void VBA__Collection_impl::ccom_remove(  /* [in] */ VARIANT * index )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__Collection == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__Collection, (void **)&p_VBA__Collection);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_VBA__Collection->Remove((VARIANT *)index);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE VBA__Collection_impl::ccom_new_enum()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__Collection == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__Collection, (void **)&p_VBA__Collection);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	IUnknown * ret_value = 0;
	
	hr = p_VBA__Collection->_NewEnum( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	

	return (EIF_REFERENCE)rt_ce.ccom_ce_pointed_unknown (ret_value);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER VBA__Collection_impl::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/

