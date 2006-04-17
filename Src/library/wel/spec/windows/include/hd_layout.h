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

#ifndef __WEL_HD_LAYOUT__
#define __WEL_HD_LAYOUT__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_hd_layout_set_prc(_ptr_, _value_) (((HD_LAYOUT *) _ptr_)->prc = (RECT FAR*) _value_)
#define cwel_hd_layout_get_prc(_ptr_) ((EIF_POINTER)(((HD_LAYOUT *) _ptr_)->prc))

#define cwel_hd_layout_set_pwpos(_ptr_, _value_) (((HD_LAYOUT *) _ptr_)->pwpos = (WINDOWPOS FAR*) _value_)
#define cwel_hd_layout_get_pwpos(_ptr_) ((EIF_POINTER)(((HD_LAYOUT *) _ptr_)->pwpos))


#ifdef __cplusplus
}
#endif


#endif /* __WEL_HD_LAYOUT__ */
