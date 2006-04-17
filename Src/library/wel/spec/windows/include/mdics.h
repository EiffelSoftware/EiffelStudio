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

#ifndef __WEL_MDICREATESTRUCT__
#define __WEL_MDICREATESTRUCT__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_mdi_cs_set_class_name(_ptr_, _value_) (((MDICREATESTRUCT *) _ptr_)->szClass = (LPCTSTR) (_value_))
#define cwel_mdi_cs_set_title(_ptr_, _value_) (((MDICREATESTRUCT *) _ptr_)->szTitle = (LPCTSTR) (_value_))
#define cwel_mdi_cs_set_owner(_ptr_, _value_) (((MDICREATESTRUCT *) _ptr_)->hOwner = (HINSTANCE) (_value_))
#define cwel_mdi_cs_set_x(_ptr_, _value_) (((MDICREATESTRUCT *) _ptr_)->x = (int) (_value_))
#define cwel_mdi_cs_set_y(_ptr_, _value_) (((MDICREATESTRUCT *) _ptr_)->y = (int) (_value_))
#define cwel_mdi_cs_set_width(_ptr_, _value_) (((MDICREATESTRUCT *) _ptr_)->cx = (int) (_value_))
#define cwel_mdi_cs_set_height(_ptr_, _value_) (((MDICREATESTRUCT *) _ptr_)->cy = (int) (_value_))
#define cwel_mdi_cs_set_style(_ptr_, _value_) (((MDICREATESTRUCT *) _ptr_)->style = (DWORD) (_value_))
#define cwel_mdi_cs_set_lparam(_ptr_, _value_) (((MDICREATESTRUCT *) _ptr_)->lParam = (LPARAM) (_value_))

#define cwel_mdi_cs_get_class_name(_ptr_) ((EIF_POINTER) (((MDICREATESTRUCT *) _ptr_)->szClass))
#define cwel_mdi_cs_get_class_title(_ptr_) ((EIF_POINTER) (((MDICREATESTRUCT *) _ptr_)->szTitle))
#define cwel_mdi_cs_get_owner(_ptr_) ((EIF_POINTER) (((MDICREATESTRUCT *) _ptr_)->hOwner))
#define cwel_mdi_cs_get_x(_ptr_) ((EIF_INTEGER) (((MDICREATESTRUCT *) _ptr_)->x))
#define cwel_mdi_cs_get_y(_ptr_) ((EIF_INTEGER) (((MDICREATESTRUCT *) _ptr_)->y))
#define cwel_mdi_cs_get_width(_ptr_) ((EIF_INTEGER) (((MDICREATESTRUCT *) _ptr_)->cx))
#define cwel_mdi_cs_get_height(_ptr_) ((EIF_INTEGER) (((MDICREATESTRUCT *) _ptr_)->cy))
#define cwel_mdi_cs_get_style(_ptr_) ((EIF_INTEGER) (((MDICREATESTRUCT *) _ptr_)->style))
#define cwel_mdi_cs_get_lparam(_ptr_) ((EIF_POINTER) (((MDICREATESTRUCT *) _ptr_)->lParam))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_MDICREATESTRUCT__ */
