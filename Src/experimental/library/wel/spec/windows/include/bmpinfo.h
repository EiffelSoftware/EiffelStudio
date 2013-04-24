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

#ifndef __WEL_BITMAPINFO__
#define __WEL_BITMAPINFO__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_bitmap_info_set_header(_ptr_, _value_) (((BITMAPINFO *) _ptr_)->bmiHeader = (* ((BITMAPINFOHEADER *) _value_)))
#define cwel_bitmap_info_set_rgb_quad_rgb_red(_ptr_, _index_, _value_) (((BITMAPINFO *) _ptr_)->bmiColors[_index_].rgbRed = (BYTE) _value_)
#define cwel_bitmap_info_set_rgb_quad_rgb_green(_ptr_, _index_, _value_) (((BITMAPINFO *) _ptr_)->bmiColors[_index_].rgbGreen = (BYTE) _value_)
#define cwel_bitmap_info_set_rgb_quad_rgb_blue(_ptr_, _index_, _value_) (((BITMAPINFO *) _ptr_)->bmiColors[_index_].rgbBlue = (BYTE) _value_)
#define cwel_bitmap_info_set_rgb_quad_rgb_reserved(_ptr_, _index_, _value_) (((BITMAPINFO *) _ptr_)->bmiColors[_index_].rgbReserved = (BYTE) _value_)

#define cwel_bitmap_info_get_header(_ptr_) ((EIF_POINTER) &(((BITMAPINFO *) _ptr_)->bmiHeader))
#define cwel_bitmap_info_get_rgb_quad(_ptr_, _index_) ((EIF_POINTER) &(((BITMAPINFO *) _ptr_)->bmiColors[_index_]))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_BITMAPINFO__ */
