/*
 * TVDISPINFO.H
 */

#ifndef __WEL_TV_DISPINFO__
#define __WEL_TV_DISPINFO__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_tv_dispinfo_get_hdr(_ptr_) (&(((TV_DISPINFO *) _ptr_)->hdr))
#define cwel_tv_dispinfo_get_item(_ptr_) (&(((TV_DISPINFO *) _ptr_)->item))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_TV_DISPINFO__ */

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
