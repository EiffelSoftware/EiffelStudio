/*
 * MEASUREITEM.H
 */

#ifndef __WEL_MEASUREITEMSTRUCT__
#define __WEL_MEASUREITEMSTRUCT__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_measureitemstruct_get_ctltype(_ptr_) ((EIF_INTEGER) (((MEASUREITEMSTRUCT *) _ptr_)->CtlType))
#define cwel_measureitemstruct_get_ctlid(_ptr_) ((EIF_INTEGER) (((MEASUREITEMSTRUCT *) _ptr_)->CtlID))
#define cwel_measureitemstruct_get_itemid(_ptr_) ((EIF_INTEGER) (((MEASUREITEMSTRUCT *) _ptr_)->itemID))
#define cwel_measureitemstruct_get_itemwidth(_ptr_) ((EIF_INTEGER) (((MEASUREITEMSTRUCT *) _ptr_)->itemWidth))
#define cwel_measureitemstruct_get_itemheight(_ptr_) ((EIF_INTEGER) (((MEASUREITEMSTRUCT *) _ptr_)->itemHeight))
#define cwel_measureitemstruct_get_itemdata(_ptr_) ((EIF_INTEGER) (((MEASUREITEMSTRUCT *) _ptr_)->itemData))

#define cwel_measureitemstruct_set_itemwidth(_ptr_, _value_) (((MEASUREITEMSTRUCT *) _ptr_)->itemWidth = (_value_))
#define cwel_measureitemstruct_set_itemheight(_ptr_, _value_) (((MEASUREITEMSTRUCT *) _ptr_)->itemHeight = (_value_))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_MEASUREITEMSTRUCT__ */

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
