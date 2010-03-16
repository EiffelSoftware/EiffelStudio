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
