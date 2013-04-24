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

#ifndef __WEL_PROCESS_INFORMATION__
#define __WEL_PROCESS_INFORMATION__

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_process_info_set_process_handle(_ptr_, _value_) (((PROCESS_INFORMATION *) _ptr_)->hProcess = (HANDLE) (_value_))
#define cwel_process_info_set_thread_handle(_ptr_, _value_) (((PROCESS_INFORMATION *) _ptr_)->hThread = (HANDLE) (_value_))
#define cwel_process_info_set_process_id(_ptr_, _value_) (((PROCESS_INFORMATION *) _ptr_)->dwProcessId = (DWORD) (_value_))
#define cwel_process_info_set_thread_id(_ptr_, _value_) (((PROCESS_INFORMATION *) _ptr_)->dwThreadId = (DWORD) (_value_))

#define cwel_process_info_get_process_handle(_ptr_) (((PROCESS_INFORMATION *) _ptr_)->hProcess)
#define cwel_process_info_get_thread_handle(_ptr_) (((PROCESS_INFORMATION *) _ptr_)->hThread)
#define cwel_process_info_get_process_id(_ptr_) (((PROCESS_INFORMATION *) _ptr_)->dwProcessId)
#define cwel_process_info_get_thread_id(_ptr_) (((PROCESS_INFORMATION *) _ptr_)->dwThreadId)

#ifdef __cplusplus
}
#endif
#endif /* __WEL_PROCESS_INFORMATION__ */
