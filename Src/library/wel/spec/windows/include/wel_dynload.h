/*****************************************************************************/
/* wel_dynload.h  [ associated WEL class: numerous ]                         */
/*****************************************************************************/
/* Used to check for the existence of a function on the current windows      */
/* platform (some functions are available on Windows 98 but not on 95..)     */
/* Wrapper to dynamically call a function                                    */
/*****************************************************************************/

#ifndef __WEL_DYNLOAD_H_
#define __WEL_DYNLOAD_H_

#include "Windows.h"
#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

/*---------------------------------------------------------------------------*/
/* Pack the minor and the major version number into a single DWORD           */
/*---------------------------------------------------------------------------*/
#define PACKVERSION(major,minor) MAKELONG(minor,major)

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
		);


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
		);

/*---------------------------------------------------------------------------*/
/* Return the version number of the specified DLL. The version number is     */
/* packed.                                                                   */
/*                                                                           */
/* a typical call to this function would be:                                 */
/*  if(cwin_get_dll_version("comctl32.dll") >= PACKVERSION(4,71))            */
/*---------------------------------------------------------------------------*/
DWORD cwin_get_dll_version(char *pszDllName);

/*---------------------------------------------------------------------------*/
/* Return the version number of the "shell32.dll" DLL. The version number is */
/* packed.                                                                   */
/*                                                                           */
/* a typical call to this function would be:                                 */
/*  if(cwin_get_shell32dll_version() >= PACKVERSION(4,71))                   */
/*---------------------------------------------------------------------------*/
DWORD cwin_get_shell32dll_version(void);

/*---------------------------------------------------------------------------*/
/* Return the version number of the "Comctl32.dll" DLL. The version number   */
/* is packed.                                                                */
/*                                                                           */
/* a typical call to this function would be:                                 */
/*  if(cwin_get_comctl32dll_version() >= PACKVERSION(4,71))                  */
/*---------------------------------------------------------------------------*/
DWORD cwin_get_comctl32dll_version(void);

/*---------------------------------------------------------------------------*/
/* Return the version number of the "Shlwapi.dll" DLL. The version number is */
/* packed.                                                                   */
/*                                                                           */
/* a typical call to this function would be:                                 */
/*  if(cwin_get_shlwapidll_version() >= PACKVERSION(4,71))                   */
/*---------------------------------------------------------------------------*/
DWORD cwin_get_shlwapidll_version(void);

#ifdef __cplusplus
}
#endif

#endif /* __WEL_DYNLOAD_H_ */
