/*
 * NMHDR.H
 */

#ifndef __WEL_NMHDR__
#define __WEL_NMHDR__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_nmhdr_get_hwndfrom(_ptr_) ((((NMHDR *) _ptr_)->hwndFrom))
#define cwel_nmhdr_get_idfrom(_ptr_) ((((NMHDR *) _ptr_)->idFrom))
#define cwel_nmhdr_get_code(_ptr_) ((((NMHDR *) _ptr_)->code))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_NMHDR__ */

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
