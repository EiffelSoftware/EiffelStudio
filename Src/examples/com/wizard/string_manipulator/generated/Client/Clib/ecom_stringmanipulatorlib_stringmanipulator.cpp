/*-----------------------------------------------------------
String Manipulator String Manipulator Library
-----------------------------------------------------------*/

#include "ecom_grt_globals_string_manipulator_idl_c.h"
#include "ecom_StringManipulatorLib_StringManipulator.h"
static const CLSID CLSID_StringManipulator_ = {0x2db86ec0,0x9672,0x11d2,{0xb9,0x61,0x00,0x40,0x33,0x92,0xac,0x95}};

static const IID IID_IString_ = {0x9a483b80,0xaa39,0x11d2,{0xb9,0x61,0x00,0x40,0x33,0x92,0xac,0x95}};

ecom_StringManipulatorLib::StringManipulator::StringManipulator()
{
	HRESULT hr;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	rt.ccom_check_hresult (hr);
	p_unknown = NULL;
	MULTI_QI a_qi = {&IID_IUnknown, NULL, 0};

	hr = CoCreateInstanceEx (CLSID_StringManipulator_, NULL, CLSCTX_INPROC_SERVER, NULL, 1, &a_qi);
	rt.ccom_check_hresult (hr);
	rt.ccom_check_hresult (a_qi.hr);
	p_unknown = a_qi.pItf;

	p_IString = 0;

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_StringManipulatorLib::StringManipulator::StringManipulator( IUnknown * a_pointer )
{
	 HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	rt.ccom_check_hresult (hr);
	hr = a_pointer->QueryInterface(IID_IUnknown, (void**)&p_unknown);
	rt.ccom_check_hresult (hr);

	p_IString = 0;
	hr = a_pointer->QueryInterface(IID_IString_, (void**)&p_IString);
	rt.ccom_check_hresult (hr);

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_StringManipulatorLib::StringManipulator::~StringManipulator()
{
	p_unknown->Release ();
	if (p_IString != NULL)
		p_IString->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_StringManipulatorLib::StringManipulator::ccom_string(  )

/*-----------------------------------------------------------
	Manipulated string
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IString == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IString_, (void **)&p_IString);
		rt.ccom_check_hresult (hr);
	};
	LPSTR ret_value = 0;
	
	EIF_ENTER_C;
	hr = p_IString->String( &ret_value);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_lpstr (ret_value, NULL));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_StringManipulatorLib::StringManipulator::ccom_set_string(  /* [in] */ EIF_OBJECT a_string )

/*-----------------------------------------------------------
	Set manipulated string with `a_string'.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IString == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IString_, (void **)&p_IString);
		rt.ccom_check_hresult (hr);
	};
	LPSTR tmp_a_string = 0;
	tmp_a_string = (LPSTR)rt_ec.ccom_ec_lpstr (eif_access (a_string), NULL);
	
	EIF_ENTER_C;
	hr = p_IString->SetString(tmp_a_string);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_StringManipulatorLib::StringManipulator::ccom_replace_substring(  /* [in] */ EIF_OBJECT s,  /* [in] */ EIF_INTEGER start_pos,  /* [in] */ EIF_INTEGER end_pos )

/*-----------------------------------------------------------
	Copy the characters of `s' to positions `start_pos' .. `end_pos'.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IString == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IString_, (void **)&p_IString);
		rt.ccom_check_hresult (hr);
	};
	LPSTR tmp_s = 0;
	tmp_s = (LPSTR)rt_ec.ccom_ec_lpstr (eif_access (s), NULL);
	INT tmp_start_pos = 0;
	tmp_start_pos = (INT)start_pos;
	INT tmp_end_pos = 0;
	tmp_end_pos = (INT)end_pos;
	
	EIF_ENTER_C;
	hr = p_IString->ReplaceSubstring(tmp_s,tmp_start_pos,tmp_end_pos);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_StringManipulatorLib::StringManipulator::ccom_prune_all(  /* [in] */ EIF_CHARACTER c )

/*-----------------------------------------------------------
	Remove all occurrences of `c'.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IString == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IString_, (void **)&p_IString);
		rt.ccom_check_hresult (hr);
	};
	CHAR tmp_c = 0;
	tmp_c = (CHAR)c;
	
	EIF_ENTER_C;
	hr = p_IString->PruneAll(tmp_c);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_StringManipulatorLib::StringManipulator::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/


