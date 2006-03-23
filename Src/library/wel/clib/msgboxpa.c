/*
 * MSGBOXPA.C
 *
 * Function used by the class WEL_MSGBOXPARAMS.
 *
 */

#ifndef __WEL__
#	include <wel.h>
#endif

#ifndef __WEL_MSGBOPARAMS__
#	include <msgboxpa.h>
#endif

void cwel_msgboxparams_set (LPMSGBOXPARAMS item, HWND wd, HINSTANCE hinst, LPCTSTR txt, LPCTSTR ttl, DWORD s, LPCTSTR ico, DWORD langid)
{	/*
	 * fill item with arguments
	 * the fields dwContextHelpId and lpfnMsgBoxCallback are set to NULL
	 * (help event is systematically a 'WM_HELP' message sent to
	 * the owner of the message box).
	 */

	item -> cbSize = sizeof (MSGBOXPARAMS);
	item -> hwndOwner = wd;
	item -> hInstance = hinst;
	item -> lpszText = txt;
	item -> lpszCaption = ttl;
	item -> dwStyle = s;
	item -> lpszIcon = ico;
	item -> dwContextHelpId = (DWORD_PTR) NULL;
	item -> lpfnMsgBoxCallback = NULL;
	item -> dwLanguageId = langid;
}

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
