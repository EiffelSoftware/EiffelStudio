/*
 * TCKEYDOWN.H
 */

#ifndef __WEL_TC_KEYDOWN__
#define __WEL_TC_KEYDOWN__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#define cwel_tc_keydown_get_hdr(_ptr_) (&(((TC_KEYDOWN *) _ptr_)->hdr))
#define cwel_tc_keydown_get_wvkey(_ptr_) (((TC_KEYDOWN *) _ptr_)->wVKey)
#define cwel_tc_keydown_get_flags(_ptr_) (((TC_KEYDOWN *) _ptr_)->flags)

#endif /* __WEL_TC_KEYDOWN__ */

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
