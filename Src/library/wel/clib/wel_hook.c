/*****************************************************************************/
/* wel_hook.c                                                                */
/*****************************************************************************/
/* Used to monitor mouse messages for the pick and drop mechanism under      */
/* Windows. Source code for wel_hook.dll                                     */
/*****************************************************************************/
#include <windows.h>
#include <stdio.h>

//=============================================================================
// Data
//=============================================================================

// Shared Data
#pragma data_seg(".shared")	// Make a new section that we'll make shared
HHOOK hMouseHook = NULL;	// HHOOK from SetWindowsHook
HWND hHookWindow = NULL;	// Handle to the window that hook the mouse
#pragma data_seg()			// Back to regular, nonshared data

// Per process data
HINSTANCE hDllInstance = 0;


//=============================================================================
// Code
//=============================================================================

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
BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved) {
	if (fdwReason == DLL_PROCESS_ATTACH) {
			// We don't need thread notifications for what we're doing.  Thus, get
			// rid of them, thereby eliminating some of the overhead of this DLL,
			// which will end up in nearly every GUI process anyhow.
		DisableThreadLibraryCalls(hinstDLL);

		hDllInstance = hinstDLL;
	}

	return TRUE;
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
__declspec(dllexport) LRESULT WINAPI MouseProc(int nCode, WPARAM wParam, LPARAM lParam) {
	UINT Msg = (UINT)wParam;
	DWORD dwMousePos;
	MOUSEHOOKSTRUCT *pInfo = (MOUSEHOOKSTRUCT *) lParam;
	RECT rect;

	if (nCode < 0)					// Windows tell us not to handle this msg
		return CallNextHookEx(hMouseHook, nCode, wParam, lParam);

	if (hMouseHook == NULL) 				// We do not know our hook handle
		return 0;

	if (hHookWindow == NULL)					// Something wrong happened...
		UnhookWindowsHookEx(hMouseHook);	// We don't have any window target
											// So we stop the hook.

	if (hHookWindow == NULL)		// No window has requested a hook
		return CallNextHookEx(hMouseHook, nCode, wParam, lParam);


	//===================================
	// We will handle this mouse message
	//===================================

	// Retrieve target window coordinates & compute the coordinates relative
	// to the target window.
	GetWindowRect(hHookWindow, &rect);
	dwMousePos = MAKELONG(pInfo->pt.x - rect.left, pInfo->pt.y - rect.top);

	// Transform & redirect the mouse message to the target window.
	switch (Msg) {
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
		case WM_NCHITTEST:
			if (pInfo->hwnd != hHookWindow) {
				/* The current window is not the target
				 * window, so we prevent the system to
				 * forward the message to the current window
				 * (return 1), and we send an identical
				 * message to the target window. */
				SendMessage(hHookWindow, Msg, 0, dwMousePos);
				return 1;
			}
			/* The current window IS the window that
			 * has requested the hook, we do not want
			 * to duplicate the mouse message So we
			 * ignore this message & tell the system
			 * to pass it to the target window. */
			break;

		case WM_NCMOUSEMOVE:
			SendMessage(hHookWindow, WM_MOUSEMOVE, 0, dwMousePos);
			return 1;
		case WM_NCLBUTTONDOWN:
			SendMessage(hHookWindow, WM_LBUTTONDOWN, 0, dwMousePos);
			return 1;
		case WM_NCMBUTTONDOWN:
			SendMessage(hHookWindow, WM_MBUTTONDOWN, 0, dwMousePos);
			return 1;
		case WM_NCRBUTTONDOWN:
			SendMessage(hHookWindow, WM_RBUTTONDOWN, 0, dwMousePos);
			return 1;
		case WM_NCLBUTTONUP:
			SendMessage(hHookWindow, WM_LBUTTONUP, 0, dwMousePos);
			return 1;
		case WM_NCMBUTTONUP:
			SendMessage(hHookWindow, WM_MBUTTONUP, 0, dwMousePos);
			return 1;
		case WM_NCRBUTTONUP:
			SendMessage(hHookWindow, WM_RBUTTONUP, 0, dwMousePos);
			return 1;
		case WM_NCLBUTTONDBLCLK:
			SendMessage(hHookWindow, WM_LBUTTONDBLCLK, 0, dwMousePos);
			return 1;
		case WM_NCMBUTTONDBLCLK:
			SendMessage(hHookWindow, WM_MBUTTONDBLCLK, 0, dwMousePos);
			return 1;
		case WM_NCRBUTTONDBLCLK:
			SendMessage(hHookWindow, WM_RBUTTONDBLCLK, 0, dwMousePos);
			return 1;
	}
	
	// We don't care about this message so we pass it to other processes.
	return CallNextHookEx(hMouseHook, nCode, wParam, lParam);
}

/*---------------------------------------------------------------------------*/
/* FUNC: get_hook_window                                                     */
/*---------------------------------------------------------------------------*/
/* Returns the handle of the window that has started the hook, NULL if no    */
/* hook is currently under process                                           */
/*---------------------------------------------------------------------------*/
__declspec(dllexport) HWND WINAPI get_hook_window() {
	return hHookWindow;
}

/*---------------------------------------------------------------------------*/
/* FUNC: hook_mouse                                                          */
/* ARGS: hHookWindow: Handle of the window registering the hook.             */
/*---------------------------------------------------------------------------*/
/* Hok mouse messages. Call this function when you want to monitor all mouse */
/* messages                                                                  */
/*                                                                           */
/* Returns FALSE (0) when something wrong happened, TRUE (1) otherwise       */
/*---------------------------------------------------------------------------*/
__declspec(dllexport) int WINAPI hook_mouse(HWND hWnd) {
	HOOKPROC hkprcMouse;

	if ((hWnd == NULL) || (!IsWindow(hWnd))) {
		MessageBox (NULL, "Invalid hWnd", "wel_hook.dll error", MB_OK | MB_ICONSTOP);
		return 0;	// Invalid handle to a window, exit.
	}

	hkprcMouse = (HOOKPROC)GetProcAddress(hDllInstance, "MouseProc"); 

	// Hook the mouse messages
	hMouseHook = SetWindowsHookEx (
 		WH_MOUSE,				// hook type
		hkprcMouse,				// hook procedure
		hDllInstance,			// handle to application instance
		0						// thread identifier
		);

	// Set the HookWindow if SetWindowsHookEx succeeded
	if (hMouseHook == NULL) {
		hHookWindow = NULL;
		MessageBox (NULL, "hMouseHook==NULL", "wel_hook.dll error", MB_OK | MB_ICONSTOP);
		return 0;
	}
	
	// Everything went fine 
	hHookWindow = hWnd;
	return 1;
}

/*---------------------------------------------------------------------------*/
/* FUNC: unhook_mouse                                                        */
/*---------------------------------------------------------------------------*/
/* Unhook mouse messages. Call this function when you do not want monitor    */
/* mouse messages anymore.                                                   */
/*                                                                           */
/* Returns FALSE (0) when something wrong happened, TRUE (1) otherwise       */
/*---------------------------------------------------------------------------*/
__declspec(dllexport) int WINAPI unhook_mouse() {
	if (UnhookWindowsHookEx(hMouseHook) == 0) {
		// DWORD nErrorCode = GetLastError();
		// FIXME: Insert code here to deal with the error */
		MessageBox (NULL, "Unable to unhook", "wel_hook.dll error", MB_OK | MB_ICONSTOP);
		return 0;
	}

		/* Unhook succeeded, we reset the hook handles */
	hMouseHook = NULL;
	hHookWindow = NULL;
	return 1;
}
