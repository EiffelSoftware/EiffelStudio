/*
 * WEL_STARTUPINFO.H
 */

#ifndef __WEL_STARTUPINFO__
#define __WEL_STARTUPINFO__

#define cwel_startup_info_set_title(_ptr_, _value_) (((STARTUPINFO *) _ptr_)->lpTitle = (LPTSTR) (_value_))
#define cwel_startup_info_set_x_offset(_ptr_, _value_) (((STARTUPINFO *) _ptr_)->dwX = (DWORD) (_value_))
#define cwel_startup_info_set_y_offset(_ptr_, _value_) (((STARTUPINFO *) _ptr_)->dwY = (DWORD) (_value_))
#define cwel_startup_info_set_width(_ptr_, _value_) (((STARTUPINFO *) _ptr_)->dwXSize = (DWORD) (_value_))
#define cwel_startup_info_set_height(_ptr_, _value_) (((STARTUPINFO *) _ptr_)->dwYSize = (DWORD) (_value_))
#define cwel_startup_info_set_x_char_count(_ptr_, _value_) (((STARTUPINFO *) _ptr_)->dwXCountChars = (DWORD) (_value_))
#define cwel_startup_info_set_y_char_count(_ptr_, _value_) (((STARTUPINFO *) _ptr_)->dwYCountChars = (DWORD) (_value_))
#define cwel_startup_info_set_fill_attributes(_ptr_, _value_) (((STARTUPINFO *) _ptr_)->dwFillAttribute = (DWORD) (_value_))
#define cwel_startup_info_set_flags(_ptr_, _value_) (((STARTUPINFO *) _ptr_)->dwFlags = (DWORD) (_value_))
#define cwel_startup_info_set_show_command(_ptr_, _value_) (((STARTUPINFO *) _ptr_)->wShowWindow = (WORD) (_value_))
#define cwel_startup_info_set_std_input(_ptr_, _value_) (((STARTUPINFO *) _ptr_)->hStdInput = (HANDLE) (_value_))
#define cwel_startup_info_set_std_output(_ptr_, _value_) (((STARTUPINFO *) _ptr_)->hStdOutput = (HANDLE) (_value_))
#define cwel_startup_info_set_std_error(_ptr_, _value_) (((STARTUPINFO *) _ptr_)->hStdError = (HANDLE) (_value_))

#define cwel_startup_info_title(_ptr_) ((((STARTUPINFO *) _ptr_)->lpTitle))
#define cwel_startup_info_x_offset(_ptr_) ((((STARTUPINFO *) _ptr_)->dwX))
#define cwel_startup_info_y_offset(_ptr_) ((((STARTUPINFO *) _ptr_)->dwY))
#define cwel_startup_info_width(_ptr_) ((((STARTUPINFO *) _ptr_)->dwXSize))
#define cwel_startup_info_height(_ptr_) ((((STARTUPINFO *) _ptr_)->dwYSize))
#define cwel_startup_info_x_char_count(_ptr_) ((((STARTUPINFO *) _ptr_)->dwXCountChars))
#define cwel_startup_info_y_char_count(_ptr_) ((((STARTUPINFO *) _ptr_)->dwYCountChars))
#define cwel_startup_info_fill_attribute(_ptr_) ((((STARTUPINFO *) _ptr_)->dwFillAttribute))
#define cwel_startup_info_flags(_ptr_) ((((STARTUPINFO *) _ptr_)->dwFlags))
#define cwel_startup_info_show_command(_ptr_) ((((STARTUPINFO *) _ptr_)->wShowWindow))
#define cwel_startup_info_std_input(_ptr_) ((((STARTUPINFO *) _ptr_)->hStdInput))
#define cwel_startup_info_std_output(_ptr_) ((((STARTUPINFO *) _ptr_)->hStdOutput))
#define cwel_startup_info_std_error(_ptr_) ((((STARTUPINFO *) _ptr_)->hStdError))

#endif /* __WEL_STARTUPINFO__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1999, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/