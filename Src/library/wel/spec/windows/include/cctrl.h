/*
 * CCTRL.H
 */

#ifndef __WEL_COMMONCONTROLS__
#define __WEL_COMMONCONTROLS__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifndef _INC_COMMCTRL
#	include <commctrl.h>
#endif

#ifdef EIF_BORLAND
#define UDS_HOTTRACK		0x0100
#define TCIF_STATE			0x0010
#define TCS_VERTICAL		0x0080
#define TCS_SCROLLOPPOSITE	0x0001
#define TCS_RIGHT			0x0002
#define TCS_BOTTOM			0x0002
#define TCS_HOTTRACK		0x0040

#define LVCF_IMAGE			0x0010
#endif

#endif /* __WEL_COMMONCONTROLS__ */

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
