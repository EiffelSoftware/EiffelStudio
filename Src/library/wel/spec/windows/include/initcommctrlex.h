/*
 * INITCOMMCTRLEX.H
 */

#ifndef __WEL_INITCOMMONCONTROLSEX__
#define __WEL_INITCOMMONCONTROLSEX__

#ifndef __WEL__
#	include <cctrl.h>
#endif

#define cwel_initcommctrlex_set_dwsize(_ptr_, _value_)	(((INITCOMMONCONTROLSEX *) _ptr_)->dwSize = (DWORD) (_value_))
#define cwel_initcommctrlex_set_dwicc(_ptr_, _value_)	(((INITCOMMONCONTROLSEX *) _ptr_)->dwICC = (DWORD) (_value_))

#define cwel_initcommctrlex_get_dwsize(_ptr_) 	(((INITCOMMONCONTROLSEX *) _ptr_)->dwSize)
#define cwel_initcommctrlex_get_dwicc(_ptr_)	(((INITCOMMONCONTROLSEX *) _ptr_)->dwICC)

#endif /* __WEL_INITCOMMONCONTROLSEX__ */

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
