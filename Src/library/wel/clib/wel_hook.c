/*****************************************************************************/
/* wel_hook.c                                                                */
/*****************************************************************************/
/* Used to monitor mouse messages for the pick and drop mechanism under      */
/* Windows                                                                   */
/*****************************************************************************/
#include <windows.h>
#include <stdio.h>

//=============================================================================
// Data
//=============================================================================

// Shared Data
#pragma data_seg(".shared")	// Make a new section that we'll make shared
HHOOK hMouseHook = 0;		// HHOOK from SetWindowsHook
HWND hHookWindow = 0;      	// Handle to the window that hook the mouse
#pragma data_seg()			// Back to regular, nonshared data

// Per process data
HINSTANCE hDllInstance = 0;


//=============================================================================
// Code
//=============================================================================

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_unhook_mouse                                                   */
/* ARGS:                                                                     */
/*---------------------------------------------------------------------------*/
/*                                                                           */
/*---------------------------------------------------------------------------*/
void unhook_mouse()
	{
//	FILE *pFile;
//	pFile = fopen("c:\\hook.log","at");
//	fprintf (pFile, "wel_hook.c - Entering unhook_mouse\n");
//	fclose(pFile);

	if (UnhookWindowsHookEx(hMouseHook)==0)
		{
		DWORD nErrorCode = GetLastError();
		DWORD dwMousePos;

		// FIXME: Insert code here to deal with the error */
		dwMousePos = MAKELONG(nErrorCode, nErrorCode);
		//SendMessage(hHookWindow, WM_LBUTTONUP, 0, dwMousePos);

		//pFile = fopen("c:\\hook.log","at");
		//fprintf (pFile, "wel_hook.c - Error in UnhookWindowHookEx, error=\n",nErrorCode);
		//fclose(pFile);
		}
	else
		{
		//SendMessage(hHookWindow, WM_LBUTTONDOWN, 0, 0);
		//pFile = fopen("c:\\hook.log","at");
		//fprintf (pFile, "wel_hook.c - UnhookWindowHookEx succeded\n");
		//fclose(pFile);
		}

	/* Unhook succeeded, we reset the hook handles */
	hMouseHook = NULL;
	hHookWindow = NULL;
	}

