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

#ifndef __WEL_LOGPALETTE__
#define __WEL_LOGPALETTE__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_log_palette_set_version(_ptr_, _value_) (((LOGPALETTE *) _ptr_)->palVersion = (WORD) (_value_))
#define cwel_log_palette_set_num_entries(_ptr_, _value_) (((LOGPALETTE *) _ptr_)->palNumEntries = (WORD) (_value_))
#define cwel_log_palette_set_pal_entry_red(_ptr_, _index_, _value_) (((LOGPALETTE *) _ptr_)->palPalEntry[_index_].peRed = (BYTE) _value_)
#define cwel_log_palette_set_pal_entry_green(_ptr_, _index_, _value_) (((LOGPALETTE *) _ptr_)->palPalEntry[_index_].peGreen = (BYTE) _value_)
#define cwel_log_palette_set_pal_entry_blue(_ptr_, _index_, _value_) (((LOGPALETTE *) _ptr_)->palPalEntry[_index_].peBlue = (BYTE) _value_)
#define cwel_log_palette_set_pal_entry_flags(_ptr_, _index_, _value_) (((LOGPALETTE *) _ptr_)->palPalEntry[_index_].peFlags = (BYTE) _value_)

#define cwel_log_palette_get_version(_ptr_) ((EIF_INTEGER) (((LOGPALETTE *) _ptr_)->palVersion))
#define cwel_log_palette_get_num_entries(_ptr_) ((EIF_INTEGER) (((LOGPALETTE *) _ptr_)->palNumEntries))
#define cwel_log_palette_get_pal_entry(_ptr_, _index_) ((EIF_POINTER) &(((LOGPALETTE *) _ptr_)->palPalEntry[_index_]))


#ifdef __cplusplus
}
#endif

#endif /* __WEL_LOGPALETTE__ */
