/*
 * DRAWITEM.H
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
#define cwel_drawitemstruct_get_itemdata(_ptr_) ((EIF_INTEGER) (((DRAWITEMSTRUCT *) _ptr_)->itemData))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_DRAWITEMSTRUCT__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
