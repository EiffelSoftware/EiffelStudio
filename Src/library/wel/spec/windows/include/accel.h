/*
 * ACCEL.H
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

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
