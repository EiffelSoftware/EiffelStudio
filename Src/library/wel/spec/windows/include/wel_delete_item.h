/*
 * wel_delete_item.h
 */

#ifndef __WEL_DELETEITEMSTRUCT__
#define __WEL_DELETEITEMSTRUCT__

#ifndef __WEL__
# include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_deleteitemstruct_get_ctltype(_ptr_) ((EIF_INTEGER) (((DELETEITEMSTRUCT *) _ptr_)->CtlType))
#define cwel_deleteitemstruct_get_ctlid(_ptr_) ((EIF_INTEGER) (((DELETEITEMSTRUCT *) _ptr_)->CtlID))
#define cwel_deleteitemstruct_get_hwnditem(_ptr_) ((EIF_POINTER) (((DELETEITEMSTRUCT *) _ptr_)->hwndItem))
#define cwel_deleteitemstruct_get_itemid(_ptr_) ((EIF_INTEGER) (((DELETEITEMSTRUCT *) _ptr_)->itemID))
#define cwel_deleteitemstruct_get_itemdata(_ptr_) ((EIF_POINTER) (((DELETEITEMSTRUCT *) _ptr_)->itemData))


#ifdef __cplusplus
}
#endif

#endif /* __WEL_DELETEITEMSTRUCT__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-2001, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
