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
