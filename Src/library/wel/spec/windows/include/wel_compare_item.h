/*
 * wel_compare_item.h
 */

#ifndef __WEL_COMPAREITEMSTRUCT__
#define __WEL_COMPAREITEMSTRUCT__

#ifndef __WEL__
# include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_compareitemstruct_get_ctltype(_ptr_) ((EIF_INTEGER) (((COMPAREITEMSTRUCT *) _ptr_)->CtlType))
#define cwel_compareitemstruct_get_ctlid(_ptr_) ((EIF_INTEGER) (((COMPAREITEMSTRUCT *) _ptr_)->CtlID))
#define cwel_compareitemstruct_get_hwnditem(_ptr_) ((EIF_POINTER) (((COMPAREITEMSTRUCT *) _ptr_)->hwndItem))
#define cwel_compareitemstruct_get_itemid1(_ptr_) ((EIF_INTEGER) (((COMPAREITEMSTRUCT *) _ptr_)->itemID1))
#define cwel_compareitemstruct_get_itemdata1(_ptr_) ((EIF_POINTER) (((COMPAREITEMSTRUCT *) _ptr_)->itemData1))
#define cwel_compareitemstruct_get_itemid2(_ptr_) ((EIF_INTEGER) (((COMPAREITEMSTRUCT *) _ptr_)->itemID2))
#define cwel_compareitemstruct_get_itemdata2(_ptr_) ((EIF_POINTER) (((COMPAREITEMSTRUCT *) _ptr_)->itemData2))
#define cwel_compareitemstruct_get_dwlocaleid(_ptr_) ((EIF_INTEGER) (((COMPAREITEMSTRUCT *) _ptr_)->dwLocaleId))


#ifdef __cplusplus
}
#endif

#endif /* __WEL_COMPAREITEMSTRUCT__ */

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
