/*
 * WINX.H
 */

#ifndef __WEL_WINDOWSX__
#define __WEL_WINDOWSX__

#ifndef __WEL__
#	include "wel.h"
#endif

#ifndef _INC_WINDOWSX
#	include <windowsx.h>
#endif

#define cwin_get_wm_vscroll_pos(wparam, lparam) ( \
		(EIF_INTEGER) (SHORT) GET_WM_VSCROLL_POS (wparam, lparam) \
	)

#define cwin_get_wm_hscroll_pos(wparam, lparam) ( \
		(EIF_INTEGER) (SHORT) GET_WM_HSCROLL_POS (wparam, lparam) \
	)

#endif /* __WEL_WINDOWSX__ */


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
