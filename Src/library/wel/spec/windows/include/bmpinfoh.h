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

#ifndef __WEL_BITMAPINFOHEADER__
#define __WEL_BITMAPINFOHEADER__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_bitmapinfoheader_set_size(_ptr_, _value_) (((BITMAPINFOHEADER *) _ptr_)->biSize = (DWORD) (_value_))
#define cwel_bitmapinfoheader_set_width(_ptr_, _value_) (((BITMAPINFOHEADER *) _ptr_)->biWidth = (LONG) (_value_))
#define cwel_bitmapinfoheader_set_height(_ptr_, _value_) (((BITMAPINFOHEADER *) _ptr_)->biHeight = (LONG) (_value_))
#define cwel_bitmapinfoheader_set_planes(_ptr_, _value_) (((BITMAPINFOHEADER *) _ptr_)->biPlanes = (WORD) (_value_))
#define cwel_bitmapinfoheader_set_bitcount(_ptr_, _value_) (((BITMAPINFOHEADER *) _ptr_)->biBitCount = (WORD) (_value_))
#define cwel_bitmapinfoheader_set_compression(_ptr_, _value_) (((BITMAPINFOHEADER *) _ptr_)->biCompression = (DWORD) (_value_))
#define cwel_bitmapinfoheader_set_sizeimage(_ptr_, _value_) (((BITMAPINFOHEADER *) _ptr_)->biSizeImage = (DWORD) (_value_))
#define cwel_bitmapinfoheader_set_xpelspermeter(_ptr_, _value_) (((BITMAPINFOHEADER *) _ptr_)->biXPelsPerMeter = (LONG) (_value_))
#define cwel_bitmapinfoheader_set_ypelspermeter(_ptr_, _value_) (((BITMAPINFOHEADER *) _ptr_)->biYPelsPerMeter = (LONG) (_value_))
#define cwel_bitmapinfoheader_set_clrused(_ptr_, _value_) (((BITMAPINFOHEADER *) _ptr_)->biClrUsed = (DWORD) (_value_))
#define cwel_bitmapinfoheader_set_clrimportant(_ptr_, _value_) (((BITMAPINFOHEADER *) _ptr_)->biClrImportant = (DWORD) (_value_))

// #define cwel_bitmapinfoheader_get_size(_ptr_) ((EIF_INTEGER)((BITMAPINFOHEADER *) _ptr_)->biSize)
#define cwel_bitmapinfoheader_get_width(_ptr_) ((EIF_INTEGER)((BITMAPINFOHEADER *) _ptr_)->biWidth)
#define cwel_bitmapinfoheader_get_height(_ptr_) ((EIF_INTEGER)((BITMAPINFOHEADER *) _ptr_)->biHeight)
#define cwel_bitmapinfoheader_get_planes(_ptr_) ((EIF_INTEGER)((BITMAPINFOHEADER *) _ptr_)->biPlanes)
#define cwel_bitmapinfoheader_get_bitcount(_ptr_) ((EIF_INTEGER)((BITMAPINFOHEADER *) _ptr_)->biBitCount)
#define cwel_bitmapinfoheader_get_compression(_ptr_) ((EIF_INTEGER)((BITMAPINFOHEADER *) _ptr_)->biCompression)
#define cwel_bitmapinfoheader_get_sizeimage(_ptr_) ((EIF_INTEGER)((BITMAPINFOHEADER *) _ptr_)->biSizeImage)
#define cwel_bitmapinfoheader_get_xpelspermeter(_ptr_) ((EIF_INTEGER)((BITMAPINFOHEADER *) _ptr_)->biXPelsPerMeter)
#define cwel_bitmapinfoheader_get_ypelspermeter(_ptr_) ((EIF_INTEGER)((BITMAPINFOHEADER *) _ptr_)->biYPelsPerMeter)
#define cwel_bitmapinfoheader_get_clrused(_ptr_) ((EIF_INTEGER)((BITMAPINFOHEADER *) _ptr_)->biClrUsed)
#define cwel_bitmapinfoheader_get_clrimportant(_ptr_) ((EIF_INTEGER)((BITMAPINFOHEADER *) _ptr_)->biClrImportant)

#ifdef __cplusplus
}
#endif

#endif /* __WEL_BITMAPINFOHEADER__ */
