/*
 * CHOOSEFOLDER.C
 *
 * Functions used by the class WEL_CHOOSE_FOLDER.
 *
 */

/* It is ok to define _WIN32_DCOM because we support Win98 and above.
 * Reminder: _WIN32_DCOM is available on Win98 and above.
 */
#define _WIN32_DCOM

#include "wel_globals.h"
#include <shlobj.h>

int CALLBACK cwel_browse_callback_proc(HWND hwnd, UINT uMsg, LPARAM lParam, LPARAM lpData)
{
		/* Select the initial folder upon initialization (lpData contains the initial folder) */
	if (uMsg == BFFM_INITIALIZED)
		SendMessage(hwnd, BFFM_SETSELECTION, TRUE, lpData);

	return 0;
}

struct EIF_BROWSE {
	LPBROWSEINFO info;
	LPTSTR name;
};

rt_private DWORD WINAPI c_browse_for_folder (LPVOID param)
	/* Main routine of thread that will create BrowseForFolder dialog. */
{
	LPITEMIDLIST id_list;
	struct EIF_BROWSE *browse = (struct EIF_BROWSE *) param;
	HRESULT hr;
	LPMALLOC imalloc;

		/* First initialize COM with single threaded appartment. */
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);

	id_list = SHBrowseForFolder (browse->info);

	if (id_list) {
		if (SHGetPathFromIDList (id_list, browse->name)) {
			hr = SHGetMalloc (&imalloc);
			if (hr == NOERROR) {
				imalloc->lpVtbl->Free (imalloc, id_list);
			}
		}
	}

		/* No need for COM anymore */
	CoUninitialize();
	ExitThread(0);

	return 0; 
}

void cwel_sh_browse_for_folder (LPBROWSEINFO info, LPTSTR name)
	/* Create new thread in which dialog will be shown with proper appartment setting
	 * for COM. See documentation for SHBrowseForFolder. */
{
	DWORD dwThreadId;
	struct EIF_BROWSE browse_info;
	HANDLE hThread; 
	DWORD res;
	MSG msg;

	browse_info.info = info;
	browse_info.name = name;

	hThread = CreateThread( 
		NULL,			/* default security attributes */
		0,				/* use default stack size */
		c_browse_for_folder,		/* thread function */
		&browse_info,	/* argument to thread function */
		0,				/* use default creation flags */
		&dwThreadId);	/* returns the thread identifier */
 
		/* Check the return value for success. */
	if (hThread) {
			/* The following code enable us to wait until user close
			 * BrowseForFolder dialog, without freezing the graphical
			 * interface of the current application. So each time there
			 * is an event, we process the messages and wait again
			 * until dialog is closed.
			 */
		res = MsgWaitForMultipleObjects(1, &hThread, FALSE, INFINITE,
			QS_ALLEVENTS | QS_ALLINPUT | QS_ALLPOSTMESSAGE);
		while ((res) && (res != WAIT_FAILED)) {
			res = MsgWaitForMultipleObjects(1, &hThread, FALSE, INFINITE,
				QS_ALLEVENTS | QS_ALLINPUT | QS_ALLPOSTMESSAGE);
			if ((res != WAIT_FAILED) && (res == WAIT_OBJECT_0 + 1)) {
					/* If there are some events, let's process them while the
					 * while the browse dialog is still open. */
				while (PeekMessage (&msg, NULL, 0, 0, PM_REMOVE)) {
					TranslateMessage (&msg);
					DispatchMessage (&msg);
				}
			}
		}
			/* No need for the Handle anymore. */
		CloseHandle(hThread);
	}
}

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
