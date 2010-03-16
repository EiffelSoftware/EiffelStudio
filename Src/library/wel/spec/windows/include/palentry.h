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

#ifndef __WEL_PALETTEENTRY__
#define __WEL_PALETTEENTRY__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_palette_entry_set_red(_ptr_, _value_) (((PALETTEENTRY *) _ptr_)->peRed = (BYTE) (_value_))
#define cwel_palette_entry_set_green(_ptr_, _value_) (((PALETTEENTRY *) _ptr_)->peGreen = (BYTE) (_value_))
#define cwel_palette_entry_set_blue(_ptr_, _value_) (((PALETTEENTRY *) _ptr_)->peBlue = (BYTE) (_value_))
#define cwel_palette_entry_set_flags(_ptr_, _value_) (((PALETTEENTRY *) _ptr_)->peFlags = (BYTE) (_value_))

#define cwel_palette_entry_get_red(_ptr_) ((EIF_INTEGER) (((PALETTEENTRY *) _ptr_)->peRed))
#define cwel_palette_entry_get_green(_ptr_) ((EIF_INTEGER) (((PALETTEENTRY *) _ptr_)->peGreen))
#define cwel_palette_entry_get_blue(_ptr_) ((EIF_INTEGER) (((PALETTEENTRY *) _ptr_)->peBlue))
#define cwel_palette_entry_get_flags(_ptr_) ((EIF_INTEGER) (((PALETTEENTRY *) _ptr_)->peFlags))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_PALETTEENTRY__ */
