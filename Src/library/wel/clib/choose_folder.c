/*
 * CHOOSEFOLDER.C
 *
 * Functions used by the class WEL_CHOOSE_FOLDER.
 *
 */

#include "wel_globals.h"
#include <shlobj.h>

int CALLBACK cwel_browse_callback_proc(HWND hwnd, UINT uMsg, LPARAM lParam, LPARAM lpData)
	{
	// Select the initial folder upon initialization (lpData contains the initial folder)
	if (uMsg == BFFM_INITIALIZED)
		SendMessage(hwnd, BFFM_SETSELECTION, TRUE, lpData);

	return 0;
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
