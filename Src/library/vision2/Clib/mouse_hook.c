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
		hHookWindow = hWnd
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
		DWORD nErrorCode = GetLastError();
		/* FIXME: Insert code here to deal with the error */
		}

	/* Unhook succeeded, we reset the hook handle */
	hMouseHook = NULL;
	}

