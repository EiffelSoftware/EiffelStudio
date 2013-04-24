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

#ifndef __WEL_ACCEL__
#define __WEL_ACCEL__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif


#define cwel_accel_set_fvirt(_ptr_, _value_) (((ACCEL *) _ptr_)->fVirt = (BYTE) (_value_))
#define cwel_accel_set_key(_ptr_, _value_) (((ACCEL *) _ptr_)->key = (WORD) (_value_))
#define cwel_accel_set_cmd(_ptr_, _value_) (((ACCEL *) _ptr_)->cmd = (WORD) (_value_))

#define cwel_accel_get_fvirt(_ptr_) (((ACCEL *) _ptr_)->fVirt)
#define cwel_accel_get_key(_ptr_) (((ACCEL *) _ptr_)->key)
#define cwel_accel_get_cmd(_ptr_) (((ACCEL *) _ptr_)->cmd)

#ifdef __cplusplus
}
#endif

#endif /* __WEL_ACCEL__ */
