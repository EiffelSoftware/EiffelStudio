/*****************************************************************************/
/* Filename: dynload.c  [ associated WEL class: numerous ]                   */
/* Author  : arnaud PICHERY [ aranud@mail.dotcom.fr ]                        */
/*****************************************************************************/
/* Used to check for the existence of a function on the current windows      */
/* platform (some functions are available on Windows 98 but not on 95..)     */
/* Wrapper to dynamically call a function                                    */
/*****************************************************************************/
#include "Windows.h"
#include "shlwapi.h"
#include "eif_portable.h"
#include "wel_dynload.h"

/*---------------------------------------------------------------------------*/
/* Return the address of the specified function. The function is specified   */
/* through its name and the name of the module (.dll) where it is located    */
/*                                                                           */
/* a typical call to this function would be:                                 */
/*  ptr = cwin_get_function_address("kernel.dll", "GetFreeDiskSpaceEx");     */
/*---------------------------------------------------------------------------*/
EIF_POINTER cwin_get_function_address(
		char *pszModuleName,		// Name of the module where the function is
		char *pszFunctionName		// Name of the function to retrieve.
		)
	{
	FARPROC pFunctionAddress;		// Address of the function
	HMODULE hModule;
	
	/* Load the library */
	hModule = LoadLibrary(pszModuleName);
	if (hModule==NULL)
		{
		/* Unable to load the library...we give up */
		return NULL;
		}
		
	/* Retrieve Address of the function */
	pFunctionAddress = GetProcAddress(hModule, pszFunctionName);

	/* Free the library */
	FreeLibrary(hModule);
	
	/* Return the retrieved address (it can be NULL if GetProcAddress returned so) */
	return (EIF_POINTER)(pFunctionAddress);
	}

/*---------------------------------------------------------------------------*/
/* The MaskBlt function combines the color data for the source and           */
/* destination bitmaps using the specified mask and raster operation.        */
/*---------------------------------------------------------------------------*/
void cwin_mask_blt(
		FARPROC pMaskBltFuncAddr,
		HDC hdcDest,     // handle to destination DC
		int nXDest,      // x-coord of destination upper-left corner
		int nYDest,      // y-coord of destination upper-left corner 
		int nWidth,      // width of source and destination
		int nHeight,     // height of source and destination
		HDC hdcSrc,      // handle to source DC
		int nXSrc,       // x-coord of upper-left corner of source
		int nYSrc,       // y-coord of upper-left corner of source
		HBITMAP hbmMask, // handle to monochrome bit mask
		int xMask,       // horizontal offset into mask bitmap
		int yMask,       // vertical offset into mask bitmap
		DWORD dwRop      // raster operation code
		)
	{
	pMaskBltFuncAddr(
		hdcDest, nXDest, nYDest, nWidth, nHeight, 
		hdcSrc, nXSrc, nYSrc,
		hbmMask, xMask, yMask,
		dwRop
		);
	}

