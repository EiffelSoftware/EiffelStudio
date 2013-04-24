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

#ifndef __WEL_REBARINFO__
#define __WEL_REBARINFO__

#ifndef __WEL__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif


#define cwel_rebarinfo_set_cbsize(_ptr_, _value_) (((REBARINFO *) _ptr_)->cbSize = (UINT) (_value_))
#define cwel_rebarinfo_set_fmask(_ptr_, _value_) (((REBARINFO *) _ptr_)->fMask = (UINT) (_value_))
#define cwel_rebarinfo_set_himl(_ptr_, _value_) (((REBARINFO *) _ptr_)->himl = (HIMAGELIST) (_value_))

#define cwel_rebarinfo_get_cbsize(_ptr_) ((((REBARINFO *) _ptr_)->cbSize))
#define cwel_rebarinfo_get_fmask(_ptr_) ((((REBARINFO *) _ptr_)->fMask))
#define cwel_rebarinfo_get_himl(_ptr_) ((((REBARINFO *) _ptr_)->himl))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_REBARINFO__ */
