/*-----------------------------------------------------------
Component registration code
-----------------------------------------------------------*/

#include "server_registration.h"

#ifdef __cplusplus
extern "C" {
#endif

DWORD dwRegister_CEiffelProject;


CEiffelProject_factory CEiffelProject_cls_object;

DWORD dwRegister_CEiffelCompiler;


CEiffelCompiler_factory CEiffelCompiler_cls_object;

TCHAR file_name[MAX_PATH];

OLECHAR ws_file_name[MAX_PATH];

const REG_DATA reg_entries[] = 
{
	
	{
		__TEXT("CLSID\\{28F511DB-0CCE-44C5-9DD5-E93066C0B00F}"),
		0,
		__TEXT("CEiffelProject Class"),
		TRUE
	},
	{
		__TEXT("CLSID\\{28F511DB-0CCE-44C5-9DD5-E93066C0B00F}\\InprocServer32"),
		0,
		file_name,
		TRUE
	},
	{
		__TEXT("CLSID\\{28F511DB-0CCE-44C5-9DD5-E93066C0B00F}\\InprocServer32"),
		__TEXT("ThreadingModel"),
		__TEXT("Apartment"),
		TRUE
	},
	{
		__TEXT("CLSID\\{28F511DB-0CCE-44C5-9DD5-E93066C0B00F}\\ProgID"),
		0,
		__TEXT("eiffel_compiler.CEiffelProject.1"),
		TRUE
	},
	{
		__TEXT("CLSID\\{28F511DB-0CCE-44C5-9DD5-E93066C0B00F}\\VersionIndependentProgID"),
		0,
		__TEXT("eiffel_compiler.CEiffelProject"),
		TRUE
	},
	{
		__TEXT("eiffel_compiler.CEiffelProject.1"),
		0,
		__TEXT("CEiffelProject"),
		TRUE
	},
	{
		__TEXT("eiffel_compiler.CEiffelProject.1\\CLSID"),
		0,
		__TEXT("{28F511DB-0CCE-44C5-9DD5-E93066C0B00F}"),
		TRUE
	},
	{
		__TEXT("eiffel_compiler.CEiffelProject"),
		0,
		__TEXT("CEiffelProject"),
		TRUE
	},
	{
		__TEXT("eiffel_compiler.CEiffelProject\\CLSID"),
		0,
		__TEXT("{28F511DB-0CCE-44C5-9DD5-E93066C0B00F}"),
		TRUE
	},
	{
		__TEXT("eiffel_compiler.CEiffelProject\\CurVer"),
		0,
		__TEXT("eiffel_compiler.CEiffelProject.1"),
		TRUE
	},
	{
		__TEXT("CLSID\\{86D23C62-E03D-4A16-83F6-8F79D628110E}"),
		0,
		__TEXT("CEiffelCompiler Class"),
		TRUE
	},
	{
		__TEXT("CLSID\\{86D23C62-E03D-4A16-83F6-8F79D628110E}\\InprocServer32"),
		0,
		file_name,
		TRUE
	},
	{
		__TEXT("CLSID\\{86D23C62-E03D-4A16-83F6-8F79D628110E}\\InprocServer32"),
		__TEXT("ThreadingModel"),
		__TEXT("Apartment"),
		TRUE
	},
	{
		__TEXT("CLSID\\{86D23C62-E03D-4A16-83F6-8F79D628110E}\\ProgID"),
		0,
		__TEXT("eiffel_compiler.CEiffelCompiler.1"),
		TRUE
	},
	{
		__TEXT("CLSID\\{86D23C62-E03D-4A16-83F6-8F79D628110E}\\VersionIndependentProgID"),
		0,
		__TEXT("eiffel_compiler.CEiffelCompiler"),
		TRUE
	},
	{
		__TEXT("eiffel_compiler.CEiffelCompiler.1"),
		0,
		__TEXT("CEiffelCompiler"),
		TRUE
	},
	{
		__TEXT("eiffel_compiler.CEiffelCompiler.1\\CLSID"),
		0,
		__TEXT("{86D23C62-E03D-4A16-83F6-8F79D628110E}"),
		TRUE
	},
	{
		__TEXT("eiffel_compiler.CEiffelCompiler"),
		0,
		__TEXT("CEiffelCompiler"),
		TRUE
	},
	{
		__TEXT("eiffel_compiler.CEiffelCompiler\\CLSID"),
		0,
		__TEXT("{86D23C62-E03D-4A16-83F6-8F79D628110E}"),
		TRUE
	},
	{
		__TEXT("eiffel_compiler.CEiffelCompiler\\CurVer"),
		0,
		__TEXT("eiffel_compiler.CEiffelCompiler.1"),
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
	static const IID LIBID_eiffel_compiler_ = {0xa81ca1a9,0x3eef,0x4e47,{0xbe,0xae,0xc1,0x63,0x25,0xee,0xfa,0x3f}};
	HRESULT hr = UnRegisterTypeLib (LIBID_eiffel_compiler_, 1, 0, 0, SYS_WIN32);
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
	if (IsEqualGUID (* rclsid, CLSID_CEiffelProject_))
	{
		if (!(CEiffelProject_cls_object.IsInitialized))
			CEiffelProject_cls_object.Initialize();
		return CEiffelProject_cls_object.QueryInterface (* riid, ppv);
	}
	else if (IsEqualGUID (* rclsid, CLSID_CEiffelCompiler_))
	{
		if (!(CEiffelCompiler_cls_object.IsInitialized))
			CEiffelCompiler_cls_object.Initialize();
		return CEiffelCompiler_cls_object.QueryInterface (* riid, ppv);
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