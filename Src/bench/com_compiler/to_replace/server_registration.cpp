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

DWORD dwRegister_CEiffelCompletionInfo;


CEiffelCompletionInfo_factory CEiffelCompletionInfo_cls_object;

TCHAR file_name[MAX_PATH];

OLECHAR ws_file_name[MAX_PATH];

const REG_DATA reg_entries[] =
{

    {
        __TEXT("CLSID\\{5B4A07BB-BA73-4D00-B0FE-352FC4127B9E}"),
        0,
        __TEXT("CEiffelProject Class"),
        TRUE
    },
    {
        __TEXT("AppID\\{5B4A07BB-BA73-4D00-B0FE-352FC4127B9E}"),
        0,
        "CEiffelProject Application",
        TRUE
    },
    {
        __TEXT("AppID\\ISE"),
        __TEXT("AppID"),
        __TEXT("{5B4A07BB-BA73-4D00-B0FE-352FC4127B9E}"),
        TRUE
    },
    {
        __TEXT("CLSID\\{5B4A07BB-BA73-4D00-B0FE-352FC4127B9E}\\LocalServer32"),
        0,
        file_name,
        TRUE
    },
    {
        __TEXT("CLSID\\{5B4A07BB-BA73-4D00-B0FE-352FC4127B9E}\\LocalServer32"),
        __TEXT("ThreadingModel"),
        __TEXT("Apartment"),
        TRUE
    },
    {
        __TEXT("CLSID\\{5B4A07BB-BA73-4D00-B0FE-352FC4127B9E}"),
        __TEXT("AppID"),
        __TEXT("{5B4A07BB-BA73-4D00-B0FE-352FC4127B9E}"),
        TRUE
    },
    {
        __TEXT("CLSID\\{5B4A07BB-BA73-4D00-B0FE-352FC4127B9E}\\ProgID"),
        0,
        __TEXT("eiffel_compiler.CEiffelProject.1"),
        TRUE
    },
    {
        __TEXT("CLSID\\{5B4A07BB-BA73-4D00-B0FE-352FC4127B9E}\\VersionIndependentProgID"),
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
        __TEXT("{5B4A07BB-BA73-4D00-B0FE-352FC4127B9E}"),
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
        __TEXT("{5B4A07BB-BA73-4D00-B0FE-352FC4127B9E}"),
        TRUE
    },
    {
        __TEXT("eiffel_compiler.CEiffelProject\\CurVer"),
        0,
        __TEXT("eiffel_compiler.CEiffelProject.1"),
        TRUE
    },
    {
        __TEXT("CLSID\\{CA54EDD7-9FDE-4260-9055-9AB7E92122CD}"),
        0,
        __TEXT("CEiffelCompiler Class"),
        TRUE
    },
    {
        __TEXT("AppID\\{CA54EDD7-9FDE-4260-9055-9AB7E92122CD}"),
        0,
        "CEiffelCompiler Application",
        TRUE
    },
    {
        __TEXT("AppID\\ISE"),
        __TEXT("AppID"),
        __TEXT("{CA54EDD7-9FDE-4260-9055-9AB7E92122CD}"),
        TRUE
    },
    {
        __TEXT("CLSID\\{CA54EDD7-9FDE-4260-9055-9AB7E92122CD}\\LocalServer32"),
        0,
        file_name,
        TRUE
    },
    {
        __TEXT("CLSID\\{CA54EDD7-9FDE-4260-9055-9AB7E92122CD}\\LocalServer32"),
        __TEXT("ThreadingModel"),
        __TEXT("Apartment"),
        TRUE
    },
    {
        __TEXT("CLSID\\{CA54EDD7-9FDE-4260-9055-9AB7E92122CD}"),
        __TEXT("AppID"),
        __TEXT("{CA54EDD7-9FDE-4260-9055-9AB7E92122CD}"),
        TRUE
    },
    {
        __TEXT("CLSID\\{CA54EDD7-9FDE-4260-9055-9AB7E92122CD}\\ProgID"),
        0,
        __TEXT("eiffel_compiler.CEiffelCompiler.1"),
        TRUE
    },
    {
        __TEXT("CLSID\\{CA54EDD7-9FDE-4260-9055-9AB7E92122CD}\\VersionIndependentProgID"),
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
        __TEXT("{CA54EDD7-9FDE-4260-9055-9AB7E92122CD}"),
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
        __TEXT("{CA54EDD7-9FDE-4260-9055-9AB7E92122CD}"),
        TRUE
    },
    {
        __TEXT("eiffel_compiler.CEiffelCompiler\\CurVer"),
        0,
        __TEXT("eiffel_compiler.CEiffelCompiler.1"),
        TRUE
    },
    {
        __TEXT("CLSID\\{BCA3E550-3E39-4A44-A034-38F8B422D8DF}"),
        0,
        __TEXT("CEiffelCompletionInfo Class"),
        TRUE
    },
    {
        __TEXT("AppID\\{BCA3E550-3E39-4A44-A034-38F8B422D8DF}"),
        0,
        "CEiffelCompletionInfo Application",
        TRUE
    },
    {
        __TEXT("AppID\\ISE"),
        __TEXT("AppID"),
        __TEXT("{BCA3E550-3E39-4A44-A034-38F8B422D8DF}"),
        TRUE
    },
    {
        __TEXT("CLSID\\{BCA3E550-3E39-4A44-A034-38F8B422D8DF}\\LocalServer32"),
        0,
        file_name,
        TRUE
    },
    {
        __TEXT("CLSID\\{BCA3E550-3E39-4A44-A034-38F8B422D8DF}\\LocalServer32"),
        __TEXT("ThreadingModel"),
        __TEXT("Apartment"),
        TRUE
    },
    {
        __TEXT("CLSID\\{BCA3E550-3E39-4A44-A034-38F8B422D8DF}"),
        __TEXT("AppID"),
        __TEXT("{BCA3E550-3E39-4A44-A034-38F8B422D8DF}"),
        TRUE
    },
    {
        __TEXT("CLSID\\{BCA3E550-3E39-4A44-A034-38F8B422D8DF}\\ProgID"),
        0,
        __TEXT("eiffel_compiler.CEiffelCompletionInfo.1"),
        TRUE
    },
    {
        __TEXT("CLSID\\{BCA3E550-3E39-4A44-A034-38F8B422D8DF}\\VersionIndependentProgID"),
        0,
        __TEXT("eiffel_compiler.CEiffelCompletionInfo"),
        TRUE
    },
    {
        __TEXT("eiffel_compiler.CEiffelCompletionInfo.1"),
        0,
        __TEXT("CEiffelCompletionInfo"),
        TRUE
    },
    {
        __TEXT("eiffel_compiler.CEiffelCompletionInfo.1\\CLSID"),
        0,
        __TEXT("{BCA3E550-3E39-4A44-A034-38F8B422D8DF}"),
        TRUE
    },
    {
        __TEXT("eiffel_compiler.CEiffelCompletionInfo"),
        0,
        __TEXT("CEiffelCompletionInfo"),
        TRUE
    },
    {
        __TEXT("eiffel_compiler.CEiffelCompletionInfo\\CLSID"),
        0,
        __TEXT("{BCA3E550-3E39-4A44-A034-38F8B422D8DF}"),
        TRUE
    },
    {
        __TEXT("eiffel_compiler.CEiffelCompletionInfo\\CurVer"),
        0,
        __TEXT("eiffel_compiler.CEiffelCompletionInfo.1"),
        TRUE
    }
};

