/*-----------------------------------------------------------
Component registration code
-----------------------------------------------------------*/

#include "server_registration.h"

#ifdef __cplusplus
extern "C" {
#endif

DWORD dwRegister_FolderBrowser;


FolderBrowser_factory FolderBrowser_cls_object;

TCHAR file_name[MAX_PATH];

OLECHAR ws_file_name[MAX_PATH];

const REG_DATA reg_entries[] = 
{
	
	{
		__TEXT("CLSID\\{524055AE-3734-40BB-ADF3-70B36899302A}"),
		0,
		__TEXT("FolderBrowser Class"),
		TRUE
	},
	{
		__TEXT("CLSID\\{524055AE-3734-40BB-ADF3-70B36899302A}\\InprocServer32"),
		0,
		file_name,
		TRUE
	},
	{
		__TEXT("CLSID\\{524055AE-3734-40BB-ADF3-70B36899302A}\\InprocServer32"),
		__TEXT("ThreadingModel"),
		__TEXT("Apartment"),
		TRUE
	},
	{
		__TEXT("CLSID\\{524055AE-3734-40BB-ADF3-70B36899302A}\\ProgID"),
		0,
		__TEXT("FolderBrowser.FolderBrowser.1"),
		TRUE
	},
	{
		__TEXT("CLSID\\{524055AE-3734-40BB-ADF3-70B36899302A}\\VersionIndependentProgID"),
		0,
		__TEXT("FolderBrowser.FolderBrowser"),
		TRUE
	},
	{
		__TEXT("FolderBrowser.FolderBrowser.1"),
		0,
		__TEXT("FolderBrowser"),
		TRUE
	},
	{
		__TEXT("FolderBrowser.FolderBrowser.1\\CLSID"),
		0,
		__TEXT("{524055AE-3734-40BB-ADF3-70B36899302A}"),
		TRUE
	},
	{
		__TEXT("FolderBrowser.FolderBrowser"),
		0,
		__TEXT("FolderBrowser"),
		TRUE
	},
	{
		__TEXT("FolderBrowser.FolderBrowser\\CLSID"),
		0,
		__TEXT("{524055AE-3734-40BB-ADF3-70B36899302A}"),
		TRUE
	},
	{
		__TEXT("FolderBrowser.FolderBrowser\\CurVer"),
		0,
		__TEXT("FolderBrowser.FolderBrowser.1"),
		TRUE
	}
};

const int com_entries_count = sizeof (reg_entries)/sizeof (*reg_entries);

long lock_count = 0;



EIF_INTEGER Unregister( const REG_DATA *rgEntries, int cEntries )

	/*-----------------------------------------------------------
	Unregister Server/Component
	-----------------------------------------------------------*/
{
	static const IID LIBID_FolderBrowser_ = {0xba223fc7,0xf4bf,0x4ec8,{0x85,0xf1,0xa6,0xf1,0x13,0xbd,0xaa,0xfa}};
	HRESULT hr = UnRegisterTypeLib (LIBID_FolderBrowser_, 1, 0, 0, SYS_WIN32);
	BOOL bSuccess = SUCCEEDED (hr);
	for (int i= cEntries -1; i >= 0; i--)
		if (rgEntries[i].pDelOnUnregister)
		{
			LONG err = RegDeleteKey (HKEY_CLASSES_ROOT, rgEntries[i].pKeyName);
			if (err != ERROR_SUCCESS)
				bSuccess = FALSE;
		}
	return bSuccess ? S_OK: S_FALSE;
};

EIF_INTEGER Register( const REG_DATA *rgEntries, int cEntries )

	/*-----------------------------------------------------------
	Register Server
	-----------------------------------------------------------*/
{
	BOOL bSuccess = TRUE;
	const REG_DATA *pEntry = rgEntries;
	while (pEntry < rgEntries + cEntries)
	{
		HKEY hkey;
		LONG err = RegCreateKey (HKEY_CLASSES_ROOT, pEntry->pKeyName, &hkey);
		if (err == ERROR_SUCCESS)
		{
			if (pEntry->pValue)
				err = RegSetValueEx (hkey, pEntry->pValueName, 0, REG_SZ, (const BYTE*)pEntry->pValue, (lstrlen (pEntry->pValue) + 1) * sizeof (TCHAR));
			if (err != ERROR_SUCCESS)
			{
				bSuccess = FALSE;
				Unregister (rgEntries, 1 + pEntry - rgEntries);
			}
			RegCloseKey (hkey);
		}
		if (err != ERROR_SUCCESS)
		{
			bSuccess = FALSE;
			if (pEntry != rgEntries)
			Unregister (rgEntries, pEntry - rgEntries);
		}
		pEntry++;
	}
	if (!bSuccess)
		return E_FAIL;

	ITypeLib *ptl = 0;
	HRESULT hr = LoadTypeLib (ws_file_name, &ptl);
	if (SUCCEEDED (hr))
	{
		hr = RegisterTypeLib (ptl, ws_file_name, 0);
		ptl->Release ();
	}
	return hr;
};

EIF_INTEGER ccom_dll_get_class_object_function( CLSID * rclsid, IID * riid, void **ppv )

	/*-----------------------------------------------------------
	DLL get class object funcion
	-----------------------------------------------------------*/
{
	if (IsEqualGUID (* rclsid, CLSID_FolderBrowser_))
	{
		if (!(FolderBrowser_cls_object.IsInitialized))
			FolderBrowser_cls_object.Initialize();
		return FolderBrowser_cls_object.QueryInterface (* riid, ppv);
	}
	else 
		return (*ppv = 0), CLASS_E_CLASSNOTAVAILABLE;
};

EIF_INTEGER ccom_dll_register_server_function( void )

	/*-----------------------------------------------------------
	Register DLL server.
	-----------------------------------------------------------*/
{
	GetModuleFileName (eif_hInstance, file_name, MAX_PATH);

#ifdef UNICODE
	lstrcpy (ws_file_name, file_name);
#else
	mbstowcs (ws_file_name, file_name, MAX_PATH);
#endif
	return Register (reg_entries, com_entries_count);
};

EIF_INTEGER ccom_dll_unregister_server_function( void )

	/*-----------------------------------------------------------
	Unregister Server.
	-----------------------------------------------------------*/
{
	return Unregister (reg_entries, com_entries_count);
};

EIF_INTEGER ccom_dll_can_unload_now_function( void )

	/*-----------------------------------------------------------
	Whether component can be unloaded?
	-----------------------------------------------------------*/
{
	return lock_count? S_FALSE: S_OK;
};

void UnlockModule( void )

	/*-----------------------------------------------------------
	Unlock module.
	-----------------------------------------------------------*/
{
	InterlockedDecrement (&lock_count);
};

void LockModule( void )

	/*-----------------------------------------------------------
	Lock module.
	-----------------------------------------------------------*/
{
	InterlockedIncrement (&lock_count);
};
#ifdef __cplusplus
}
#endif