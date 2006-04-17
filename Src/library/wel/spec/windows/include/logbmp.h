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

#ifndef __WEL_LOGBITMAP__
#define __WEL_LOGBITMAP__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_logbitmap_set_type(_ptr_, _value_) (((BITMAP *) _ptr_)->bmType = (LONG) (_value_))
#define cwel_logbitmap_set_width(_ptr_, _value_) (((BITMAP *) _ptr_)->bmWidth = (LONG) (_value_))
#define cwel_logbitmap_set_height(_ptr_, _value_) (((BITMAP *) _ptr_)->bmHeight = (LONG) (_value_))
#define cwel_logbitmap_set_width_bytes(_ptr_, _value_) (((BITMAP *) _ptr_)->bmWidthBytes = (LONG) (_value_))
#define cwel_logbitmap_set_planes(_ptr_, _value_) (((BITMAP *) _ptr_)->bmPlanes = (WORD) (_value_))
#define cwel_logbitmap_set_bits_pixel(_ptr_, _value_) (((BITMAP *) _ptr_)->bmBitsPixel = (WORD) (_value_))
#define cwel_logbitmap_set_bits(_ptr_, _value_) (((BITMAP *) _ptr_)->bmBits = (LPVOID) (_value_))

#define cwel_logbitmap_get_type(_ptr_) ((EIF_INTEGER) (((BITMAP *) _ptr_)->bmType))
#define cwel_logbitmap_get_width(_ptr_) ((EIF_INTEGER) (((BITMAP *) _ptr_)->bmWidth))
#define cwel_logbitmap_get_height(_ptr_) ((EIF_INTEGER) (((BITMAP *) _ptr_)->bmHeight))
#define cwel_logbitmap_get_width_bytes(_ptr_) ((EIF_INTEGER) (((BITMAP *) _ptr_)->bmWidthBytes))
#define cwel_logbitmap_get_planes(_ptr_) ((EIF_INTEGER) (((BITMAP *) _ptr_)->bmPlanes))
#define cwel_logbitmap_get_bits_pixel(_ptr_) ((EIF_INTEGER) (((BITMAP *) _ptr_)->bmBitsPixel))
#define cwel_logbitmap_get_bits(_ptr_) ((EIF_POINTER) (((BITMAP *) _ptr_)->bmBits))


#ifdef __cplusplus
}
#endif

#endif /* __WEL_LOGBITMAP__ */
