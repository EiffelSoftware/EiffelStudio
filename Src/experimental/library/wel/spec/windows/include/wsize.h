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

#ifndef __WEL_SIZE__
#define __WEL_SIZE__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_size_set_cx(_ptr_, _value_) (((SIZE *) _ptr_)->cx = (int) (_value_))
#define cwel_size_set_cy(_ptr_, _value_) (((SIZE *) _ptr_)->cy = (int) (_value_))

#define cwel_size_get_cx(_ptr_) ((EIF_INTEGER) (((SIZE *) _ptr_)->cx))
#define cwel_size_get_cy(_ptr_) ((EIF_INTEGER) (((SIZE *) _ptr_)->cy))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_SIZE__ */
