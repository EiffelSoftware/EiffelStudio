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

#ifndef __WEL_NM_UPDOWN__
#define __WEL_NM_UPDOWN__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_nm_updown_set_ipos(_ptr_, _value_) (((NM_UPDOWN *) _ptr_)->iPos = (int) (_value_))
#define cwel_nm_updown_set_idelta(_ptr_, _value_) (((NM_UPDOWN *) _ptr_)->iDelta = (int) (_value_))

#define cwel_nm_updown_get_hdr(_ptr_) (&(((NM_UPDOWN *) _ptr_)->hdr))
#define cwel_nm_updown_get_ipos(_ptr_) (((NM_UPDOWN *) _ptr_)->iPos)
#define cwel_nm_updown_get_idelta(_ptr_) (((NM_UPDOWN *) _ptr_)->iDelta)


#ifdef __cplusplus
}
#endif

#endif /* __WEL_NM_UPDOWN__ */
