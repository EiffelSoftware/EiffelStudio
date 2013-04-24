/*
indexing
description: "WEL: library of reusable components for Windows."
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

#ifndef __WEL_STARTUPINFO__
#define __WEL_STARTUPINFO__

#ifdef __cplusplus
extern "C" {
#endif

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

#ifdef __cplusplus
}
#endif

#endif /* __WEL_STARTUPINFO__ */
