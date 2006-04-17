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

#ifndef __WEL_WNDCLASS__
#define __WEL_WNDCLASS__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_wnd_class_set_style(_ptr_, _value_) (((WNDCLASS *) _ptr_)->style = (UINT) _value_)
#define cwel_wnd_class_set_wnd_proc(_ptr_, _value_) (((WNDCLASS *) _ptr_)->lpfnWndProc = (WNDPROC) _value_)
#define cwel_wnd_class_set_cls_extra(_ptr_, _value_) (((WNDCLASS *) _ptr_)->cbClsExtra = (int) _value_)
#define cwel_wnd_class_set_wnd_extra(_ptr_, _value_) (((WNDCLASS *) _ptr_)->cbWndExtra = (int) _value_)
#define cwel_wnd_class_set_instance(_ptr_, _value_) (((WNDCLASS *) _ptr_)->hInstance = (HINSTANCE) _value_)
#define cwel_wnd_class_set_icon(_ptr_, _value_) (((WNDCLASS *) _ptr_)->hIcon = (HICON) _value_)
#define cwel_wnd_class_set_cursor(_ptr_, _value_) (((WNDCLASS *) _ptr_)->hCursor = (HCURSOR) _value_)
#define cwel_wnd_class_set_background(_ptr_, _value_) (((WNDCLASS *) _ptr_)->hbrBackground = (HBRUSH) _value_)
#define cwel_wnd_class_set_menu_name(_ptr_, _value_) (((WNDCLASS *) _ptr_)->lpszMenuName = (LPCTSTR) _value_)
#define cwel_wnd_class_set_class_name(_ptr_, _value_) (((WNDCLASS *) _ptr_)->lpszClassName = (LPCTSTR) _value_)

#define cwel_wnd_class_get_style(_ptr_) ((EIF_INTEGER) (((WNDCLASS *) _ptr_)->style))
#define cwel_wnd_class_get_wnd_proc(_ptr_) ((EIF_POINTER) (((WNDCLASS *) _ptr_)->lpfnWndProc))
#define cwel_wnd_class_get_cls_extra(_ptr_) ((EIF_INTEGER) (((WNDCLASS *) _ptr_)->cbClsExtra))
#define cwel_wnd_class_get_wnd_extra(_ptr_) ((EIF_INTEGER) (((WNDCLASS *) _ptr_)->cbWndExtra))
#define cwel_wnd_class_get_instance(_ptr_) ((EIF_POINTER) (((WNDCLASS *) _ptr_)->hInstance))
#define cwel_wnd_class_get_icon(_ptr_) ((EIF_POINTER) (((WNDCLASS *) _ptr_)->hIcon))
#define cwel_wnd_class_get_cursor(_ptr_) ((EIF_POINTER) (((WNDCLASS *) _ptr_)->hCursor))
#define cwel_wnd_class_get_background(_ptr_) ((EIF_POINTER) (((WNDCLASS *) _ptr_)->hbrBackground))
#define cwel_wnd_class_get_menu_name(_ptr_) ((EIF_POINTER) (((WNDCLASS *) _ptr_)->lpszMenuName))
#define cwel_wnd_class_get_class_name(_ptr_) ((EIF_POINTER) (((WNDCLASS *) _ptr_)->lpszClassName))


#ifdef __cplusplus
}
#endif

#endif /* __WEL_WNDCLASS__ */
