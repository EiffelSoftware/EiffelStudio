/*
 * TVINSS.H
 */

#ifndef __WEL_TREEVIEWINSERTSTRUCT__
#define __WEL_TREEVIEWINSERTSTRUCT__

#ifndef __WEL__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_insertstruct_set_hparent(_ptr_, _value_) (((TV_INSERTSTRUCT *) _ptr_)->hParent = (HTREEITEM) (_value_))
#define cwel_insertstruct_set_hinsertafter(_ptr_, _value_) (((TV_INSERTSTRUCT *) _ptr_)->hInsertAfter = (HTREEITEM) (_value_))

#if (_WIN32_IE >= 0x0400)
#define cwel_insertstruct_set_item(_ptr_, _value_) (((TV_INSERTSTRUCT *) _ptr_)->DUMMYUNIONNAME.item = (*(TV_ITEM *) (_value_)))
#else
#define cwel_insertstruct_set_item(_ptr_, _value_) (((TV_INSERTSTRUCT *) _ptr_)->item = (*(TV_ITEM *) (_value_)))
#endif

#define cwel_insertstruct_get_hparent(_ptr_) ((((TV_INSERTSTRUCT *) _ptr_)->hParent))
#define cwel_insertstruct_get_hinsertafter(_ptr_) ((((TV_INSERTSTRUCT *) _ptr_)->hInsertAfter))

#if (_WIN32_IE >= 0x0400)
#define cwel_insertstruct_get_item(_ptr_) (&(((TV_INSERTSTRUCT *) _ptr_)->DUMMYUNIONNAME.item))
#else
#define cwel_insertstruct_get_item(_ptr_) (&(((TV_INSERTSTRUCT *) _ptr_)->item))
#endif

#ifdef __cplusplus
}
#endif

#endif /* __WEL_TREEVIEWINSERTSTRUCT__ */

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
