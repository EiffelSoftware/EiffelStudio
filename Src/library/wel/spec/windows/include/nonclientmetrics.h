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

#ifndef __WEL_NONCLIENTMETRICS__
#define __WEL_NONCLIENTMETRICS__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_nonclientmetrics_get_border_width(_ptr_)			((EIF_INTEGER) (((NONCLIENTMETRICS *) _ptr_)->iBorderWidth))
#define cwel_nonclientmetrics_get_scroll_width(_ptr_)			((EIF_INTEGER) (((NONCLIENTMETRICS *) _ptr_)->iScrollWidth))
#define cwel_nonclientmetrics_get_scroll_height(_ptr_)			((EIF_INTEGER) (((NONCLIENTMETRICS *) _ptr_)->iScrollHeight))
#define cwel_nonclientmetrics_get_caption_width(_ptr_)			((EIF_INTEGER) (((NONCLIENTMETRICS *) _ptr_)->iCaptionWidth))
#define cwel_nonclientmetrics_get_caption_height(_ptr_)			((EIF_INTEGER) (((NONCLIENTMETRICS *) _ptr_)->iCaptionHeight))
#define cwel_nonclientmetrics_get_caption_font(_ptr_)			((EIF_POINTER) &(((NONCLIENTMETRICS *) _ptr_)->lfCaptionFont))
#define cwel_nonclientmetrics_get_small_caption_width(_ptr_)	((EIF_INTEGER) (((NONCLIENTMETRICS *) _ptr_)->iSmCaptionWidth))
#define cwel_nonclientmetrics_get_small_caption_height(_ptr_)	((EIF_INTEGER) (((NONCLIENTMETRICS *) _ptr_)->iSmCaptionHeight))
#define cwel_nonclientmetrics_get_small_caption_font(_ptr_)		((EIF_POINTER) &(((NONCLIENTMETRICS *) _ptr_)->lfSmCaptionFont))
#define cwel_nonclientmetrics_get_menu_width(_ptr_)				((EIF_INTEGER) (((NONCLIENTMETRICS *) _ptr_)->iMenuWidth))
#define cwel_nonclientmetrics_get_menu_height(_ptr_)			((EIF_INTEGER) (((NONCLIENTMETRICS *) _ptr_)->iMenuHeight))
#define cwel_nonclientmetrics_get_menu_font(_ptr_)				((EIF_POINTER) &(((NONCLIENTMETRICS *) _ptr_)->lfMenuFont))
#define cwel_nonclientmetrics_get_status_font(_ptr_)			((EIF_POINTER) &(((NONCLIENTMETRICS *) _ptr_)->lfStatusFont))
#define cwel_nonclientmetrics_get_message_font(_ptr_)			((EIF_POINTER) &(((NONCLIENTMETRICS *) _ptr_)->lfMessageFont))

#define cwel_nonclientmetrics_set_structure_size(_ptr_, _value_) (((NONCLIENTMETRICS *) _ptr_)->cbSize = (LONG) (_value_))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_NONCLIENTMETRICS__ */
