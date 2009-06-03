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

#ifndef __WEL_PAINTSTRUCT__
#define __WEL_PAINTSTRUCT__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_paintstruct_get_ferase(_ptr_) ((EIF_BOOLEAN) (((PAINTSTRUCT *) _ptr_)->fErase))
#define cwel_paintstruct_get_rcpaint(_ptr_) ((EIF_POINTER) &(((PAINTSTRUCT *) _ptr_)->rcPaint))
// #define cwel_paintstruct_get_hdc(_ptr_) ((EIF_POINTER) (((PAINTSTRUCT *) _ptr_)->hdc))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_PAINTSTRUCT__ */
