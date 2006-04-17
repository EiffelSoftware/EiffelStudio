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

#ifndef __WEL_DRAWITEMSTRUCT__
#define __WEL_DRAWITEMSTRUCT__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_drawitemstruct_get_ctltype(_ptr_) ((EIF_INTEGER) (((DRAWITEMSTRUCT *) _ptr_)->CtlType))
#define cwel_drawitemstruct_get_ctlid(_ptr_) ((EIF_INTEGER) (((DRAWITEMSTRUCT *) _ptr_)->CtlID))
#define cwel_drawitemstruct_get_itemid(_ptr_) ((EIF_INTEGER) (((DRAWITEMSTRUCT *) _ptr_)->itemID))
#define cwel_drawitemstruct_get_itemaction(_ptr_) ((EIF_INTEGER) (((DRAWITEMSTRUCT *) _ptr_)->itemAction))
#define cwel_drawitemstruct_get_itemstate(_ptr_) ((EIF_INTEGER) (((DRAWITEMSTRUCT *) _ptr_)->itemState))
#define cwel_drawitemstruct_get_hwnditem(_ptr_) ((EIF_POINTER) (((DRAWITEMSTRUCT *) _ptr_)->hwndItem))
#define cwel_drawitemstruct_get_hdc(_ptr_) ((EIF_POINTER) (((DRAWITEMSTRUCT *) _ptr_)->hDC))
#define cwel_drawitemstruct_get_rcitem(_ptr_) ((EIF_POINTER) &(((DRAWITEMSTRUCT *) _ptr_)->rcItem))
#define cwel_drawitemstruct_get_itemdata(_ptr_) ((EIF_POINTER) (((DRAWITEMSTRUCT *) _ptr_)->itemData))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_DRAWITEMSTRUCT__ */
