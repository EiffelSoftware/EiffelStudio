/*
 * WSIZE.H
 */

#ifndef __WEL_SIZE__
#define __WEL_SIZE__

#ifndef __WEL__
#	include <wel.h>
#endif

#define cwel_size_set_cx(_ptr_, _value_) (((SIZE *) _ptr_)->cx = (int) (_value_))
#define cwel_size_set_cy(_ptr_, _value_) (((SIZE *) _ptr_)->cy = (int) (_value_))

#define cwel_size_get_cx(_ptr_) ((EIF_INTEGER) (((SIZE *) _ptr_)->cx))
#define cwel_size_get_cy(_ptr_) ((EIF_INTEGER) (((SIZE *) _ptr_)->cy))

#endif /* __WEL_SIZE__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
