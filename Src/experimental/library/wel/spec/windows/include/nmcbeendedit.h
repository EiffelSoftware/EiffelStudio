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

#ifndef __WEL_NM_CBEENDEDIT__
#define __WEL_NM_CBEENDEDIT__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_nm_cbeendedit_get_hdr(_ptr_) (&(((NMCBEENDEDIT *) _ptr_)->hdr))
#define cwel_nm_cbeendedit_get_fchanged(_ptr_) (((NMCBEENDEDIT *) _ptr_)->fChanged)
#define cwel_nm_cbeendedit_get_inewselection(_ptr_) (((NMCBEENDEDIT *) _ptr_)->iNewSelection)
#define cwel_nm_cbeendedit_get_tchar(_ptr_) (&(((NMCBEENDEDIT *) _ptr_)->szText))
#define cwel_nm_cbeendedit_get_iwhy(_ptr_) (((NMCBEENDEDIT *) _ptr_)->iWhy)

#ifdef __cplusplus
}
#endif

#endif /* __WEL_NM_CBEENDEDIT__ */
