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

#ifndef _WINDOWS_
#	include <windows.h>
#endif

#ifndef _eif_eiffel_h_
#	include "eif_eiffel.h"
#endif

#ifndef _lang_h_
#	include "wel_lang.h"
#endif

#define cwel_pointer_to_integer(_ptr_) ((EIF_INTEGER) _ptr_)
#define cwel_integer_to_pointer(_int_) ((EIF_POINTER) _int_)

#define cwel_temp_dialog_value (0x01)

#define c_set_flag(_flags_, _mask_) ((((EIF_INTEGER) _flags_) | ((EIF_INTEGER) _mask_)))
#define c_clear_flag(_flags_, _mask_) ((((EIF_INTEGER) _flags_) & ((EIF_INTEGER) ~_mask_)))
#define c_flag_set(_flags_, _mask_) ((((((EIF_INTEGER) _flags_) & ((EIF_INTEGER) _mask_)) == (EIF_INTEGER) _mask_ ) ? 1 : 0))

#define c_mouse_message_x(_lparam_) ((short) LOWORD(_lparam_))
#define c_mouse_message_y(_lparam_) ((short) HIWORD(_lparam_))

#define cwel_menu_item_not_found 0xFFFFFFFF

#endif /* __WEL__ */

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
