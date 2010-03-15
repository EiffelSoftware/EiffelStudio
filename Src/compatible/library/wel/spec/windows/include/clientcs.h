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

#ifndef __WEL_CLIENTCREATESTRUCT__
#define __WEL_CLIENTCREATESTRUCT__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_client_cs_set_window_menu(_ptr_,_value_) (((CLIENTCREATESTRUCT *) _ptr_)->hWindowMenu = (HANDLE) (_value_))
#define cwel_client_cs_set_first_child(_ptr_,_value_) (((CLIENTCREATESTRUCT *) _ptr_)->idFirstChild = (UINT) (_value_))

#define cwel_client_cs_get_window_menu(_ptr_) ((((CLIENTCREATESTRUCT *) _ptr_)->hWindowMenu))
#define cwel_client_cs_get_first_child(_ptr_) ((((CLIENTCREATESTRUCT *) _ptr_)->idFirstChild))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_CLIENTCREATESTRUCT__ */
