/*
 * CHARRANGE.H
 */

#ifndef __WEL_CHARRANGE__
#define __WEL_CHARRANGE__

#ifndef __WEL_RICHEDIT__
#	include <redit.h>
#endif

#define cwel_charrange_set_cpmin(_ptr_, _value_) (((CHARRANGE *) _ptr_)->cpMin = (LONG) (_value_))
#define cwel_charrange_set_cpmax(_ptr_, _value_) (((CHARRANGE *) _ptr_)->cpMax = (LONG) (_value_))

#define cwel_charrange_get_cpmin(_ptr_) (((CHARRANGE *) _ptr_)->cpMin)
#define cwel_charrange_get_cpmax(_ptr_) (((CHARRANGE *) _ptr_)->cpMax)

#endif /* __WEL_CHARRANGE__ */

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
