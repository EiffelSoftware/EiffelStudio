/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#include "ecom_ISE_Reflection_CodeGenerator_Generator.h"
static const CLSID CLSID_Generator_ = {0xae310cb5,0x5478,0x39d0,{0x89,0xc4,0xb3,0x1f,0xae,0xae,0xfb,0xb2}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_ISE_Reflection_CodeGenerator::Generator::Generator()
{
	HRESULT hr;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	p_unknown = NULL;
	MULTI_QI a_qi = {&IID_IUnknown, NULL, 0};

	hr = CoCreateInstanceEx (CLSID_Generator_, NULL, CLSCTX_INPROC_SERVER, NULL, 1, &a_qi);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	if (FAILED (a_qi.hr))
	{
		if ((HRESULT_FACILITY (a_qi.hr)  ==  FACILITY_ITF) && (HRESULT_CODE (a_qi.hr) > 1024) && (HRESULT_CODE (a_qi.hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (a_qi.hr) - 1024), NULL),HRESULT_CODE (a_qi.hr) - 1024);
		com_eraise (f.c_format_message (a_qi.hr), EN_PROG);
	};
	p_unknown = a_qi.pItf;

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_CodeGenerator::Generator::Generator( IUnknown * a_pointer )
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_CodeGenerator::Generator::~Generator()
{
	p_unknown->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_ISE_Reflection_CodeGenerator::Generator::ccom_item()

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