/*---------------------------------------------------------------------------*/
/* Return the version number of the specified DLL. The version number is     */
/* packed.                                                                   */
/*                                                                           */
/* a typical call to this function would be:                                 */
/*  if(cwin_get_dll_version("comctl32.dll") >= PACKVERSION(4,71))            */
/*---------------------------------------------------------------------------*/
DWORD cwin_get_dll_version(char *pszDllName)
	{
	HINSTANCE hinstDll;
	DWORD dwVersion = PACKVERSION (4,00); // 4.00 is the lowest value.

	/* Load the dll library into memory in case it was not */
	hinstDll = LoadLibrary(pszDllName);

	if(hinstDll)
		{
		FARPROC pDllGetVersion;

		pDllGetVersion = GetProcAddress(hinstDll, "DllGetVersion");

		/* Because some DLLs may not implement this function, you
		 * must test for it explicitly. Depending on the particular 
		 * DLL, the lack of a DllGetVersion function may
		 * be a useful indicator of the version.
		 */
		if(pDllGetVersion != NULL)
			{
			DLLVERSIONINFO dvi;
			HRESULT hr;

			ZeroMemory(&dvi, sizeof(dvi));
			dvi.cbSize = sizeof(dvi);

			hr = (*pDllGetVersion)(&dvi);

			if(SUCCEEDED(hr))
				{
				dwVersion = PACKVERSION(dvi.dwMajorVersion, dvi.dwMinorVersion);
				}
			}
		else
			{
			// pDllGetVersion not supported --> 4.00 or 4.70
			// Note: 4.70 does not exist for Shell32.dll
			//       Shlwapi.dll was first shiped with IE4 so its version start a 4.71.
			if (stricmp(pszDllName, "comctl32.dll")==0)
				{
				FARPROC pDllImageList_Copy = GetProcAddress (hinstDll, "ImageList_Copy");
				if (pDllImageList_Copy != NULL)
					{
					// ImageList_Copy is present on system, So we have version 4.70
					dwVersion = PACKVERSION (4,70);
					}
				}
			}

		/* Unload the library if it was not loaded before the call to LoadLibrary */
		FreeLibrary(hinstDll);
		}
	return dwVersion;
	}

/*---------------------------------------------------------------------------*/
/* Return the version number of one of the "shell & common controls" dll:    */ 
/*   - shell32.dll                                                           */
/*   - commctrl32.dll                                                        */
/*   - shlwapi.dll                                                           */
/* The version number is packed.                                             */
/*                                                                           */
/* a typical call to this function would be:                                 */
/*  if(cwin_get_shellcomctrl_dll_version("comctl32.dll")>=PACKVERSION(4,71)) */
/*---------------------------------------------------------------------------*/
DWORD cwin_get_shellcomctrl_dll_version(char *pszDllName)
	{
	DWORD dwVersion = cwin_get_dll_version(pszDllName);
	
	if (dwVersion > 0)
		return dwVersion;
	else
		{
		// DllGetVersion is not supported --> Win95 (4.00) or Win95+IE4 (4.70)
		void* pInitCommonCtrlEx_addr = cwin_get_function_address("Comctl32.dll", "InitCommonControlsEx");
		if (pInitCommonCtrlEx_addr == NULL)
			{
			// InitCommonCtrlEx do NOT exist on the system --> Win95 alone
			return PACKVERSION(4,0);
			}
		else
			{
			// InitCommonCtrlEx do exist on the system --> Win95 + IE3
			return PACKVERSION(4,70);
			}
		}
	}

/*---------------------------------------------------------------------------*/
/* Return the version number of the "shell32.dll" DLL. The version number is */
/* packed.                                                                   */
/*                                                                           */
/* a typical call to this function would be:                                 */
/*  if(cwin_get_shell32dll_version() >= PACKVERSION(4,71))                   */
/*---------------------------------------------------------------------------*/
DWORD cwin_get_shell32dll_version(void)
	{
	return cwin_get_shellcomctrl_dll_version("Shell32.dll");
	}

/*---------------------------------------------------------------------------*/
/* Return the version number of the "Comctl32.dll" DLL. The version number   */
/* is packed.                                                                */
/*                                                                           */
/* a typical call to this function would be:                                 */
/*  if(cwin_get_comctl32dll_version() >= PACKVERSION(4,71))                  */
/*---------------------------------------------------------------------------*/
DWORD cwin_get_comctl32dll_version(void)
	{
	return cwin_get_shellcomctrl_dll_version("Comctl32.dll");
	}

/*---------------------------------------------------------------------------*/
/* Return the version number of the "Shlwapi.dll" DLL. The version number is */
/* packed.                                                                   */
/*                                                                           */
/* a typical call to this function would be:                                 */
/*  if(cwin_get_shlwapidll_version() >= PACKVERSION(4,71))                   */
/*---------------------------------------------------------------------------*/
DWORD cwin_get_shlwapidll_version(void)
	{
	return cwin_get_shellcomctrl_dll_version("Shlwapi.dll");
	}
