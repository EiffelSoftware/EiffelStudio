#include "registration_utility.h"

EIF_REFERENCE c_net_directory ()
	/*-----------------------------------------------------------
	Retrieve path to .NET directory
	(c:\windows\microsoft.net\frameworksdk\vx.x.xx)
	-----------------------------------------------------------*/
{
	typedef BOOL (WINAPI *LPFNGETCORSYSTEMDIRECTORY)(LPWSTR, DWORD, DWORD*); // function pointer
	WCHAR wszBuf[MAX_PATH];
	CHAR szBuf[MAX_PATH];
	DWORD dwLen;
	LPFNGETCORSYSTEMDIRECTORY lpfnGetCORSysDir;
	HINSTANCE hInstMSCoree = NULL;
	hInstMSCoree = LoadLibrary("mscoree.dll");
	if (hInstMSCoree)
	{
		// Get ProcAddress of the GetCORSystemDirectory() function
		lpfnGetCORSysDir = (LPFNGETCORSYSTEMDIRECTORY) GetProcAddress(hInstMSCoree, "GetCORSystemDirectory");
		if (lpfnGetCORSysDir)
		{
			if (SUCCEEDED((*lpfnGetCORSysDir)(wszBuf, MAX_PATH, &dwLen)))
			{
				wctomb (szBuf, *wszBuf);
				return RTMS (szBuf);
			}
		}
	}
	return RTMS ("");
}
