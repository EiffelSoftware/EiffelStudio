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
