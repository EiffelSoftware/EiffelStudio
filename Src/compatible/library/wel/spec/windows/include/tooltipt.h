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

#ifndef __WEL_TOOLTIPTEXT__
#define __WEL_TOOLTIPTEXT__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_tooltiptext_set_lpsztext(_ptr_,_value_) (((TOOLTIPTEXT *) _ptr_)->lpszText = (LPTSTR) (_value_))
#define cwel_tooltiptext_set_hinst(_ptr_,_value_) (((TOOLTIPTEXT *) _ptr_)->hinst = (HINSTANCE) (_value_))
#define cwel_tooltiptext_set_uflags(_ptr_,_value_) (((TOOLTIPTEXT *) _ptr_)->uFlags = (UINT) (_value_))

#define cwel_tooltiptext_get_hdr(_ptr_) (&(((TOOLTIPTEXT *) _ptr_)->hdr))
#define cwel_tooltiptext_get_lpsztext(_ptr_) ((((TOOLTIPTEXT *) _ptr_)->lpszText))
#define cwel_tooltiptext_get_hinst(_ptr_) ((((TOOLTIPTEXT *) _ptr_)->hinst))
#define cwel_tooltiptext_get_uflags(_ptr_) ((((TOOLTIPTEXT *) _ptr_)->uFlags))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_TOOLTIPTEXT__ */
