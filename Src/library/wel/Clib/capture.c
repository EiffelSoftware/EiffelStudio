/*
indexing
	description: "[
		Functions used to implement capture beyond the boundaries of the process.
		Because the hook processing WH_MOUSE_LL is done in the thread that installed it,
		it means that by default it would be in the GUI thread. That would slow down
		mouse movement if the application responds to move events (such as drawing the
		line for pick and drop under Vista/Windows 7 or resizing floating tool in the
		docking library).
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
static HANDLE hThread = NULL;
static HANDLE thr_start_event = NULL;
static HWND thr_window = NULL;
static DWORD dwThreadId = 0;
static DWORD hook_process_id;

/* This variable is only accessed from the spawned thread. */
static HHOOK mouse_hook;
static DWORD tick_count;

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
						if (l_process_id != hook_process_id) {
								/* The `hover' window does not belong to our process, so we simply
								 * forward the message to `hook_window'. */
							DWORD dwMousePos;
							RECT rect;
								/* Retrieve target window coordinates & compute the coordinates relative
								 * to the target window. */
							GetWindowRect(hook_window, &rect);
							dwMousePos = MAKELONG(pInfo->pt.x - rect.left, pInfo->pt.y - rect.top);
								/* Do not send all messages when DWM is active as if your
								 * code involves drawing like in pick and drop it is quite slow to draw
								 * directly on the desktop. */
							if (Msg == WM_MOUSEMOVE) {
								DWORD new_tick_count = GetTickCount();
								if (abs(new_tick_count - tick_count) > 100) {
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
		 * on Windows platform. */
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
			/* Small trick to create the event queue for the current thread. */
		PeekMessage(&Msg, NULL, WM_USER, WM_USER, PM_NOREMOVE);

			/* Create a Window used to receive the messages. If the window
			 * cannot be created we simply do as if there was no hook. */
		thr_window = CreateWindow(L"STATIC", L"WEL capture", 0,
			0, 0, 0, 0,
			HWND_MESSAGE,
			NULL,
			NULL,
			NULL);

			/* We signal that now we can go ahead and terminate `cwel_capture'. */
		SetEvent(thr_start_event);

		if (thr_window) {
				/* Event loop. */
			while (GetMessage(&Msg, NULL, 0, 0) > 0) {
				TranslateMessage(&Msg);
				DispatchMessage(&Msg);
			}
			DestroyWindow(thr_window);
			thr_window = NULL;
		}

		UnhookWindowsHookEx(mouse_hook);
		mouse_hook = NULL;
	} else {
			/* We signal that now we can go ahead and terminate `cwel_capture'. */
		SetEvent(thr_start_event);
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
		if (hook_window) {
				/* The Caller did not yet call `cwel_release_capture', we do it for him. */
			cwel_release_capture();
		}

		hook_window = hWnd;
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

			/* Because we need to wait for the thread to start, we create an event, and the spawned
			 * thread will signal it to let us know that the Windows event queue has been properly
			 * initialized so that we can safely synchronize with the thread in `cwel_release_capture'.
			 */
		thr_start_event = CreateEvent(NULL, FALSE, FALSE, NULL);
		hThread = NULL;
		thr_window = NULL;
			/* If we can create the Event then we can go ahead and try the thread creation, otherwise
			 * we do nothing and there is no capture outside our window. */
		if (thr_start_event) {
				/* If the creation of the thread fails, then that's ok, we will simply not get the benefit
				 * of the capture outside our window. */
			hThread = CreateThread (
				NULL,			/* default security attributes */
				0,				/* use default stack size */
				cwel_main_for_capture,	/* thread function */
				NULL,			/* argument to thread function */
				0,				/* use default creation flags */
				&dwThreadId);	/* returns the thread identifier */

			if (hThread) {
					/* Thread was successfully created, we wait for the `thr_start_event' to be signaled. */
				WaitForSingleObject(thr_start_event, INFINITE);
			}
				/* Regardless of the event being signaled above or of the thread
				 * creation failing, we need to clean the allocated resource for `thr_start_event'. */
			CloseHandle(thr_start_event);
			thr_start_event = NULL;
		}
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
		BOOL post_result;
			/* If the window was created, then we can post the WM_QUIT message. If no window exists
			 * then there was some issue in the thread and we are sure that the thread as exited immediately
			 * and thus calling `WaitForSingleObject' should return immediately. */
		if (thr_window) {
			post_result = PostMessage (thr_window, WM_QUIT, (WPARAM) 0, (LPARAM) 0);
				/* No need to destroy `thr_window' it is done in the thread. */
		}
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
