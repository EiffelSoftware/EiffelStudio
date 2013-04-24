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

#ifndef __WEL_LOGBRUSH__
#define __WEL_LOGBRUSH__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_logbrush_set_style(_ptr_, _value_) (((LOGBRUSH *) _ptr_)->lbStyle = (UINT) (_value_))
#define cwel_logbrush_set_color(_ptr_, _value_) (((LOGBRUSH *) _ptr_)->lbColor = (COLORREF) (_value_))
#define cwel_logbrush_set_hatch(_ptr_, _value_) (((LOGBRUSH *) _ptr_)->lbHatch = (int) (_value_))

#define cwel_logbrush_get_style(_ptr_) ((EIF_INTEGER) (((LOGBRUSH *) _ptr_)->lbStyle))
#define cwel_logbrush_get_color(_ptr_) ((EIF_INTEGER) (((LOGBRUSH *) _ptr_)->lbColor))
#define cwel_logbrush_get_hatch(_ptr_) ((EIF_INTEGER) (((LOGBRUSH *) _ptr_)->lbHatch))


#ifdef __cplusplus
}
#endif

#endif /* __WEL_LOGBRUSH__ */
