/*
 * WEL_PROCESS_INFORMATION.H
 */

#ifndef __WEL_PROCESS_INFORMATION__
#define __WEL_PROCESS_INFORMATION__

#define cwel_process_info_set_process_handle(_ptr_, _value_) (((PROCESS_INFORMATION *) _ptr_)->hProcess = (HANDLE) (_value_))
#define cwel_process_info_set_thread_handle(_ptr_, _value_) (((PROCESS_INFORMATION *) _ptr_)->hThread = (HANDLE) (_value_))
#define cwel_process_info_set_process_id(_ptr_, _value_) (((PROCESS_INFORMATION *) _ptr_)->dwProcessId = (DWORD) (_value_))
#define cwel_process_info_set_thread_id(_ptr_, _value_) (((PROCESS_INFORMATION *) _ptr_)->dwThreadId = (DWORD) (_value_))

#define cwel_process_info_get_process_handle(_ptr_) ((EIF_INTEGER)(((PROCESS_INFORMATION *) _ptr_)->hProcess))
#define cwel_process_info_get_thread_handle(_ptr_) ((EIF_INTEGER)(((PROCESS_INFORMATION *) _ptr_)->hThread))
#define cwel_process_info_get_process_id(_ptr_) ((EIF_INTEGER)(((PROCESS_INFORMATION *) _ptr_)->dwProcessId))
#define cwel_process_info_get_thread_id(_ptr_) ((EIF_INTEGER)(((PROCESS_INFORMATION *) _ptr_)->dwThreadId))

#endif /* __WEL_PROCESS_INFORMATION__ */

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