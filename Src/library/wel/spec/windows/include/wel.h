/*
 * WEL.H
 */

#ifndef __WEL__
#define __WEL__

#ifdef _WIN32
#	ifndef WIN32
#		define WIN32
#	endif
#endif

#ifndef _INC_WINDOWS /* for Win16 */
#	ifndef _WINDOWS_ /* for Win32 */
#		include <windows.h>
#	endif
#endif

#ifndef _eiffel_h_
#	include <eiffel.h>
#endif

#define cwel_pointer_to_integer(_ptr_) ((EIF_POINTER) _ptr_)
#define cwel_integer_to_pointer(_int_) ((EIF_INTEGER) _int_)

#define cwel_temp_dialog_value (0x01)

#define c_set_flag(_flags_, _mask_) ((((EIF_INTEGER) _flags_) | ((EIF_INTEGER) _mask_)))
#define c_clear_flag(_flags_, _mask_) ((((EIF_INTEGER) _flags_) & ((EIF_INTEGER) ~_mask_)))
#define c_flag_set(_flags_, _mask_) (((((EIF_INTEGER) _flags_) & ((EIF_INTEGER) _mask_)) ? 1 : 0))

#ifdef WIN32
#	define cwel_is_win32 TRUE
#	define cwel_menu_item_not_found 0xFFFFFFFF
#	define cwel_set_selection_edit(_hwnd_, _start_, _end_) SendMessage ((HWND) _hwnd_, EM_SETSEL, _start_, _end_)
#else
#	define cwel_is_win32 FALSE
#	define cwel_menu_item_not_found 0xFFFF
#	define OFN_NONETWORKBUTTON 0x0200
#	define OFN_NOLONGNAMES 0x0400
#	define cwel_set_selection_edit(_hwnd_, _start_, _end_) SendMessage ((HWND) _hwnd_, EM_SETSEL, 1, MAKELPARAM(_start_, _end_))
#endif

#endif /* __WEL__ */

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
