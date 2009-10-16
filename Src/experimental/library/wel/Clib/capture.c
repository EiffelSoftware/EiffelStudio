/*
indexing
	description: "[
		Functions used to implement capture beyond the boundaries of the process.
		Because the hook processing WH_MOUSE_LL is done in the thread that installed it,
		it means that by default it would be in the GUI thread. That would slow down
		mouse movement if the application responds to move events (such as drawing the
		line for pick and drop under Vista/Windows 7 and the desktop composition).
		Therefore we install the hook in its own thread.
		]"
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

static HWND hook_window = NULL;
static HWND captured_window = NULL;
static int is_top_dialog = 0;
static HANDLE hThread = NULL;
static DWORD dwThreadId = 0;
static DWORD hook_process_id;
static int is_desktop_composition_active = 0;

/* This variable is only accessed from the spawned thread. */
static HHOOK mouse_hook;
static DWORD tick_count;

/* Find out if desktop windows composition is active or not. This is done dynamically since
 * the DLL does not exist on older version of Windows. */
void compute_desktop_composition () {
	HMODULE dwmapi;
	is_desktop_composition_active = 0;
	dwmapi = LoadLibrary(L"dwmapi.dll");
	if (dwmapi) {
		FARPROC query = GetProcAddress(dwmapi, "DwmIsCompositionEnabled");
		if (query) {
			BOOL val;
			HRESULT hr;
			hr = ((FUNCTION_CAST_TYPE (HRESULT, WINAPI, (BOOL *)) query) (&val));
			is_desktop_composition_active = (hr == S_OK) && (val == TRUE);
		}
		FreeLibrary (dwmapi);
	}
}

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
			/* Something wrong happened... We don't have any window target So we just forward the hook. */
		return CallNextHookEx(mouse_hook, nCode, wParam, lParam);
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
						 * of the same process as `hook_window' or if someone else had already
						 * called `SetCapture'. */
					if (hover) {
						(void) GetWindowThreadProcessId(hover, &l_process_id);
						if (is_top_dialog || (l_process_id != hook_process_id)) {
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
								/* Do not send all messages when DWM is active as if your
								 * code involves drawing like in pick and drop it is quite slow to draw
								 * directly on the desktop. */
							if (is_desktop_composition_active && Msg == WM_MOUSEMOVE) {
								DWORD new_tick_count = GetTickCount();
								if (abs(new_tick_count - tick_count) > 150) {
									tick_count = new_tick_count;
									PostMessage(hook_window, Msg, 0, dwMousePos);
								}
							} else {
								PostMessage(hook_window, Msg, 0, dwMousePos);
							}
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
/* FUNC: cwel_main_for_capture                                               */
/*---------------------------------------------------------------------------*/
/* Main routine for thread that will handle the capture. It installs the hook*/
/* and process events for the thread until it gets the WM_QUIT message where */
/* it removes the hook and exit gracefully.                                  */
/*---------------------------------------------------------------------------*/
rt_private DWORD WINAPI cwel_main_for_capture (LPVOID param)
{
	MSG Msg;

		/* Get Current number of ticks to reduce the number of PostMessage posted when mouse is moving
		 * on Windows platform with the desktop composition effect. */
	tick_count = GetTickCount();

		/* Hook the mouse messages */
	mouse_hook = SetWindowsHookEx (
		WH_MOUSE_LL,			/* hook type */
		cwel_mouse_hook_proc,	/* hook procedure */
		GetModuleHandle(NULL),	/* handle to application instance */
		0	/* thread identifier */
		);

		/* If we succeed in creating the hook, that's good otherwise it means that
		 * capture will be limited to the current application. */
	if (mouse_hook) {
		while (GetMessage(&Msg, NULL, 0, 0) > 0) {
			TranslateMessage(&Msg);
			DispatchMessage(&Msg);
		}

		UnhookWindowsHookEx(mouse_hook);
		mouse_hook = NULL;
	}

	ExitThread(0);
	return 0;
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
		HWND top_window;

			/* Find out if we are on Vista/Windows 7 with desktop composition. */
		compute_desktop_composition();

		if (hook_window) {
				/* The Caller did not yet call `cwel_release_capture', we do it for him. */
			cwel_release_capture();
		}

		hook_window = hWnd;
		top_window = GetAncestor (hWnd, GA_ROOT);
		if (top_window && GetWindowLongPtr(top_window, DWLP_DLGPROC)) {
			is_top_dialog = 1;
		} else {
			is_top_dialog = 0;
		}
		captured_window = SetCapture (hook_window);
			/* The code below is to restore the capture if there was already one. */
		if (captured_window) {
			if (!ReleaseCapture()) {
					/* We cannot release the capture from `captured_window', we gave up
					 * as it simply means that underlying widgets will also get the events. */
				captured_window = NULL;
			} else if (SetCapture (hook_window)) {
					/* This routine should not fail, but it does, it is like above and 
					 * underlying widgets will also get the events. */
			}
		}

		(void) GetWindowThreadProcessId (hook_window, &hook_process_id);

		hThread = CreateThread (
			NULL,			/* default security attributes */
			0,				/* use default stack size */
			cwel_main_for_capture,	/* thread function */
			NULL,			/* argument to thread function */
			0,				/* use default creation flags */
			&dwThreadId);	/* returns the thread identifier */
	}
}

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_release_capture                                                */
/*---------------------------------------------------------------------------*/
/* Stop capturing all mouse messages                                         */
/*---------------------------------------------------------------------------*/
void cwel_release_capture() {
	hook_window = NULL;
		/* If the hook was successful in `cwel_capture' we should release it. */
	if (hThread) {
		PostThreadMessage (dwThreadId, WM_QUIT, (WPARAM) 0, (LPARAM) 0);
		WaitForSingleObject (hThread, INFINITE);
		CloseHandle (hThread);
		hThread = NULL;
	}
		/* This call may fail if we initially failed at the SetCapture call in `cwel_capture' but regardless
		 * we do not need to check for errors. */
	ReleaseCapture();
		/* Restore the initial capture. */
	if (captured_window) {
		SetCapture (captured_window);
		captured_window = NULL;
	}
}
