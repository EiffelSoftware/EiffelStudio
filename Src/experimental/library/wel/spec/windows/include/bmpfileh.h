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

#ifndef __WEL_BITMAPFILEHEADER__
#define __WEL_BITMAPFILEHEADER__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_bitmapfileheader_set_type(_ptr_, _value_) (((BITMAPFILEHEADER *) _ptr_)->bfType = (WORD) (_value_))
#define cwel_bitmapfileheader_set_size(_ptr_, _value_) (((BITMAPFILEHEADER *) _ptr_)->bfSize = (DWORD) (_value_))
#define cwel_bitmapfileheader_set_reserved1(_ptr_, _value_) (((BITMAPFILEHEADER *) _ptr_)->bfReserved1 = (WORD) (_value_))
#define cwel_bitmapfileheader_set_reserved2(_ptr_, _value_) (((BITMAPFILEHEADER *) _ptr_)->bfReserved2 = (WORD) (_value_))
#define cwel_bitmapfileheader_set_off_bits(_ptr_, _value_) (((BITMAPFILEHEADER *) _ptr_)->bfOffBits = (DWORD) (_value_))

#define cwel_bitmapfileheader_get_type(_ptr_) ((((BITMAPFILEHEADER *) _ptr_)->bfType))
#define cwel_bitmapfileheader_get_size(_ptr_) ((((BITMAPFILEHEADER *) _ptr_)->bfSize))
#define cwel_bitmapfileheader_get_reserved1(_ptr_) ((((BITMAPFILEHEADER *) _ptr_)->bfReserved1))
#define cwel_bitmapfileheader_get_reserved2(_ptr_) ((((BITMAPFILEHEADER *) _ptr_)->bfReserved2))
#define cwel_bitmapfileheader_get_off_bits(_ptr_) ((((BITMAPFILEHEADER *) _ptr_)->bfOffBits))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_BITMAPFILEHEADER__ */