/*---------------------------------------------------------------------------*/
/* FUNC: MouseProc                                                           */
/* ARGS: nCode: hook code                                                    */
/*       wParam: message identifier                                          */
/*       lParam: mouse coordinates                                           */
/*---------------------------------------------------------------------------*/
/* The MouseProc hook procedure is an application-defined or library-defined */
/* callback function used with the SetWindowsHookEx function. The system     */
/* calls this function whenever an application calls the GetMessage or       */
/* PeekMessage function and there is a mouse message to be processed.        */
/*                                                                           */
/* The HOOKPROC type defines a pointer to this callback function. MouseProc  */
/* is a placeholder for the application-defined or library-defined function  */
/* name.                                                                     */
/*---------------------------------------------------------------------------*/
LRESULT CALLBACK MouseProc(int nCode, WPARAM wParam, LPARAM lParam)
	{
	UINT Msg = (UINT)wParam;
	DWORD dwMousePos;
	MOUSEHOOKSTRUCT *pInfo = (MOUSEHOOKSTRUCT *) lParam;
	LRESULT retValue = 0;
//	FILE *pFile;
//	pFile = fopen("c:\\hook.log","at");
//	fprintf (pFile, "MOUSEPROC\n\thMouseHook=%u\n\thHookWindow=%u\n",hMouseHook, hHoohWindow);
//	fclose(pFile);

	if (hMouseHook == NULL) 			// We do not know our hook handle
		return 0;

	if (hHookWindow==NULL)
		UnhookWindowsHookEx(hMouseHook);

	// I am a good citizen and I call the other hooks
	retValue = CallNextHookEx(hMouseHook, nCode, wParam, lParam);

	// We should not handle this message because...
	if (hHookWindow == NULL ||		// No window has requested a hook
		nCode < 0					// Windows tell us not to handle this msg
		)
		return 0;


	/* We should handle this mouse message */
	dwMousePos = MAKELONG(pInfo->pt.x, pInfo->pt.y);

	switch (Msg)
		{
		case WM_MOUSEMOVE:
		case WM_LBUTTONDOWN:
		case WM_MBUTTONDOWN:
		case WM_RBUTTONDOWN:
		case WM_LBUTTONUP:
		case WM_MBUTTONUP:
		case WM_RBUTTONUP:
		case WM_LBUTTONDBLCLK:
		case WM_MBUTTONDBLCLK:
		case WM_RBUTTONDBLCLK:
			if (pInfo->hwnd != hHookWindow)
				{
				// The target window is the window that
				// has requested the hook, we do not
				// want to duplicate the mouse message
				SendMessage(hHookWindow, Msg, 0, dwMousePos);
				}
			//return 0;	/* To prevent the system from passing the message */
						/* to the target window procedure. */
			break;

		case WM_NCMOUSEMOVE:
			SendMessage(hHookWindow, WM_MOUSEMOVE, 0, dwMousePos);
			break;
		case WM_NCLBUTTONDOWN:
			SendMessage(hHookWindow, WM_LBUTTONDOWN, 0, dwMousePos);
			break;
		case WM_NCMBUTTONDOWN:
			SendMessage(hHookWindow, WM_MBUTTONDOWN, 0, dwMousePos);
			break;
		case WM_NCRBUTTONDOWN:
			SendMessage(hHookWindow, WM_RBUTTONDOWN, 0, dwMousePos);
			break;
		case WM_NCLBUTTONUP:
			SendMessage(hHookWindow, WM_LBUTTONUP, 0, dwMousePos);
			break;
		case WM_NCMBUTTONUP:
			SendMessage(hHookWindow, WM_MBUTTONUP, 0, dwMousePos);
			break;
		case WM_NCRBUTTONUP:
			SendMessage(hHookWindow, WM_RBUTTONUP, 0, dwMousePos);
			break;
		case WM_NCLBUTTONDBLCLK:
			SendMessage(hHookWindow, WM_LBUTTONDBLCLK, 0, dwMousePos);
			break;
		case WM_NCMBUTTONDBLCLK:
			SendMessage(hHookWindow, WM_MBUTTONDBLCLK, 0, dwMousePos);
			break;
		case WM_NCRBUTTONDBLCLK:
			SendMessage(hHookWindow, WM_RBUTTONDBLCLK, 0, dwMousePos);
			break;
		}
	
//	if (Msg==WM_RBUTTONDBLCLK)
//		{
//		FILE *pFile;
//		pFile = fopen("c:\\hook.log","at");
//		fprintf (pFile, "wel_hook.c - going into unhook_mouse with DBLCLK\n");
//		fclose(pFile);
//		unhook_mouse();
//		}
	
	// We dont care about this message...do nothing.
	return 0;
	}

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_hook_mouse                                                     */
/* ARGS: hHookWindow: Handle of the window registering the hook.             */
/*---------------------------------------------------------------------------*/
/*                                                                           */
/*---------------------------------------------------------------------------*/
void hook_mouse(HWND hWnd)
	{
	if (hWnd==NULL)
		return;	/* Invalid handle to a window, exit */

	/* Hook the mouse messages */
	hMouseHook = SetWindowsHookEx (
 		WH_MOUSE,				// hook type
		(HOOKPROC)MouseProc,	// hook procedure
		hDllInstance,			// handle to application instance
		0						// thread identifier
		);

	/* Set the HookWindow if SetWindowsHookEx succeeded */
	if (hMouseHook!=NULL)
		hHookWindow = hWnd;
	else
		hHookWindow = NULL;
	}

/*---------------------------------------------------------------------------*/
/* FUNC: DllMain                                                             */
/* ARGS: hinstDLL: handle to DLL module                                      */
/*       fdwReason: reason for calling function                              */
/*       lpvReserved: reserved                                               */
/*---------------------------------------------------------------------------*/
/* The DllMain function is an optional method of entry into a dynamic-link   */
/* library (DLL). If the function is used, it is called by the system when   */
/* processes and threads are initialized and terminated, or upon calls to    */
/* the LoadLibrary and FreeLibrary functions.                                */
/*---------------------------------------------------------------------------*/
BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved)
	{
	if (fdwReason == DLL_PROCESS_ATTACH)
		{
		// We don't need thread notifications for what we're doing.  Thus, get
		// rid of them, thereby eliminating some of the overhead of this DLL,
		// which will end up in nearly every GUI process anyhow.
		DisableThreadLibraryCalls(hinstDLL);

		hDllInstance = hinstDLL;
		}

	return TRUE;
	}
