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
