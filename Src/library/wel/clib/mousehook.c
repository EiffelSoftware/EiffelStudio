/*****************************************************************************/
/* mousehook.c                                                               */
/*****************************************************************************/
/* Used to monitor mouse messages for the pick and drop mechanism under      */
/* Windows                                                                   */
/*****************************************************************************/
#include "eif_eiffel.h"
#include <windows.h>
#include "wel_mousehook.h"
#include <stdio.h>

extern int debug_mode;			/* Status of debugger */
static int saved_debug_mode;	/* Saved status of debugger when enabling
								   heavy_capture */

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_get_hook_window                                                */
/*---------------------------------------------------------------------------*/
/* Returns the handle of the window that has started the hook, NULL if no    */
/* hook is currently under process                                           */
/*---------------------------------------------------------------------------*/
HWND cwel_get_hook_window()
	{
	HINSTANCE hLibrary;
	FARPROC get_hook_window_func;
	
	// Get the module of the library WITHOUT loading it.
	hLibrary = GetModuleHandle("wel_hook.dll");

	// The library is not loaded, so no hook is defined..
	if (hLibrary == NULL)
		return NULL;
	
	get_hook_window_func = GetProcAddress(hLibrary, "get_hook_window");
	if (get_hook_window_func == NULL)
		{
		MessageBox(NULL, "An error occurred while trying to access the function `get_hook_window'\nfrom the DLL `wel_hook.dll'.\nCheck that you have the latest copy of the DLL.", "Unable to access a DLL..", MB_OK | MB_ICONERROR | MB_TOPMOST);
		return NULL; // Unable to locate the function inside the DLL
		}

	// Everything went ok, execute the function and return the value returned
	// by the function.
	return ((FUNCTION_CAST_TYPE(HWND, __stdcall, ()) get_hook_window_func)());
	}

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_hook_mouse                                                     */
/* ARGS: hHookWindow: Handle of the window registering the hook.             */
/*---------------------------------------------------------------------------*/
/* Capture all mouse messages and redirect them to `hWnd'.                   */
/* Return TRUE if everything went fine, FALSE otherwise. If `wel_hook.dll'   */
/* cannot be loaded an error box is displayed                                */
/*---------------------------------------------------------------------------*/
EIF_BOOLEAN cwel_hook_mouse(HWND hWnd)
	{
	HINSTANCE hLibrary;
	FARPROC hook_mouse_func;
	BOOL bRes;
	
		/* Disable debugger otherwise everything is blocked */
	saved_debug_mode = debug_mode;
	debug_mode = 0;
	
	hLibrary = LoadLibrary("wel_hook.dll");
	if (hLibrary == NULL)
		{
		// Display an error box
		MessageBox(hWnd, "An error occurred while loading the file 'wel_hook.dll'\nCheck that it can be found in your path or your working directory", "Unable to load a DLL..", MB_OK | MB_ICONERROR | MB_TOPMOST);
		return FALSE;
		}

	hook_mouse_func = GetProcAddress(hLibrary, "hook_mouse");
	if (hook_mouse_func == NULL)
		return FALSE;		// Unable to locate the function inside the DLL
	
	// Everything went ok, execute the function and return the value returned
	// by the function.
	bRes = (EIF_BOOLEAN) ((FUNCTION_CAST_TYPE(int, __stdcall, (HWND)) hook_mouse_func)(hWnd));
	return bRes;
	}

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_unhook_mouse                                                   */
/* ARGS:                                                                     */
/*---------------------------------------------------------------------------*/
/* Stop capturing all mouse messages                                         */
/* Return TRUE if everything went fine, FALSE otherwise.                     */
/*---------------------------------------------------------------------------*/
EIF_BOOLEAN cwel_unhook_mouse()
	{
	HINSTANCE hLibrary;
	FARPROC unhook_mouse_func;
	EIF_BOOLEAN bRes;
	
		/* Restore status of debugger */
	debug_mode = saved_debug_mode;

	// Get the module of the library WITHOUT loading it.
	hLibrary = GetModuleHandle("wel_hook.dll");

	// The library is not loaded, so no hook is defined.. do nothing
	// and return an error
	if (hLibrary == NULL)
		return FALSE;
	
	unhook_mouse_func = GetProcAddress(hLibrary, "unhook_mouse");
	if (unhook_mouse_func == NULL)
		return FALSE;		// Unable to locate the function inside the DLL

	// Everything went ok, execute the function and return the value returned
	// by the function.
	bRes = (EIF_BOOLEAN) ((FUNCTION_CAST_TYPE(int, __stdcall, ()) unhook_mouse_func)());
	FreeLibrary(hLibrary);
	return bRes;
	}
