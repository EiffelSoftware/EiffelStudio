/*****************************************************************************/
/* mouse_hook.c                                                              */
/*****************************************************************************/
/* Used to monitor mouse messages for the pick and drop mechanism under      */
/* Windows                                                                   */
/*****************************************************************************/
#include "eif_portable.h"
#ifdef EIF_WIN32
#include "windows.h"

static HHOOK	hMouseHook;	/* Current Hook handle if any, Void otherwise */
static HWND		hHookWindow;	/* Handle to the window that hook the mouse */

LRESULT CALLBACK MouseProc(int nCode, WPARAM wParam, LPARAM lParam);

/*---------------------------------------------------------------------------*/
/* FUNC: c_ev_hook_mouse                                                     */
/* ARGS: hHookWindow: Handle of the window registering the hook.             */
/*---------------------------------------------------------------------------*/
/*                                                                           */
/*---------------------------------------------------------------------------*/
void c_ev_hook_mouse(HWND hWnd)
	{
	DWORD dwThreadId = GetCurrentThreadId();


	if (hWnd==NULL)
		return;	/* Invalid handle to a window, exit */

	/* Hook the mouse messages */
	hMouseHook = SetWindowsHookEx (
 		WH_MOUSE,			/* hook type */
		&MouseProc,			/* hook procedure */
		NULL,				/* handle to application instance */
		dwThreadId			/* thread identifier */
		);

	/* Set the HookWindow if SetWindowsHookEx succeeded */
	if (hMouseHook!=NULL)
		hHookWindow = hWnd;
	else
		hHookWindow = NULL;
	}

/*---------------------------------------------------------------------------*/
/* FUNC: c_ev_unhook_mouse                                                   */
/* ARGS:                                                                     */
/*---------------------------------------------------------------------------*/
/*                                                                           */
/*---------------------------------------------------------------------------*/
void c_ev_unhook_mouse()
	{
	hHookWindow = NULL;

	if (UnhookWindowsHookEx(hMouseHook)==0)
		{
		// DWORD nErrorCode = GetLastError();
		// FIXME: Insert code here to deal with the error */
		}

	/* Unhook succeeded, we reset the hook handle */
	hMouseHook = NULL;
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


	/* We should not handle this message */
	if (hMouseHook == NULL)
		return 0;

	/* We should not handle this message */
	if (hHookWindow == NULL ||	/* No window has requested a hook */
		nCode < 0 ||			/* Windows tell us not to handle this msg */
		pInfo->hwnd == hHookWindow	/* The target window is the window that */
									/* has requested the hook, we do not */
									/* want to duplicate the mouse message */
		)
		return CallNextHookEx(hMouseHook, nCode, wParam, lParam);


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
			SendMessage(hHookWindow, Msg, 0, dwMousePos);
			return 1;	/* To prevent the system from passing the message */
						/* to the target window procedure. */
		}

	/* We have not handled the message, so go to next hook function */
	return CallNextHookEx(hMouseHook, nCode, wParam, lParam);
	}

#endif /* EIF_WIN32 */