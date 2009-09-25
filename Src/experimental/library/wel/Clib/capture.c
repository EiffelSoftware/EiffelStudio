/*
indexing
	description: "Functions used to implement capture beyond the boundaries of the process."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*****************************************************************************/
/* capture.c                                                                 */
/*****************************************************************************/
/* Used to monitor mouse messages for the pick and drop mechanism under      */
/* Windows                                                                   */
/*****************************************************************************/
#include "eif_eiffel.h"
#include <windows.h>
#include "wel_capture.h"

static HWND hook_window;
static HHOOK mouse_hook;
static DWORD hook_process_id;

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_mouse_hook_proc                                                */
/* ARGS: nCode: hook code                                                    */
/*       wParam: message identifier                                          */
/*       lParam: mouse coordinates                                           */
/*---------------------------------------------------------------------------*/
/* The cwel_mouse_hook_proc hook procedure is an application-defined or      */
/* library-defined callback function used with the `SetWindowsHookEx'        */
/* function. The system calls this function whenever an application calls    */
/* the GetMessage or PeekMessage function and there is a mouse message to be */
/* processed.                                                                */
/*---------------------------------------------------------------------------*/
LRESULT CALLBACK cwel_mouse_hook_proc(int nCode, WPARAM wParam, LPARAM lParam)
{
	UINT Msg = (UINT)wParam;

		/* Windows tell us not to handle this msg */
	if (nCode < 0) {
		return CallNextHookEx(mouse_hook, nCode, wParam, lParam);
	} else if (hook_window == NULL) {
			/* Something wrong happened... We don't have any window target So we stop the hook. */
		cwel_release_capture();
		return 1;
	} else {
		/* Transform & redirect the mouse message to the target window. */
		switch (Msg) {
			case WM_LBUTTONDOWN:
			case WM_LBUTTONUP:
			case WM_MOUSEMOVE:
			case WM_MOUSEWHEEL:
			case WM_RBUTTONDOWN:
			case WM_RBUTTONUP:
				{
					MSLLHOOKSTRUCT *pInfo = (MSLLHOOKSTRUCT *) lParam;
					HWND hover = WindowFromPoint(pInfo->pt);
					DWORD l_process_id;
						/* We limit our processing only when the mouse is not over a window
						 * of the same process as `hook_window'. */
					if (hover) {
						(void) GetWindowThreadProcessId(hover, &l_process_id);
						if (l_process_id != hook_process_id) {
								/* The current window is not the target
								 * window, so we simply post the message nothing the system to
								 * forward the message to the current window
								 * (return 1), and we send an identical
								 * message to the target window. */
							DWORD dwMousePos;
							RECT rect;
								/* Retrieve target window coordinates & compute the coordinates relative
								 * to the target window. */
							GetWindowRect(hook_window, &rect);
							dwMousePos = MAKELONG(pInfo->pt.x - rect.left, pInfo->pt.y - rect.top);
							PostMessage(hook_window, Msg, 0, dwMousePos);
						}
					}
				}
				break;
			default:
				break;
		}
			/* We don't care about this message so we pass it to other processes. */
		return CallNextHookEx(mouse_hook, nCode, wParam, lParam);
	}
}

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_captured_window                                                */
/*---------------------------------------------------------------------------*/
/* Returns the handle of the window that has started the hook, NULL if no    */
/* hook is currently under process                                           */
/*---------------------------------------------------------------------------*/
HWND cwel_captured_window(void)
{
	return hook_window;
}

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_capture                                                     */
/*---------------------------------------------------------------------------*/
/* Capture all mouse messages and redirect them to `hWnd'.                   */
/*---------------------------------------------------------------------------*/
void cwel_capture (HWND hWnd) {
	if (hWnd && IsWindow(hWnd)) {
		if (hook_window || mouse_hook) {
				/* The Caller did not yet call `cwel_release_capture', we do it for him. */
			cwel_release_capture();
		}

		hook_window = hWnd;
		SetCapture(hook_window);

		(void) GetWindowThreadProcessId (hook_window, &hook_process_id);

			/* Hook the mouse messages */
		mouse_hook = SetWindowsHookEx (
			WH_MOUSE_LL,			/* hook type */
			cwel_mouse_hook_proc,	/* hook procedure */
			eif_hInstance,			/* handle to application instance */
			0						/* thread identifier */
			);
	}
	return EIF_TRUE;
}

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_release_capture                                                */
/*---------------------------------------------------------------------------*/
/* Stop capturing all mouse messages                                         */
/*---------------------------------------------------------------------------*/
void cwel_release_capture() {
	hook_window = NULL;
		/* If the hook was successful in `cwel_capture' we should release it. */
	if (mouse_hook) {
		UnhookWindowsHookEx(mouse_hook);
		mouse_hook = NULL;
	}
	ReleaseCapture();
}