const int com_entries_count = sizeof (reg_entries)/sizeof (*reg_entries);

DWORD threadID = GetCurrentThreadId ();



EIF_INTEGER Unregister( const REG_DATA *rgEntries, int cEntries )

    /*-----------------------------------------------------------
    Unregister Server/Component
    -----------------------------------------------------------*/
{
    static const IID LIBID_eiffel_compiler_ = {0x06b5d7c0,0x2c7d,0x4d1c,{0xa9,0x8b,0x45,0x99,0xbd,0xcd,0xfa,0x58}};
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

void LockModule( void )

    /*-----------------------------------------------------------
    Lock module.
    -----------------------------------------------------------*/
{
    CoAddRefServerProcess ();
};

void UnlockModule( void )

    /*-----------------------------------------------------------
    Unlock module.
    -----------------------------------------------------------*/
{
    if (CoReleaseServerProcess () == 0)
        PostThreadMessage (threadID, WM_QUIT, 0, 0);
};

void ccom_register_server_function()

    /*-----------------------------------------------------------
    Register server.
    -----------------------------------------------------------*/
{
    HRESULT hr = CoInitialize (0);
    if (FAILED (hr))
    {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    }
    GetModuleFileName (0, file_name, MAX_PATH);

#ifdef UNICODE
    lstrcpy (ws_file_name, file_name);
#else
    mbstowcs (ws_file_name, file_name, MAX_PATH);
#endif
    Register (reg_entries, com_entries_count);
    CoUninitialize ();
};

void ccom_unregister_server_function()

    /*-----------------------------------------------------------
    Unregister server.
    -----------------------------------------------------------*/
{
    HRESULT hr = CoInitialize (0);

    Unregister (reg_entries, com_entries_count);
    CoUninitialize ();
    return;
};

void ccom_initialize_com_function()

    /*-----------------------------------------------------------
    Initialize server.
    -----------------------------------------------------------*/
{
    HRESULT hr = CoInitialize (0);
        if (FAILED (hr))
    {
        if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
            com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
        com_eraise (f.c_format_message (hr), EN_PROG);
    };
    if (!(CEiffelProject_cls_object.IsInitialized))
            CEiffelProject_cls_object.Initialize();
        hr = CoRegisterClassObject (CLSID_CEiffelProject_, static_cast<IClassFactory*>(&CEiffelProject_cls_object), CLSCTX_LOCAL_SERVER, REGCLS_SINGLEUSE, &dwRegister_CEiffelProject);
    if (FAILED (hr))
    {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    }
    if (!(CEiffelCompiler_cls_object.IsInitialized))
            CEiffelCompiler_cls_object.Initialize();
        hr = CoRegisterClassObject (CLSID_CEiffelCompiler_, static_cast<IClassFactory*>(&CEiffelCompiler_cls_object), CLSCTX_LOCAL_SERVER, REGCLS_SINGLEUSE, &dwRegister_CEiffelCompiler);
    if (FAILED (hr))
    {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    }
    if (!(CEiffelCompletionInfo_cls_object.IsInitialized))
            CEiffelCompletionInfo_cls_object.Initialize();
        hr = CoRegisterClassObject (CLSID_CEiffelCompletionInfo_, static_cast<IClassFactory*>(&CEiffelCompletionInfo_cls_object), CLSCTX_LOCAL_SERVER, REGCLS_SINGLEUSE, &dwRegister_CEiffelCompletionInfo);
    if (FAILED (hr))
    {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    }

};

void ccom_cleanup_com_function()

    /*-----------------------------------------------------------
    Clean up COM.
    -----------------------------------------------------------*/
{
    CoRevokeClassObject (dwRegister_CEiffelProject);

    CoRevokeClassObject (dwRegister_CEiffelCompiler);

    CoRevokeClassObject (dwRegister_CEiffelCompletionInfo);

    CoUninitialize ();
};
#ifdef __cplusplus
}
#endif