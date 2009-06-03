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

#ifndef __WEL_LOGPEN__
#define __WEL_LOGPEN__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_logpen_set_style(_ptr_, _value_) (((LOGPEN *) _ptr_)->lopnStyle = (UINT) (_value_))
#define cwel_logpen_set_width(_ptr_, _value_) (((LOGPEN *) _ptr_)->lopnWidth.x = (int) (_value_))
#define cwel_logpen_set_y(_ptr_, _value_) (((LOGPEN *) _ptr_)->lopnWidth.y = (int) (_value_))
#define cwel_logpen_set_color(_ptr_, _value_) (((LOGPEN *) _ptr_)->lopnColor = (COLORREF) (_value_))

#define cwel_logpen_get_style(_ptr_) ((EIF_INTEGER) (((LOGPEN *) _ptr_)->lopnStyle))
#define cwel_logpen_get_width(_ptr_) ((EIF_INTEGER) (((LOGPEN *) _ptr_)->lopnWidth.x))
#define cwel_logpen_get_color(_ptr_) ((EIF_INTEGER) (((LOGPEN *) _ptr_)->lopnColor))


#ifdef __cplusplus
}
#endif

#endif /* __WEL_LOGPEN__ */
