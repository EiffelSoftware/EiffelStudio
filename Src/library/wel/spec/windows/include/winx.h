/*
 * WINX.H
 */

#ifndef __WEL_WINDOWSX__
#define __WEL_WINDOWSX__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifndef _INC_WINDOWSX
#	include <windowsx.h>
#endif

#ifndef WIN32

	/* WM_COMMAND message */

#	ifndef GET_WM_COMMAND_HWND
#		define GET_WM_COMMAND_HWND(_wp_, _lp_) ((HWND) LOWORD(_lp_))
#	endif
#	ifndef GET_WM_COMMAND_ID
#		define GET_WM_COMMAND_ID(_wp_, _lp_) (_wp_)
#	endif
#	ifndef GET_WM_COMMAND_CMD
#		define GET_WM_COMMAND_CMD(_wp_, _lp_) (HIWORD(_lp_))
#	endif

	/* WM_MENUSELECT message */

#	ifndef GET_WM_MENUSELECT_CMD
#		define GET_WM_MENUSELECT_CMD(_wp_, _lp_) (_wp_)
#	endif
#	ifndef GET_WM_MENUSELECT_FLAGS
#		define GET_WM_MENUSELECT_FLAGS(_wp_, _lp_) (LOWORD(_lp_))
#	endif
#	ifndef GET_WM_MENUSELECT_HMENU
#		define GET_WM_MENUSELECT_HMENU(_wp_, _lp_) (HIWORD(_lp_))
#	endif

	/* WM_VSCROLL message */

#	ifndef GET_WM_VSCROLL_CODE
#		define GET_WM_VSCROLL_CODE(_wp_, _lp_) (_wp_)
#	endif
#	ifndef GET_WM_VSCROLL_POS
#		define GET_WM_VSCROLL_POS(_wp_, _lp_) (LOWORD(_lp_))
#	endif
#	ifndef GET_WM_VSCROLL_HWND
#		define GET_WM_VSCROLL_HWND(_wp_, _lp_) (HIWORD(_lp_))
#	endif

	/* WM_HSCROLL message */

#	ifndef GET_WM_HSCROLL_CODE
#		define GET_WM_HSCROLL_CODE(_wp_, _lp_) (_wp_)
#	endif
#	ifndef GET_WM_HSCROLL_POS
#		define GET_WM_HSCROLL_POS(_wp_, _lp_) (LOWORD(_lp_))
#	endif
#	ifndef GET_WM_HSCROLL_HWND
#		define GET_WM_HSCROLL_HWND(_wp_, _lp_) (HIWORD(_lp_))
#	endif

#endif /* WIN32 */

#endif /* __WEL_WINDOWSX__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
