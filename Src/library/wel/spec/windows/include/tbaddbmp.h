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

#ifndef __WEL_TOOLBAR_BITMAP__
#define __WEL_TOOLBAR_BITMAP__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_tbaddbitmap_set_hinst(_ptr_,_value_) (((TBADDBITMAP *) _ptr_)->hInst = (HINSTANCE) (_value_))
#define cwel_tbaddbitmap_set_nid(_ptr_,_value_) (((TBADDBITMAP *) _ptr_)->nID = (UINT_PTR) (_value_))

#define cwel_tbaddbitmap_get_hinst(_ptr_) ((((TBADDBITMAP *) _ptr_)->hInst))
#define cwel_tbaddbitmap_get_nid(_ptr_) ((((TBADDBITMAP *) _ptr_)->nID))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_TOOLBAR_BITMAP__ */
