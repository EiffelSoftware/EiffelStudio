/*****************************************************************************/
/* mousehook.c                                                               */
/*****************************************************************************/
/* Used to monitor mouse messages for the pick and drop mechanism under      */
/* Windows                                                                   */
/*****************************************************************************/
#include "eif_portable.h"
#include <windows.h>
//#include "wel_hook.h"
#include "wel_mousehook.h"
#include <stdio.h>

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_hook_mouse                                                     */
/* ARGS: hHookWindow: Handle of the window registering the hook.             */
/*---------------------------------------------------------------------------*/
/*                                                                           */
/*---------------------------------------------------------------------------*/
void cwel_hook_mouse(HWND hWnd)
	{
	HINSTANCE hLibrary;
	FARPROC hook_mouse_func;
	
	hLibrary = LoadLibrary("wel_hook.dll");
	if (hLibrary != NULL)
		{
		hook_mouse_func = GetProcAddress(hLibrary, "hook_mouse");
		hook_mouse_func(hWnd);
		}
	}

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_unhook_mouse                                                   */
/* ARGS:                                                                     */
/*---------------------------------------------------------------------------*/
/*                                                                           */
/*---------------------------------------------------------------------------*/
void cwel_unhook_mouse()
	{
	HINSTANCE hLibrary;
	FARPROC unhook_mouse_func;
	FILE *pFile;
	
	pFile = fopen("c:\\hook.log","at");
	fprintf (pFile, "mousehook.c - Executing cwel_unhook_mouse\ngetting DLL");
	fclose(pFile);
	
	hLibrary = GetModuleHandle("wel_hook.dll");

	pFile = fopen("c:\\hook.log","at");
	fprintf (pFile, "mousehook.c - hLibrary = %u\n",hLibrary);
	fclose(pFile);

	if (hLibrary != NULL)
		{
		unhook_mouse_func = GetProcAddress(hLibrary, "unhook_mouse");

		pFile = fopen("c:\\hook.log","at");
		fprintf (pFile, "mousehook.c - unhook_mouse_func = %u\n",unhook_mouse_func);
		fclose(pFile);

		unhook_mouse_func();
		}
	
	pFile = fopen("c:\\hook.log","at");
	fprintf (pFile, "Executed cwel_unhook_mouse\n");
	fclose(pFile);
	}

