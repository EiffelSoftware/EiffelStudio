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

#ifndef __WEL_WINDOWPLACEMENT__
#define __WEL_WINDOWPLACEMENT__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_window_placement_set_length(_ptr_,_value_) (((WINDOWPLACEMENT *) _ptr_)->length = (UINT) (_value_))
#define cwel_window_placement_set_flags(_ptr_,_value_) (((WINDOWPLACEMENT *) _ptr_)->flags = (UINT) (_value_))
#define cwel_window_placement_set_show_command(_ptr_,_value_) (((WINDOWPLACEMENT *) _ptr_)->showCmd = (UINT) (_value_))
#define cwel_window_placement_set_minimum_position(_ptr_,_value_) memcpy (&((WINDOWPLACEMENT *) _ptr_)->ptMinPosition, (void *) _value_, sizeof (POINT))
#define cwel_window_placement_set_maximum_position(_ptr_,_value_) memcpy (&((WINDOWPLACEMENT *) _ptr_)->ptMaxPosition, (void *) _value_, sizeof (POINT))
#define cwel_window_placement_set_normal_position(_ptr_,_value_) memcpy (&((WINDOWPLACEMENT *) _ptr_)->rcNormalPosition, (void *) _value_, sizeof (RECT))

#define cwel_window_placement_get_flags(_ptr_) ((EIF_INTEGER) (((WINDOWPLACEMENT *) _ptr_)->flags))
#define cwel_window_placement_get_show_command(_ptr_) ((EIF_INTEGER) (((WINDOWPLACEMENT *) _ptr_)->showCmd))
#define cwel_window_placement_get_minimum_position(_ptr_) ((EIF_POINTER) &(((WINDOWPLACEMENT *) _ptr_)->ptMinPosition))
#define cwel_window_placement_get_maximum_position(_ptr_) ((EIF_POINTER) &(((WINDOWPLACEMENT *) _ptr_)->ptMaxPosition))
#define cwel_window_placement_get_normal_position(_ptr_) ((EIF_POINTER) &(((WINDOWPLACEMENT *) _ptr_)->rcNormalPosition))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_WINDOWPLACEMENT__ */
