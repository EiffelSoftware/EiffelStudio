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

#ifndef __WEL_INITCOMMONCONTROLSEX__
#define __WEL_INITCOMMONCONTROLSEX__

#ifndef __WEL__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_initcommctrlex_set_dwsize(_ptr_, _value_)	(((INITCOMMONCONTROLSEX *) _ptr_)->dwSize = (DWORD) (_value_))
#define cwel_initcommctrlex_set_dwicc(_ptr_, _value_)	(((INITCOMMONCONTROLSEX *) _ptr_)->dwICC = (DWORD) (_value_))

#define cwel_initcommctrlex_get_dwsize(_ptr_) 	(((INITCOMMONCONTROLSEX *) _ptr_)->dwSize)
#define cwel_initcommctrlex_get_dwicc(_ptr_)	(((INITCOMMONCONTROLSEX *) _ptr_)->dwICC)


#ifdef __cplusplus
}
#endif

#endif /* __WEL_INITCOMMONCONTROLSEX__ */
