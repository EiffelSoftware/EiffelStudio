/*-----------------------------------------------------------
Implemented `IFolderBrowser' Interface.
-----------------------------------------------------------*/

#include "ecom_FolderBrowser_IFolderBrowser_impl_proxy_s.h"
static const IID IID_IFolderBrowser_ = {0x7e8227b1,0x110e,0x4d6b,{0x99,0xa6,0xdc,0xd5,0x10,0x10,0x91,0xa4}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_FolderBrowser::IFolderBrowser_impl_proxy::IFolderBrowser_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IFolderBrowser_, (void **)&p_IFolderBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_FolderBrowser::IFolderBrowser_impl_proxy::~IFolderBrowser_impl_proxy()
{
	p_unknown->Release ();
	if (p_IFolderBrowser!=NULL)
		p_IFolderBrowser->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_FolderBrowser::IFolderBrowser_impl_proxy::ccom_folder_name(  /* [out] */ EIF_OBJECT result1 )

/*-----------------------------------------------------------
	Folder chosen by the user.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFolderBrowser == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFolderBrowser_, (void **)&p_IFolderBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR * tmp_result1 = 0;
	tmp_result1 = (LPWSTR *)grt_ec_folder_browser.ccom_ec_pointed_cell_1 (eif_access (result1), NULL);
	
	hr = p_IFolderBrowser->FolderName(tmp_result1);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_folder_browser.ccom_ce_pointed_cell_1 ((LPWSTR *)tmp_result1, result1);
	
	grt_ce_folder_browser.ccom_free_memory_pointed_1 (tmp_result1);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_FolderBrowser::IFolderBrowser_impl_proxy::ccom_item()

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